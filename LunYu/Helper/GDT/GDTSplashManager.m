//
//  GDTSplashManager.m
//  TextOCR
//
//  Created by zhengqiang zhang on 2019/2/1.
//  Copyright © 2019 上海宝云网络. All rights reserved.
//

#import "GDTSplashManager.h"
#import "GDTAdvertiseSplashItem.h"
#import "GDTSplashRootViewController.h"
#import "GDTLaunchView.h"

static NSInteger const splashShowGap = 60 * 2;

@interface GDTSplashManager ()<GDTAdvertisementItemDelegate>

@property(nonatomic, strong) GDTAdvertiseSplashItem *splashItem;
@property(nonatomic, strong) UIWindow *splashWindow;
@property(nonatomic, strong) GDTLaunchView *launchView;

@property(nonatomic, strong) NSDate *lastEnterBackgroundDate;
@property(nonatomic, strong) NSDate *lastShowLaunchAdDate;


@end

@implementation GDTSplashManager

+ (void)load {
    [self shareManager];
}

+ (instancetype)shareManager {
    static GDTSplashManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[GDTSplashManager alloc] init];
    });
    return manager;
}

- (instancetype)init {
    if (self = [super init]) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onBecomeActive:) name:UIApplicationDidBecomeActiveNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onBecomeActive:) name:UIApplicationDidFinishLaunchingNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onEnterBackground:) name:UIApplicationWillResignActiveNotification object:nil];
    }
    return self;
}

- (void)onBecomeActive:(NSNotification *)notification {
    if (notification.userInfo &&
        notification.userInfo[UIApplicationLaunchOptionsRemoteNotificationKey]) {
        // 推送
        return;
    }
    BOOL isLaunching = [notification.name isEqualToString:UIApplicationDidFinishLaunchingNotification];
    NSTimeInterval delay = ABS([self.lastEnterBackgroundDate timeIntervalSinceNow]);
    if (isLaunching) {
        delay = splashShowGap;
    }

    if (delay >= splashShowGap) {
        [self showAd];
    }
}

- (void)onEnterBackground:(NSNotification *)notification {
    self.lastEnterBackgroundDate = [NSDate date];
}

- (void)showAd {
    if (self.splashWindow == nil) {
        UIWindow *window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        window.windowLevel = UIWindowLevelStatusBar + 1;
        window.hidden = NO;
        window.backgroundColor = [UIColor clearColor];
        window.rootViewController = [[GDTSplashRootViewController alloc] init];
        self.splashWindow = window;
    }

    [self.splashWindow addSubview:self.launchView];
    self.splashItem = [[GDTAdvertiseSplashItem alloc] init];
    self.splashItem.window = self.splashWindow;
    self.splashItem.bottomView = self.launchView.bottomView;
    self.splashItem.delegate = self;
    [self.splashItem showAd];
    
}

- (GDTLaunchView *)launchView {
    if (_launchView == nil) {
        _launchView = [[GDTLaunchView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _launchView.backgroundColor = [UIColor clearColor];
        _launchView.shouldShowBottomView = YES;
    }
    return _launchView;
}

- (void)advertisementItemDidLoad:(GDTAdvertisementItem *)item {
    
}

- (void)advertisementItemDidClicked:(GDTAdvertisementItem *)item {
    
}

-(void)advertisementItemDidDismiss:(GDTAdvertisementItem *)item {
    self.splashWindow = nil;
    self.splashItem = nil;
}

- (void)advertisementItemDidLoadFailed:(GDTAdvertisementItem *)item error:(NSError *)error {
    AppLog(@"开屏广告加载失败: %@", error);
    self.splashWindow = nil;
    self.splashItem = nil;
}

- (void)advertisementItemDidImpress:(GDTAdvertisementItem *)item {
    
}

@end
