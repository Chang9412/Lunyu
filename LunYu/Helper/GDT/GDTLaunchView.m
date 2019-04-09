//
//  GDTLaunchView.m
//  TextOCR
//
//  Created by zhengqiang zhang on 2019/2/1.
//  Copyright © 2019 上海宝云网络. All rights reserved.
//

#import "GDTLaunchView.h"

@interface GDTLaunchView ()

@property(nonatomic, strong) UIImageView *imageView;
@property(nonatomic, strong) UILabel *titleLabel;

@end



@implementation GDTLaunchView

//@dynamic bottomView;

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

- (void)setup {
    self.userInteractionEnabled = NO;
    [self addSubview:self.bottomView];
    [self.bottomView addSubview:self.imageView];
    [self.bottomView addSubview:self.titleLabel];
}

- (void)event {
    NSLog(@"aa");
}
- (void)layoutSubviews {
    [super layoutSubviews];
    if (@available(iOS 11.0, *)) {
        self.bottomView.frame = CGRectMake(0, CGRectGetHeight(self.bounds) - 160 - self.safeAreaInsets.bottom, CGRectGetWidth(self.bounds), 160);
    } else {
        self.bottomView.frame = CGRectMake(0, CGRectGetHeight(self.bounds) - 160, CGRectGetWidth(self.bounds), 160);
    }
    self.imageView.frame = CGRectMake(60, 40, 60, 60);
    self.titleLabel.frame = CGRectMake(145, 60, 150, 40);
}

- (UIView *)bottomView {
    if (_bottomView == nil) {
        _bottomView = [[UIView alloc] initWithFrame:CGRectZero];
        _bottomView.backgroundColor = [UIColor whiteColor];
    }
    return _bottomView;
}

- (UIImageView *)imageView {
    if (_imageView == nil) {
        _imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _imageView.image = [UIImage imageNamed:@"icon"];
    }
    return _imageView;
}

- (UILabel *)titleLabel {
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.text = @"儿童益智读物";
        _titleLabel.font = [UIFont fontWithName:@"Futura Medium" size:17];
        _titleLabel.textColor = [UIColor navBarColor];
    }
    return _titleLabel;
}
@end
