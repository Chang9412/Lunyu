//
//  LYChapter.h
//  LunYu
//
//  Created by zhengqiang zhang on 2019/3/29.
//  Copyright © 2019 chang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LYParagraph : NSObject

@property(nonatomic, strong) NSString *originalText;
@property(nonatomic, strong) NSString *notes;
@property(nonatomic, strong) NSString *translationText;
@property(nonatomic, strong) NSString *appraise;

@end

@interface LYChapter : NSObject

@property(nonatomic, strong) NSArray *paragraphs;


@end


@interface LYLunYuItem : NSObject

@property(nonatomic, strong) NSArray *chapters;
@property(nonatomic, strong) NSString *author;

@end



NS_ASSUME_NONNULL_END
