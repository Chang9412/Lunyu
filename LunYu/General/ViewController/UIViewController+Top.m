//
//  UIViewController+Top.m
//  iWhy
//
//  Created by zhengqiang zhang on 2018/11/29.
//  Copyright © 2018 上海宝云网络. All rights reserved.
//

#import "UIViewController+Top.h"


@implementation UIViewController (Top)


+ (UIViewController *)topViewController {
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    UIViewController *rootViewController = window.rootViewController;
    while (1) {
        if (rootViewController.presentedViewController) {
            rootViewController = rootViewController.presentedViewController;
        } else if ([rootViewController isKindOfClass:[UINavigationController class]]) {
            rootViewController = [(UINavigationController *)rootViewController viewControllers].firstObject;
        } else if ([rootViewController isKindOfClass:[UITabBarController class]]) {
            rootViewController = [(UITabBarController *)rootViewController selectedViewController];
        } else {
            break;
        }
    }
    return rootViewController;
}

+ (UINavigationController *)topNavigationController {
    UIViewController *vc = [self topViewController];
    if (vc.navigationController) {
        return vc.navigationController;
    }
    return nil;
}

@end
