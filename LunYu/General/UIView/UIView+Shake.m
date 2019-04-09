//
//  UIView+Shake.m
//  iWhy
//
//  Created by zhengqiang zhang on 2018/12/14.
//  Copyright © 2018 上海宝云网络. All rights reserved.
//

#import "UIView+Shake.h"

@implementation UIView (Shake)

- (void)shake {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    animation.fromValue = @(1);
    animation.toValue = @(0.2);
    animation.repeatCount = 1;
    animation.duration = 1;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.autoreverses = YES;
    [self.layer addAnimation:animation forKey:@"shake"];
}

- (void)rotation {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    animation.byValue = @(M_PI);
    animation.repeatCount = NSIntegerMax;
    animation.duration = 5;
    animation.cumulative = YES;
    [self.layer addAnimation:animation forKey:@"rotation"];
}

- (void)pauseAnimation {
    if (self.layer.speed == 0) {
        return;
    }
    CFTimeInterval pauseTime = [self.layer convertTime:CACurrentMediaTime() fromLayer:nil];
    self.layer.timeOffset = pauseTime;
    self.layer.speed = 0;
}

- (void)resumeAnimation {
    if (self.layer.speed == 1) {
        return;
    }
    CFTimeInterval pauseTime = self.layer.timeOffset;
    CFTimeInterval timeSincePause = CACurrentMediaTime() - pauseTime;
    self.layer.timeOffset = 0;
    self.layer.beginTime = timeSincePause;
    self.layer.speed = 1;
}
@end
