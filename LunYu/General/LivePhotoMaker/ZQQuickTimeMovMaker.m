//
//  ZQQuickTimeMovMaker.m
//  LivePhotoMaker_test
//
//  Created by zhengqiang zhang on 2019/3/12.
//  Copyright © 2019 chang. All rights reserved.
//

#import "ZQQuickTimeMovMaker.h"
#import <AVFoundation/AVFoundation.h>

static NSString *const kContentIdentifierKey = @"com.apple.quicktime.content.identifier";
static NSString *const kStillImageTimeKey = @"com.apple.quicktime.still-image-time";
static NSString *const kSpaceQuickTimeMetadataKey = @"mdta";

static NSString *const kFirstCustomKey  = @"XIN_first";
static NSString *const kSecondCustomKey = @"XIN_second";


@implementation ZQQuickTimeMovMaker

+ (CMTimeRange)dummyTimeRange {
    return CMTimeRangeMake(CMTimeMake(0, 1000), CMTimeMake(200, 3000));
}

+ (AVURLAsset *)assetWithUrl:(NSURL *)url {
    return [AVURLAsset assetWithURL:url];
}

+ (NSString *)readAssetIdentifier:(AVAsset *)asset {
    NSArray *metadata = [asset metadataForFormat:AVMetadataFormatQuickTimeMetadata];
    for (AVMetadataItem *item in metadata) {
        if ((NSString *)(item.key) == kContentIdentifierKey &&
            item.keySpace == kSpaceQuickTimeMetadataKey) {
            return [NSString stringWithFormat:@"%@",item.value];
        }
    }
    return nil;
}

+ (NSNumber *)readStillImageTime:(AVAsset *)asset {
    AVAssetTrack *track = [asset tracksWithMediaType:AVMediaTypeMetadata].firstObject;
    if (track) {
        NSDictionary *dict = [self readerAsset:asset track:track settings:nil];
        AVAssetReader *reader = [dict objectForKey:kFirstCustomKey];
        [reader startReading];
        AVAssetReaderOutput *output = [dict objectForKey:kSecondCustomKey];
        while (YES) {
            CMSampleBufferRef buffer = [output copyNextSampleBuffer];
            if (!buffer) {
                return nil;
            }
            if (CMSampleBufferGetNumSamples(buffer) != 0) {
                AVTimedMetadataGroup *group = [[AVTimedMetadataGroup alloc] initWithSampleBuffer:buffer];
                for (AVMetadataItem *item in group.items) {
                    if ((NSString *)(item.key) == kStillImageTimeKey &&
                        item.keySpace == kSpaceQuickTimeMetadataKey) {
                        return item.numberValue;
                    }
                }
            }
        }
    }
    return nil;
}

