//
//  GIFMaker.h
//  MakeGIF
//
//  Created by zhengqiang zhang on 2019/1/9.
//  Copyright © 2019 上海宝云网络. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GIFMaker : NSObject

+ (void)makeGifToPath:(NSString *)path images:(NSArray *)images;


@end

NS_ASSUME_NONNULL_END
