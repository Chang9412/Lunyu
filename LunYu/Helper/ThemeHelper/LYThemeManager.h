//
//  LYThemeManager.h
//  LunYu
//
//  Created by zhengqiang zhang on 2019/4/1.
//  Copyright © 2019 chang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LYThemeManager : NSObject

+ (instancetype)shareManager;

+ (BOOL)changeThemeWithName:(NSString *)name;
+ (NSArray *)allThemes;


@end

NS_ASSUME_NONNULL_END
