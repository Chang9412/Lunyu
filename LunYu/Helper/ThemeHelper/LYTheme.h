//
//  LYTheme.h
//  LunYu
//
//  Created by zhengqiang zhang on 2019/4/1.
//  Copyright © 2019 chang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LYTheme : NSObject

@property(nonatomic, strong) NSString *name;

@property(nonatomic, strong) UIColor *c1;
@property(nonatomic, strong) UIColor *c2;
@property(nonatomic, strong) UIColor *c3;
@property(nonatomic, strong) UIColor *c4;
@property(nonatomic, strong) UIColor *backgroundColor;

- (instancetype)initWithDict:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
