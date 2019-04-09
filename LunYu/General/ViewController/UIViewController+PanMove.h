//
//  UIViewController+PanMove.h
//  iWhy
//
//  Created by zhengqiang zhang on 2018/12/26.
//  Copyright © 2018 上海宝云网络. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, ZQGesturePopupDirection) {
    ZQGesturePopupDirectionHorizontal,
    ZQGesturePopupDirectionVertical,
};

@interface UIViewController (PanMove)

@property(nonatomic, assign) ZQGesturePopupDirection direction;

- (void)addPanGesture;

@end
