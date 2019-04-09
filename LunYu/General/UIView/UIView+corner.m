//
//  UIView+corner.m
//  iTing_rebuild
//
//  Created by zhengqiang zhang on 2018/9/10.
//  Copyright © 2018年 上海宝云网络. All rights reserved.
//

#import "UIView+corner.h"

@implementation UIView (corner)

- (void)cornerRadius:(CGFloat)ra {
    self.layer.cornerRadius = ra;
    if ([self isMemberOfClass:[UIView class]]) {
        
    }else {
        self.layer.masksToBounds = YES;
    }
}

- (void)roundingCorners:(UIRectCorner)corners Radius:(CGFloat)ra{
    CAShapeLayer *shape = [CAShapeLayer layer];
    UIBezierPath *path= [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:corners cornerRadii:CGSizeMake(ra, ra)];
    shape.path = path.CGPath;
    self.layer.mask = shape;
}

@end
