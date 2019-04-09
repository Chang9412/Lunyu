//
//  ZQVideoCmpressionMaker.h
//  WallPaper
//
//  Created by zhengqiang zhang on 2019/3/12.
//  Copyright © 2019 上海宝云网络. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZQVideoCmpressionMaker : NSObject

+ (void)videoCompressionSession:(NSArray *)imageArray completion:(void(^)(NSError *error, BOOL success))completion;

+ (NSString *)videoPath;

@end

NS_ASSUME_NONNULL_END
