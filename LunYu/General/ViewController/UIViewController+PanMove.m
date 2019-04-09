//
//  UIViewController+PanMove.m
//  iWhy
//
//  Created by zhengqiang zhang on 2018/12/26.
//  Copyright © 2018 上海宝云网络. All rights reserved.
//

#import "UIViewController+PanMove.h"
#import <objc/runtime.h>

@implementation UIViewController (PanMove)

static char kPanMoveDirection;
- (void)setDirection:(ZQGesturePopupDirection)direction {
    objc_setAssociatedObject(self, &kPanMoveDirection, @(direction), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (ZQGesturePopupDirection)direction {
    return [objc_getAssociatedObject(self, &kPanMoveDirection) integerValue];
}

- (void)addPanGesture {
    [self.view addGestureRecognizer:[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panEvent:)]];
}


- (void)panEvent:(UIPanGestureRecognizer *)gesture {
    switch (gesture.state) {
        case UIGestureRecognizerStateBegan:
        {
            CGPoint velocity = [gesture velocityInView:self.view];
            if (ABS(velocity.x)<ABS(velocity.y) ) {
                self.direction = ZQGesturePopupDirectionVertical;
            }else {
                self.direction = ZQGesturePopupDirectionHorizontal;
            }
        }
            break;
        case UIGestureRecognizerStateChanged:
        {
            CGPoint offset = [gesture translationInView:self.view];
            [self stateChange:offset];
        }
            break;
        case UIGestureRecognizerStateEnded:
            [self stateEndWithOffset:50];
            break;
        case UIGestureRecognizerStateCancelled:
        {
            [self reset];
        }
            break;
        default:
            break;
    }
    
}

- (void)stateChange:(CGPoint)offset {
    if (self.direction == ZQGesturePopupDirectionHorizontal) {
//        if (offset.x < 0) {
//            offset.x = 0;
//        }
//        self.view.transform = CGAffineTransformMakeTranslation(offset.x, 0);
    }else if (self.direction == ZQGesturePopupDirectionVertical) {
        if (offset.y < 0) {
            offset.y = 0;
        }
        self.view.transform = CGAffineTransformMakeTranslation(0, offset.y);
    }
}

- (void)stateEndWithOffset:(CGFloat)offset {
    if (self.direction == ZQGesturePopupDirectionHorizontal) {
//        if (CGRectGetMinX(self.view.frame) > offset) {
//            [self movedInHorizontal];
//        }else {
//            [self reset];
//        }
    }else {
        if (CGRectGetMinY(self.view.frame) > offset) {
            [self movedInVertical];
        }else {
            [self reset];
        }
    }
}

- (void)movedInHorizontal {
    [UIView animateWithDuration:0.3 animations:^{
        self.view.transform = CGAffineTransformMakeTranslation(CGRectGetWidth(self.view.frame), 0);
    }completion:^(BOOL finished) {
        [self dismissViewControllerAnimated:NO completion:nil];
    }];
}

- (void)movedInVertical {
    [UIView animateWithDuration:0.3 animations:^{
        self.view.transform = CGAffineTransformMakeTranslation(0, CGRectGetHeight(self.view.frame));
    }completion:^(BOOL finished) {
        [self dismissViewControllerAnimated:NO completion:^{
            self.view.transform = CGAffineTransformIdentity;
        }];
    }];
}

- (void)reset {
    [UIView animateWithDuration:0.3 animations:^{
        self.view.transform = CGAffineTransformIdentity;
    }];
}

@end
