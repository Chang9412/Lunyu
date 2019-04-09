//
//  LYLunYunView.m
//  LunYu
//
//  Created by zhengqiang zhang on 2019/3/29.
//  Copyright © 2019 chang. All rights reserved.
//

#import "LYLunYunView.h"

@interface LYLunYunView ()

@property(nonatomic, strong) UIScrollView *scrollView;


@end

@implementation LYLunYunView

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup {
}


@end
