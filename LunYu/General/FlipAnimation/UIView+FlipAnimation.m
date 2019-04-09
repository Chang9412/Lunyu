//
//  UIView+FlipAnimation.m
//  iWhy
//
//  Created by zhengqiang zhang on 2018/11/14.
//  Copyright © 2018 上海宝云网络. All rights reserved.
//

#import "UIView+FlipAnimation.h"

@implementation UIView (FlipAnimation)

// fade
- (void)fadeFlipAnimation:(dispatch_block_t)animation completion:(dispatch_block_t)completion {
    [self flipAnimation:animation completion:completion type:kCATransitionFade subtype:nil];
}

//rippleEffect 水波纹
- (void)rippleEffectFlipAnimation:(dispatch_block_t)animation completion:(dispatch_block_t)completion {
    [self flipAnimation:animation completion:completion type:@"rippleEffect" subtype:nil];
}

// push
- (void)pushFlipAnimationFromLeft:(dispatch_block_t)animation completion:(dispatch_block_t)completion {
    [self flipAnimation:animation completion:completion type:kCATransitionPush subtype:kCATransitionFromLeft];
}

- (void)pushFlipAnimationFromRight:(dispatch_block_t)animation completion:(dispatch_block_t)completion {
    [self flipAnimation:animation completion:completion type:kCATransitionPush subtype:kCATransitionFromRight];
}

// Reveal 揭开
- (void)revealFlipAnimationFromLeft:(dispatch_block_t)animation completion:(dispatch_block_t)completion {
    [self flipAnimation:animation completion:completion type:kCATransitionReveal subtype:kCATransitionFromLeft];
}

- (void)revealFlipAnimationFromRight:(dispatch_block_t)animation completion:(dispatch_block_t)completion {
    [self flipAnimation:animation completion:completion type:kCATransitionReveal subtype:kCATransitionFromRight];
}

// moveIn 覆盖
- (void)moveInFlipAnimationFromLeft:(dispatch_block_t)animation completion:(dispatch_block_t)completion {
    [self flipAnimation:animation completion:completion type:kCATransitionMoveIn subtype:kCATransitionFromLeft];
}

- (void)moveInFlipAnimationFromRight:(dispatch_block_t)animation completion:(dispatch_block_t)completion {
    [self flipAnimation:animation completion:completion type:kCATransitionMoveIn subtype:kCATransitionFromRight];
}

// cube
- (void)cubeFlipAnimationFromLeft:(dispatch_block_t)animation completion:(dispatch_block_t)completion {
    [self flipAnimation:animation completion:completion type:@"cube" subtype:kCATransitionFromLeft];
}

- (void)cubeFlipAnimationFromRight:(dispatch_block_t)animation completion:(dispatch_block_t)completion {
    [self flipAnimation:animation completion:completion type:@"cube" subtype:kCATransitionFromRight];
}

// pageCurl
- (void)pageCurlFlipAnimationFromLeft:(dispatch_block_t)animation completion:(dispatch_block_t)completion {
    [self flipAnimation:animation completion:completion type:@"pageCurl" subtype:kCATransitionFromLeft];
}

- (void)pageCurlFlipAnimationFromRight:(dispatch_block_t)animation completion:(dispatch_block_t)completion {
    [self flipAnimation:animation completion:completion type:@"pageCurl" subtype:kCATransitionFromRight];
}

- (void)pageUnCurlFlipAnimationFromLeft:(dispatch_block_t)animation completion:(dispatch_block_t)completion {
    [self flipAnimation:animation completion:completion type:@"pageUnCurl" subtype:kCATransitionFromLeft];
}

- (void)pageUnCurlFlipAnimationFromRight:(dispatch_block_t)animation completion:(dispatch_block_t)completion {
    [self flipAnimation:animation completion:completion type:@"pageUnCurl" subtype:kCATransitionFromRight];
}

// oglFlip
- (void)oglFlipFlipAnimationFromLeft:(dispatch_block_t)animation completion:(dispatch_block_t)completion {
    [self flipAnimation:animation completion:completion type:@"oglFlip" subtype:kCATransitionFromLeft];
}

- (void)oglFlipFlipAnimationFromRight:(dispatch_block_t)animation completion:(dispatch_block_t)completion {
    [self flipAnimation:animation completion:completion type:@"oglFlip" subtype:kCATransitionFromRight];
}

#pragma mark -

- (void)flipAnimation:(dispatch_block_t)animation
           completion:(dispatch_block_t)completion
                 type:(NSString *)type
              subtype:(NSString *)subtype {
    [self flipAnimation:animation completion:completion type:type subtype:subtype duration:0.5];
}

- (void)flipAnimation:(dispatch_block_t)animation
           completion:(dispatch_block_t)completion
                 type:(NSString *)type
              subtype:(NSString *)subtype
             duration:(CGFloat)duration {
    
    CATransition *ani = [CATransition animation];
    ani.duration = duration;
    ani.subtype = subtype;
    ani.type = type;
    if (animation) {
        animation();
    }
    [self.layer addAnimation:ani forKey:@"flip"];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)((duration + 0.1) * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.layer removeAnimationForKey:@"flip"];
        if (completion) {
            completion();
        }
    });
}


@end