+ (void)writeVideoUrl:(NSURL *)videoUrl dest:(NSString *)dest assetIdentifier:(NSString *)assetIdentifier result:(void(^)(BOOL res))result {
    AVAssetReader *audioReader = nil;
    AVAssetWriterInput *audioWriterInput = nil;
    AVAssetReaderOutput *audioReaderOutput = nil;
    
    AVAsset *asset = [AVAsset assetWithURL:videoUrl];
    @try {
        // reader for source video
        AVAssetTrack *track =  [asset tracksWithMediaType:AVMediaTypeVideo].firstObject;
        if (!track) {
            NSLog(@"not found video track");
            if (result) {
                result(NO);
            }
            return;
        }
        NSDictionary *dict = [self readerAsset:asset track:track settings:@{(__bridge NSString *)kCVPixelBufferPixelFormatTypeKey:[NSNumber numberWithUnsignedInt:kCVPixelFormatType_32BGRA]}];
        
        if (dict == nil) {
            if (result) {
                result(NO);
            }
            return;
        }
        
        AVAssetReader *reader = [dict objectForKey:kFirstCustomKey];
        AVAssetReaderOutput *output = [dict objectForKey:kSecondCustomKey];
        // writer for mov
        NSError *writerError = nil;
        AVAssetWriter *writer = [[AVAssetWriter alloc] initWithURL:[NSURL fileURLWithPath:dest] fileType:AVFileTypeQuickTimeMovie error:&writerError];
        writer.metadata = @[[self metadataFor:assetIdentifier]];
        
        // video track
        AVAssetWriterInput *input = [[AVAssetWriterInput alloc] initWithMediaType:AVMediaTypeVideo outputSettings:[self videoSettings:track.naturalSize]];
        input.expectsMediaDataInRealTime = YES;
        input.transform = track.preferredTransform;
        [writer addInput:input];
        
        AVAsset *aAudioAsset = [AVAsset assetWithURL:videoUrl];
        
        if (aAudioAsset.tracks.count > 1) {
            NSLog(@"Has Audio");
            // setup audio writer
            audioWriterInput = [[AVAssetWriterInput alloc] initWithMediaType:AVMediaTypeAudio outputSettings:nil];
            
            audioWriterInput.expectsMediaDataInRealTime = NO;
            if ([writer canAddInput:audioWriterInput]) {
                [writer addInput:audioWriterInput];
            }
            // setup audio reader
            AVAssetTrack *audioTrack = [aAudioAsset tracksWithMediaType:AVMediaTypeAudio].firstObject;
            audioReaderOutput = [[AVAssetReaderTrackOutput alloc] initWithTrack:audioTrack outputSettings:nil];
            @try {
                NSError *audioReaderError = nil;
                audioReader = [AVAssetReader assetReaderWithAsset:aAudioAsset error:&audioReaderError];
                if (audioReaderError) {
                    NSLog(@"Unable to read Asset, error: %@",audioReaderError);
                }
            } @catch (NSException *exception) {
                NSLog(@"Unable to read Asset: %@", exception.description);
            } @finally {
                
            }
            
            if ([audioReader canAddOutput:audioReaderOutput]) {
                [audioReader addOutput:audioReaderOutput];
            } else {
                NSLog(@"cant add audio reader");
            }
        }
        
        // metadata track
        AVAssetWriterInputMetadataAdaptor *adapter = [self metadataAdapter];
        [writer addInput:adapter.assetWriterInput];
        
        // creating video
        [writer startWriting];
        [reader startReading];
        [writer startSessionAtSourceTime:kCMTimeZero];
        
        // write metadata track
        AVMetadataItem *metadataItem = [self metadataForStillImageTime];
        
        [adapter appendTimedMetadataGroup:[[AVTimedMetadataGroup alloc] initWithItems:@[metadataItem] timeRange:[self dummyTimeRange]]];
        
        // write video track
        [input requestMediaDataWhenReadyOnQueue:dispatch_queue_create("assetVideoWriterQueue", 0) usingBlock:^{
            while (input.isReadyForMoreMediaData) {
                if (reader.status == AVAssetReaderStatusReading) {
                    CMSampleBufferRef buffer = [output copyNextSampleBuffer];
                    if (buffer) {
                        if (![input appendSampleBuffer:buffer]) {
                            NSLog(@"cannot write: %@", writer.error);
                            [reader cancelReading];
                        }
                        //释放内存，否则出现内存问题
                        CFRelease(buffer);
                    }
                } else {
                    [input markAsFinished];
                    if (reader.status == AVAssetReaderStatusCompleted && aAudioAsset.tracks.count > 1) {
                        [audioReader startReading];
                        [writer startSessionAtSourceTime:kCMTimeZero];
                        dispatch_queue_t media_queue = dispatch_queue_create("assetAudioWriterQueue", 0);
                        [audioWriterInput requestMediaDataWhenReadyOnQueue:media_queue usingBlock:^{
                            while ([audioWriterInput isReadyForMoreMediaData]) {
                                
                                CMSampleBufferRef sampleBuffer2 = [audioReaderOutput copyNextSampleBuffer];
                                if (audioReader.status == AVAssetReaderStatusReading && sampleBuffer2 != nil) {
                                    if (![audioWriterInput appendSampleBuffer:sampleBuffer2]) {
                                        [audioReader cancelReading];
                                    }
                                } else {
                                    [audioWriterInput markAsFinished];
                                    NSLog(@"Audio writer finish");
                                    [writer finishWritingWithCompletionHandler:^{
                                        NSError *e = writer.error;
                                        if (e) {
                                            NSLog(@"cannot write: %@",e);
                                        } else {
                                            NSLog(@"finish writing.");
                                        }
                                    }];
                                }
                                if (sampleBuffer2) {//释放内存，否则出现内存问题
                                    CFRelease(sampleBuffer2);
                                }
                            }
                        }];
                    } else {
                        NSLog(@"Video Reader not completed");
                        [writer finishWritingWithCompletionHandler:^{
                            NSError *e = writer.error;
                            if (e) {
                                NSLog(@"cannot write: %@",e);
                            } else {
                                NSLog(@"finish writing.");
                            }
                        }];
                    }
                }
            }
        }];
        while (writer.status == AVAssetWriterStatusWriting) {
            @autoreleasepool {
                [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.5]];
            }
        }
        if (writer.error) {
            if (result) {
                result(NO);
            }
            NSLog(@"cannot write: %@", writer.error);
        } else {
            if (result) {
                result(YES);
            }
            NSLog(@"write finish");
        }
    } @catch (NSException *exception) {
        if (result) {
            result(NO);
        }
        NSLog(@"error: %@", exception.description);
    } @finally {
        
    }
    
}

