
//
//  GDTNativeManager.m
//  TextOCR
//
//  Created by zhengqiang zhang on 2019/2/1.
//  Copyright © 2019 上海宝云网络. All rights reserved.
//

#import "GDTNativeManager.h"

@interface GDTNativeManager ()<GDTAdvertisementItemDelegate>

@property(nonatomic, strong) GDTAdvertiseNativeItem *nativeItem;
@property(nonatomic, copy) void(^successHandler)(NSArray *nativeDataArray);
@property(nonatomic, copy) void(^failureHandler)(NSError *error);

@end

@implementation GDTNativeManager

- (instancetype)initWithController:(UIViewController *)viewController {
    if (self = [super init]) {
        self.nativeItem.currentViewController = viewController;
    }
    return self;
}

- (void)getNativeDataOnsuccess:(void(^)(NSArray *nativeDataArray))success onFailure:(void(^)(NSError *error))failure {
    [self.nativeItem showAd];
    self.successHandler = success;
    self.failureHandler = failure;
}

- (void)attachAd:(GDTNativeAdData *)nativeAdData toView:(UIView *)dView {
    [self.nativeItem attachAd:nativeAdData toView:dView];
}

- (GDTAdvertiseNativeItem *)nativeItem {
    if (_nativeItem == nil) {
        _nativeItem = [[GDTAdvertiseNativeItem alloc] init];
        _nativeItem.delegate = self;
    }
    return _nativeItem;
}

- (void)advertisementItemDidLoad:(GDTAdvertisementItem *)item {
    GDTAdvertiseNativeItem *nativeItem = (GDTAdvertiseNativeItem *)item;
    if (self.successHandler) {
        self.successHandler(nativeItem.nativeDataArray);
        self.successHandler = nil;
    }
}

- (void)advertisementItemDidClicked:(GDTAdvertisementItem *)item {
    
}

-(void)advertisementItemDidDismiss:(GDTAdvertisementItem *)item {
    self.nativeItem = nil;
}

- (void)advertisementItemDidLoadFailed:(GDTAdvertisementItem *)item error:(NSError *)error {
    AppLog(@"原生广告加载失败: %@", error);
    GDTAdvertiseNativeItem *nativeItem = (GDTAdvertiseNativeItem *)item;
    if (self.failureHandler) {
        self.failureHandler(error);
        self.successHandler = nil;
    }
}

- (void)advertisementItemDidImpress:(GDTAdvertisementItem *)item {
    
}
@end
