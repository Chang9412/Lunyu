//
//  GDTAdvertiseSplashItem.m
//  TextOCR
//
//  Created by zhengqiang zhang on 2019/1/30.
//  Copyright © 2019 上海宝云网络. All rights reserved.
//

#import "GDTAdvertiseSplashItem.h"



@interface GDTAdvertiseSplashItem ()<GDTSplashAdDelegate>

@property(nonatomic, strong) GDTSplashAd *splashAd;

@end

@implementation GDTAdvertiseSplashItem

- (instancetype)init {
    if (self = [super init]) {
        self.placementid = kGDTSplashPlacementid;
    }
    return self;
}

- (void)loadAdAndShowInWindow:(UIWindow <GDTSplashAdDelegate>*)window withBottomView:(UIView *)bottomView {
    [self.splashAd loadAdAndShowInWindow:window withBottomView:bottomView];

}

- (GDTSplashAd *)splashAd {
    if (_splashAd == nil) {
        _splashAd = [[GDTSplashAd alloc] initWithAppId:self.appid placementId:self.placementid];
        _splashAd.delegate = self;
        _splashAd.fetchDelay = 3;
        _splashAd.backgroundColor = [UIColor whiteColor];
//        _splashAd.skipButtonCenter =
    }
    return _splashAd;
}

- (void)showAd {
    [self.splashAd loadAdAndShowInWindow:self.window withBottomView:self.bottomView];
}

- (void)close {
    [UIView animateWithDuration:0.3 animations:^{
        self.window.alpha = 0;
    } completion:^(BOOL finished) {
        [self onItemDidDismiss];
    }];
}
#pragma mark -

- (void)splashAdClosed:(GDTSplashAd *)splashAd {
    [self onItemDidDismiss];
}

- (void)splashAdWillClosed:(GDTSplashAd *)splashAd {
    [self close];
}

- (void)splashAdSuccessPresentScreen:(GDTSplashAd *)splashAd {
    [self onItemDidLoad];
}

- (void)splashAdClicked:(GDTSplashAd *)splashAd {
    [self onItemDidClicked];
}

- (void)splashAdFailToPresent:(GDTSplashAd *)splashAd withError:(NSError *)error {
    [self close];
    [self onItemDidLoadFailed:error];
}

- (void)splashAdExposured:(GDTSplashAd *)splashAd {

}


- (void)splashAdLifeTime:(NSUInteger)time {
    NSLog(@"time %ld", time);
    if (time <= 0) {
        [GDTAdvertiseSplashItem cancelPreviousPerformRequestsWithTarget:self selector:@selector(close) object:nil];
        [self close];
    }
}



@end
