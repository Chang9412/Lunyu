//
//  SVProgressHUD+setup.m
//  iTing_rebuild
//
//  Created by zhengqiang zhang on 2018/9/10.
//  Copyright © 2018年 上海宝云网络. All rights reserved.
//

#import "SVProgressHUD+setup.h"

@implementation SVProgressHUD (setup)

+ (void)load {
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
//    [SVProgressHUD setInfoImage:s];
//    [SVProgressHUD setErrorImage:];
    [SVProgressHUD setRingRadius:10];
}


@end
