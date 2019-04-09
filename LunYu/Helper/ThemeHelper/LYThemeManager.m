//
//  LYThemeManager.m
//  LunYu
//
//  Created by zhengqiang zhang on 2019/4/1.
//  Copyright © 2019 chang. All rights reserved.
//

#import "LYThemeManager.h"
#import "LYTheme.h"

@interface LYThemeManager ()

@property(nonatomic, strong) LYTheme *currentTheme;

@end

@implementation LYThemeManager

+ (instancetype)shareManager {
    static LYThemeManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[LYThemeManager alloc] init];
    });
    return manager;
}

- (instancetype)init {
    if (self = [super init]) {
        NSString *themeString = [[NSUserDefaults standardUserDefaults] objectForKey:@"currentTheme"];
        if (themeString == nil) {
            themeString = @"default";
        }
        [LYThemeManager changeThemeWithName:themeString];
    }
    return self;
}

+ (BOOL)changeThemeWithName:(NSString *)name {
    if (name == nil || name.length == 0) {
        return NO;
    }
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"theme" ofType:@"plist"]][name];
    if (!dict) {
        AppLog(@"没有此主题");
        return NO;
    }
    [LYThemeManager shareManager].currentTheme = [[LYTheme alloc] initWithDict:dict];
    [[NSUserDefaults standardUserDefaults] setObject:name forKey:@"currentTheme"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    return YES;
}

+ (NSArray *)allThemes {
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"theme" ofType:@"plist"]];
    NSMutableArray *themes = [NSMutableArray array];
    for (NSDictionary *dic in [dict allValues]) {
        LYTheme *theme = [[LYTheme alloc] initWithDict:dic];
        [themes addObject:theme];
    }
    return [themes copy];
}
@end
