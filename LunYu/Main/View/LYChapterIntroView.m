//
//  LYChapterIntroView.m
//  LunYu
//
//  Created by zhengqiang zhang on 2019/3/29.
//  Copyright © 2019 chang. All rights reserved.
//

#import "LYChapterIntroView.h"

@interface LYChapterIntroView ()

@property(nonatomic, strong) UILabel *titleLabel;
@property(nonatomic, strong) UITextView *textView;
@property(nonatomic, strong) UIView *containerView;
@property(nonatomic, strong) UIView *backgroundView;

@end


@implementation LYChapterIntroView

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
    [self addSubview:self.backgroundView];
    [self addSubview:self.containerView];
    [self.containerView addSubview:self.titleLabel];
    [self.containerView addSubview:self.textView];
}

#pragma mark -

- (void)backgroundViewDidClick {
    
}

#pragma mark -

- (UIView *)backgroundView {
    if (_backgroundView == nil) {
        _backgroundView = [[UIView alloc] initWithFrame:CGRectZero];
        _backgroundView.backgroundColor = [UIColor colorWithRGB:0x000000 alpha:0.5];
        [_backgroundView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backgroundViewDidClick)]];
    }
    return _backgroundView;
}

- (UIView *)containerView {
    if (_containerView == nil) {
        _containerView = [[UIView alloc] initWithFrame:CGRectZero];
        _containerView.backgroundColor = [UIColor whiteColor];
        _containerView.layer.cornerRadius = 10;
    }
    return _containerView;
}

- (UILabel *)titleLabel {
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = LYFont(24);
    }
    return _titleLabel;
}

- (UITextView *)textView {
    if (_textView == nil) {
        _textView = [[UITextView alloc] initWithFrame:CGRectZero];
//        _textView.showsVerticalScrollIndicator = NO;
        _textView.font = LYFont(18);
//        _textView.textColor = 
    }
    return _textView;
}
@end
