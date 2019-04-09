//
//  GDTAdvertiseSplashItem.h
//  TextOCR
//
//  Created by zhengqiang zhang on 2019/1/30.
//  Copyright © 2019 上海宝云网络. All rights reserved.
//

#import "GDTAdvertisementItem.h"
#import <GDTSplashAd.h>

NS_ASSUME_NONNULL_BEGIN

@interface GDTAdvertiseSplashItem : GDTAdvertisementItem

@property(nonatomic, strong) UIWindow *window;
@property(nonatomic, strong) UIView *bottomView;

@end

NS_ASSUME_NONNULL_END
