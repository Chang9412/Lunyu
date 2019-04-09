//
//  GDTAdvertiseItem.h
//  TextOCR
//
//  Created by zhengqiang zhang on 2019/1/30.
//  Copyright © 2019 上海宝云网络. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


#ifdef GDT_TEST
static NSString * const kGDTAppid = @"1105344611";
static NSString * const kGDTBannerPlacementid = @"4090812164690039"; //
static NSString * const kGDTSplashPlacementid = @"9040714184494018";
static NSString * const kGDTNativeVOACellPlacementid = @"5030722621265924";


#else
static NSString * const kGDTAppid = @"1108138547";
static NSString * const kGDTBannerPlacementid = @"4080753561314486"; //
static NSString * const kGDTSplashPlacementid = @"5040650561616457";
static NSString * const kGDTNativeVOACellPlacementid = @"9080256541111438";


#endif

@class GDTAdvertisementItem;

@protocol GDTAdvertisementItemDelegate <NSObject>

@optional
- (void)advertisementItemDidLoad:(GDTAdvertisementItem *)item;
- (void)advertisementItemDidLoadFailed:(GDTAdvertisementItem *)item error:(NSError *)error;
- (void)advertisementItemDidImpress:(GDTAdvertisementItem *)item;
- (void)advertisementItemDidClicked:(GDTAdvertisementItem *)item;
- (void)advertisementItemDidDismiss:(GDTAdvertisementItem *)item;

@end

@interface GDTAdvertisementItem : NSObject

@property(nonatomic, strong) NSString *appid;
@property(nonatomic, strong) NSString *placementid;
@property(nonatomic, strong) UIViewController *currentViewController;

@property(nonatomic, weak) id<GDTAdvertisementItemDelegate> delegate;

- (instancetype)initWithPlacementId:(NSString *)placementId;

- (void)showAd;
- (void)reload;

- (void)close;

- (void)onItemDidLoad;
- (void)onItemDidLoadFailed:(NSError *)error;
- (void)onItemDidImpress;
- (void)onItemDidDismiss;
- (void)onItemDidClicked;

@end

NS_ASSUME_NONNULL_END
