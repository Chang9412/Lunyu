//
//  LYFontHelper.m
//  LunYu
//
//  Created by zhengqiang zhang on 2019/4/1.
//  Copyright © 2019 chang. All rights reserved.
//

#import "LYFontHelper.h"
//#import "NSArray+JSON.h"
@interface LYFontHelper ()

@property(nonatomic, strong) NSString *fontName;
@property(nonatomic, strong) NSArray *fontNames;
@end

@implementation LYFontHelper

+ (instancetype)shareManager {
    static LYFontHelper *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[LYFontHelper alloc] init];
    });
    return manager;
}

- (instancetype)init {
    if (self = [super init]) {
        _fontName = [[NSUserDefaults standardUserDefaults] objectForKey:@"defaultFontName"];
        if (_fontName == nil) {
            _fontName = @"CloudKaiTiGBK";
            [[NSUserDefaults standardUserDefaults] setObject:_fontName forKey:@"defaultFontName"];
        }
    }
    return self;
}

- (NSArray *)fontNames {
    if (_fontNames == nil) {
        _fontNames = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"fontnames.plist" ofType:nil]];
    }
    return _fontNames;
}

+ (UIFont *)defaultFontWithSize:(NSInteger)size {
    return [UIFont fontWithName:[LYFontHelper shareManager].fontName size:size];
}

+ (void)changeFontStyle:(LYFontStyle)style {
    NSString *fontName = [self fontNameWithStyle:style];
    [self changeFontName:fontName];
}

+ (void)changeFontName:(NSString *)fontName {
    if ([fontName isEqualToString:[LYFontHelper shareManager].fontName]) {
        return;
    }
    [LYFontHelper shareManager].fontName = fontName;
    [[NSUserDefaults standardUserDefaults] setObject:fontName forKey:@"defaultFontName"];
}

+ (NSString *)fontNameWithStyle:(LYFontStyle)style {
    NSString *fontName = @"";
    switch (style) {
        case LYFontRuiNBTiStyle:
            fontName = @"CloudLiBianGBK";
            break;
        case LYFontRuiKaiTiStyle:
            fontName = @"CloudKaiTiGBK";
            break;
        case LYFontXiaoMaiTiStyle:
            fontName = @"HYXiaoMaiTiJ";
            break;
        case LYFontZhuShiTiStyle:
            fontName = @"YRDZST-Semibold";
            break;
        default:
            break;
    }
    return fontName;
}

+ (NSArray *)allFontNames {
    return [LYFontHelper shareManager].fontNames;
}

@end
