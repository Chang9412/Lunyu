//
//  WPBlankView.m
//  WallPaper
//
//  Created by zhengqiang zhang on 2019/3/22.
//  Copyright © 2019 上海宝云网络. All rights reserved.
//

#import "WPBlankView.h"

@interface WPBlankView ()

@property(nonatomic, strong) UIImageView *imageView;
@property(nonatomic, strong) UILabel *textLabel;

@end

@implementation WPBlankView

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
    [self addSubview:self.imageView];
    [self addSubview:self.textLabel];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.imageView.frame = CGRectMake(0, 0, CGRectGetWidth(self.bounds), CGRectGetMidY(self.bounds) + 45);
    self.textLabel.frame = CGRectMake(0, CGRectGetMaxY(self.imageView.frame), CGRectGetWidth(self.bounds), 20);
}

- (void)setImage:(UIImage *)image {
    self.imageView.image = image;
}

- (void)setText:(NSString *)text {
    self.textLabel.text = text;
}


- (UIImageView *)imageView {
    if (_imageView == nil) {
        _imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _imageView.contentMode = UIViewContentModeBottom;
        _imageView.image = [UIImage imageNamed:@"blank_page"];
    }
    return _imageView;
}

- (UILabel *)textLabel {
    if (_textLabel == nil) {
        _textLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _textLabel.textColor = [UIColor colorWithRGB:0x999999];
        _textLabel.font = [UIFont systemFontOfSize:15];
        _textLabel.textAlignment = NSTextAlignmentCenter;
        _textLabel.text = @"空空如也";
    }
    return _textLabel;
}


@end
