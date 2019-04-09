//
//  UIView+FlipAnimation.h
//  iWhy
//
//  Created by zhengqiang zhang on 2018/11/14.
//  Copyright © 2018 上海宝云网络. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (FlipAnimation)

// fade
- (void)fadeFlipAnimation:(dispatch_block_t)animation completion:(dispatch_block_t)completion;

//rippleEffect 水波纹
- (void)rippleEffectFlipAnimation:(dispatch_block_t)animation completion:(dispatch_block_t)completion ;

// push
- (void)pushFlipAnimationFromLeft:(dispatch_block_t)animation completion:(dispatch_block_t)completion ;
- (void)pushFlipAnimationFromRight:(dispatch_block_t)animation completion:(dispatch_block_t)completion ;

// Reveal 揭开
- (void)revealFlipAnimationFromLeft:(dispatch_block_t)animation completion:(dispatch_block_t)completion ;
- (void)revealFlipAnimationFromRight:(dispatch_block_t)animation completion:(dispatch_block_t)completion ;

// moveIn 覆盖
- (void)moveInFlipAnimationFromLeft:(dispatch_block_t)animation completion:(dispatch_block_t)completion ;
- (void)moveInFlipAnimationFromRight:(dispatch_block_t)animation completion:(dispatch_block_t)completion ;

// cube
- (void)cubeFlipAnimationFromLeft:(dispatch_block_t)animation completion:(dispatch_block_t)completion ;
- (void)cubeFlipAnimationFromRight:(dispatch_block_t)animation completion:(dispatch_block_t)completion ;

// pageCurl
- (void)pageCurlFlipAnimationFromLeft:(dispatch_block_t)animation completion:(dispatch_block_t)completion ;
- (void)pageCurlFlipAnimationFromRight:(dispatch_block_t)animation completion:(dispatch_block_t)completion ;


- (void)pageUnCurlFlipAnimationFromLeft:(dispatch_block_t)animation completion:(dispatch_block_t)completion;
- (void)pageUnCurlFlipAnimationFromRight:(dispatch_block_t)animation completion:(dispatch_block_t)completion;

// oglFlip
- (void)oglFlipFlipAnimationFromLeft:(dispatch_block_t)animation completion:(dispatch_block_t)completion ;
- (void)oglFlipFlipAnimationFromRight:(dispatch_block_t)animation completion:(dispatch_block_t)completion ;

@end
