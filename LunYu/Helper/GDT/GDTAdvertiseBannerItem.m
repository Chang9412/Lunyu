//
//  GDTAdvertiseBannerItem.m
//  TextOCR
//
//  Created by zhengqiang zhang on 2019/1/30.
//  Copyright © 2019 上海宝云网络. All rights reserved.
//

#import "GDTAdvertiseBannerItem.h"
#import <GDTMobBannerView.h>


@interface GDTAdvertiseBannerItem ()<GDTMobBannerViewDelegate>

@property(nonatomic, strong) GDTMobBannerView *bannerView;

@end

@implementation GDTAdvertiseBannerItem

- (instancetype)init {
    if (self = [super init]) {
        self.placementid = kGDTBannerPlacementid;
    }
    return self;
}

- (void)setCurrentViewController:(UIViewController *)currentViewController {
    self.bannerView.currentViewController = currentViewController;
    [currentViewController.view addSubview:self.bannerView];
}

- (void)setBannerFrame:(CGRect)bannerFrame {
    self.bannerView.frame = bannerFrame;
}

- (GDTMobBannerView *)bannerView {
    if (_bannerView == nil) {
        _bannerView = [[GDTMobBannerView alloc] initWithAppId:self.appid placementId:self.placementid];
        _bannerView.interval = 30;
        _bannerView.isGpsOn = YES;
        _bannerView.showCloseBtn = YES;
        _bannerView.isAnimationOn = YES;
        _bannerView.delegate = self;
    }
    return _bannerView;
}

- (void)showAd {
    [self.bannerView loadAdAndShow];
}

#pragma mark -

- (void)bannerViewDidReceived {
    NSLog(@"%s", __func__);
    [self onItemDidLoad];
}

- (void)bannerViewClicked {
    NSLog(@"%s", __func__);
    [self onItemDidClicked];
}

- (void)bannerViewWillClose {
    NSLog(@"%s", __func__);
    [self close];
}

- (void)bannerViewFailToReceived:(NSError *)error {
    NSLog(@"%s", __func__);
    [self onItemDidLoadFailed:error];
}

// 曝光回调
- (void)bannerViewWillExposure {
    [self onItemDidImpress];
}


@end
