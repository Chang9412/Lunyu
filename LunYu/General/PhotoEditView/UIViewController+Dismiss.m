//
//  UIViewController+Dismiss.m
//  WallPaper
//
//  Created by zhengqiang zhang on 2019/2/27.
//  Copyright © 2019 上海宝云网络. All rights reserved.
//

#import "UIViewController+Dismiss.h"

@implementation UIViewController (Dismiss)

- (void)dismiss:(BOOL)animated {
    if (self.navigationController) {
        [self.navigationController popViewControllerAnimated:animated];
        return;
    }
    [self dismissViewControllerAnimated:animated completion:nil];
}

- (void)dismiss {
    [self dismiss:YES];
}

@end