//+ (NSArray<AVMetadataItem*> *)metadata {
//    return [self.XIN_asset metadataForFormat:AVMetadataFormatQuickTimeMetadata];
//}


+ (NSDictionary *)readerAsset:(AVAsset *)asset track:(AVAssetTrack *)track settings:(NSDictionary *)settings {
    AVAssetReaderTrackOutput *output = [AVAssetReaderTrackOutput assetReaderTrackOutputWithTrack:track outputSettings:settings];
    NSError *readerError = nil;
    AVAssetReader *reader = [AVAssetReader assetReaderWithAsset:asset error:&readerError];
    if (reader == nil) {
        return nil;
    }
    [reader addOutput:output];
    return @{kFirstCustomKey:reader, kSecondCustomKey:output};
}

+ (AVAssetWriterInputMetadataAdaptor *)metadataAdapter {
    NSDictionary *spec = @{
                           (__bridge NSString *)kCMMetadataFormatDescriptionMetadataSpecificationKey_Identifier:[NSString stringWithFormat:@"%@/%@",kSpaceQuickTimeMetadataKey,kStillImageTimeKey],
                           (__bridge NSString *)kCMMetadataFormatDescriptionMetadataSpecificationKey_DataType:@"com.apple.metadata.datatype.int8"
                           };
    
    CMFormatDescriptionRef desc = nil;
    
    CMMetadataFormatDescriptionCreateWithMetadataSpecifications(kCFAllocatorDefault, kCMMetadataFormatType_Boxed, (__bridge CFArrayRef)@[spec], &desc);
    AVAssetWriterInput *input = [AVAssetWriterInput assetWriterInputWithMediaType:AVMediaTypeMetadata outputSettings:nil sourceFormatHint:desc];
    return [AVAssetWriterInputMetadataAdaptor assetWriterInputMetadataAdaptorWithAssetWriterInput:input];
}

+ (NSDictionary *)videoSettings:(CGSize)size {
    if (@available(iOS 11.0, *)) {
        return @{
                 AVVideoCodecKey : AVVideoCodecTypeH264,
                 AVVideoWidthKey : @(size.width),
                 AVVideoHeightKey : @(size.height)
                 };
    } else {
        // Fallback on earlier versions
        return @{
                 AVVideoCodecKey : AVVideoCodecH264,
                 AVVideoWidthKey : @(size.width),
                 AVVideoHeightKey : @(size.height)
                 };
    }
}

+ (AVMetadataItem *)metadataFor:(NSString *)assetIdentifier {
    AVMutableMetadataItem *item = [AVMutableMetadataItem metadataItem];
    item.key = kContentIdentifierKey;
    item.keySpace = kSpaceQuickTimeMetadataKey;
    item.value = assetIdentifier;
    item.dataType = @"com.apple.metadata.datatype.UTF-8";
    return item;
}

+ (AVMetadataItem *)metadataForStillImageTime {
    AVMutableMetadataItem *item = [AVMutableMetadataItem metadataItem];
    item.key = kStillImageTimeKey;
    item.keySpace = kSpaceQuickTimeMetadataKey;
    item.value = @(0);
    item.dataType = @"com.apple.metadata.datatype.int8";
    return item;
}

@end
