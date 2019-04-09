//
//  BuglyHelper.m
//  iWhy
//
//  Created by zhengqiang zhang on 2018/12/3.
//  Copyright © 2018 上海宝云网络. All rights reserved.
//

#import "BuglyHelper.h"
#import <Bugly/Bugly.h>
#import "UIDevice+Utils.h"

static NSString * const kBuglyAppID = @"bde5d250c8";

@implementation BuglyHelper

+ (void)start {
    BuglyConfig *config = [[BuglyConfig alloc] init];
    [config setVersion:[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"]];
    
    [Bugly startWithAppId:kBuglyAppID config:config];
}

@end
