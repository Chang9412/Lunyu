//
//  GDTAdvertiseItem.m
//  TextOCR
//
//  Created by zhengqiang zhang on 2019/1/30.
//  Copyright © 2019 上海宝云网络. All rights reserved.
//

#import "GDTAdvertisementItem.h"


@implementation GDTAdvertisementItem

- (instancetype)init {
    if (self = [super init]) {
        _appid = kGDTAppid;
    }
    return self;
}

- (instancetype)initWithPlacementId:(NSString *)placementId {
    if (self = [super init]) {
        _appid = kGDTAppid;
        self.placementid = placementId;
    }
    return self;
}

- (void)onItemDidLoad {
    if ([self.delegate respondsToSelector:@selector(advertisementItemDidLoad:)]) {
        [self.delegate advertisementItemDidLoad:self];
    }
}

- (void)onItemDidLoadFailed:(NSError *)error {
    if ([self.delegate respondsToSelector:@selector(advertisementItemDidLoadFailed:error:)]) {
        [self.delegate advertisementItemDidLoadFailed:self error:error];
    }
}

- (void)onItemDidImpress {
    if ([self.delegate respondsToSelector:@selector(advertisementItemDidImpress:)]) {
        [self.delegate advertisementItemDidImpress:self];
    }
}

- (void)onItemDidDismiss {
    if ([self.delegate respondsToSelector:@selector(advertisementItemDidDismiss:)]) {
        [self.delegate advertisementItemDidDismiss:self];
    }
}

- (void)onItemDidClicked {
    if ([self.delegate respondsToSelector:@selector(advertisementItemDidClicked:)]) {
        [self.delegate advertisementItemDidClicked:self];
    }
}

- (void)showAd {
    
}

- (void)reload {
    
}

- (void)close {
    
}

- (void)dealloc {
    NSLog(@"%@ dealloc", self);
}

@end
