//
//  GDTAdvertiseNativeItem.h
//  TextOCR
//
//  Created by zhengqiang zhang on 2019/1/31.
//  Copyright © 2019 上海宝云网络. All rights reserved.
//

#import "GDTAdvertisementItem.h"

@class  GDTNativeAdData;
NS_ASSUME_NONNULL_BEGIN

@interface GDTAdvertiseNativeItem : GDTAdvertisementItem

@property(nonatomic, strong, readonly) NSArray *nativeDataArray;
- (void)attachAd:(GDTNativeAdData *)nativeAdData toView:(UIView *)dView;

@end

NS_ASSUME_NONNULL_END
