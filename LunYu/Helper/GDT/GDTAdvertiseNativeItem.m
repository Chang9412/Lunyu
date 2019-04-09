//
//  GDTAdvertiseNativeItem.m
//  TextOCR
//
//  Created by zhengqiang zhang on 2019/1/31.
//  Copyright © 2019 上海宝云网络. All rights reserved.
//

#import "GDTAdvertiseNativeItem.h"

#import <GDTMobSDK/GDTNativeAd.h>

@interface GDTAdvertiseNativeItem ()<GDTNativeAdDelegate>

@property(nonatomic, strong) GDTNativeAd *nativeAd;

@end

@implementation GDTAdvertiseNativeItem

- (instancetype)init {
    if (self = [super init]) {
//        self.placementid = kGDTNativePlacementid;
    }
    return self;
}

- (void)showAd {
    [self.nativeAd loadAd:4];
}

- (void)attachAd:(GDTNativeAdData *)nativeAdData toView:(UIView *)dView {
    [self.nativeAd attachAd:nativeAdData toView:dView];
}

- (void)setCurrentViewController:(UIViewController *)currentViewController {
    [self.nativeAd setController:currentViewController];
}

- (GDTNativeAd *)nativeAd {
    if (_nativeAd == nil) {
        _nativeAd = [[GDTNativeAd alloc] initWithAppId:self.appid placementId:self.placementid];
        _nativeAd.delegate = self;
    }
    return _nativeAd;
}

- (void)nativeAdFailToLoad:(NSError *)error {
    [self onItemDidLoadFailed:error];
}

/**
 *  原生广告加载广告数据成功回调，返回为GDTNativeAdData对象的数组
 */
- (void)nativeAdSuccessToLoad:(NSArray *)nativeAdDataArray {
    AppLog(@"%@",nativeAdDataArray);
    _nativeDataArray = nativeAdDataArray;
    [self onItemDidLoad];
}

- (void)nativeAdWillPresentScreen {
    [self onItemDidImpress];
}

- (void)nativeAdClosed {
    [self onItemDidDismiss];
}


@end
