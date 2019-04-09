//
//  GDTNativeManager.h
//  TextOCR
//
//  Created by zhengqiang zhang on 2019/2/1.
//  Copyright © 2019 上海宝云网络. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GDTAdvertiseNativeItem.h"

NS_ASSUME_NONNULL_BEGIN

@interface GDTNativeManager : NSObject

- (instancetype)initWithController:(UIViewController *)viewController;
- (void)getNativeDataOnsuccess:(void(^)(NSArray *nativeDataArray))success
                     onFailure:(void(^)(NSError *error))failure;
- (void)attachAd:(GDTNativeAdData *)nativeAdData toView:(UIView *)dView;

@end

NS_ASSUME_NONNULL_END
