//
//  NSString+utils.h
//  iTing_rebuild
//
//  Created by zhengqiang zhang on 2018/9/7.
//  Copyright © 2018年 上海宝云网络. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (utils)

- (NSString *)md5;

- (CGFloat)widthOfSingleLineWithAttributes:(NSDictionary<NSAttributedStringKey,id> *)attributes;

- (CGSize)boundingRectWithSize:(CGSize)size
                          font:(UIFont*)font
                   lineSpacing:(CGFloat)lineSpacing;

- (NSAttributedString *)htmlStringAttributed;

+ (NSString *)stringWithDuration:(NSInteger)duration;

+ (NSString *)stringWithPlayCount:(NSInteger)playCount;

@end
