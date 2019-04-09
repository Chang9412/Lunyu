//
//  LYFontHelper.h
//  LunYu
//
//  Created by zhengqiang zhang on 2019/4/1.
//  Copyright © 2019 chang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, LYFontStyle) {
    LYFontRuiKaiTiStyle = 1,
    LYFontRuiNBTiStyle,
    LYFontXiaoMaiTiStyle,
    LYFontZhuShiTiStyle
};

@interface LYFontHelper : NSObject

+ (void)changeFontStyle:(LYFontStyle)style;
+ (void)changeFontName:(NSString *)fontName;

+ (UIFont *)defaultFontWithSize:(NSInteger)size;
+ (NSArray *)allFontNames;

@end

NS_ASSUME_NONNULL_END
