//
//  LYLunYuManager.h
//  LunYu
//
//  Created by zhengqiang zhang on 2019/3/29.
//  Copyright © 2019 chang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LYLunYu.h"

NS_ASSUME_NONNULL_BEGIN

@interface LYLunYuManager : NSObject

@property(nonatomic, strong) LYChapter *currentChapter;
@property(nonatomic, strong) LYChapter *nextChapter;
@property(nonatomic, strong) LYChapter *preChapter;

@property(nonatomic, strong) LYParagraph *currentParagraph;
@property(nonatomic, strong) LYParagraph *nextParagraph;
@property(nonatomic, strong) LYParagraph *preParagraph;



@end

NS_ASSUME_NONNULL_END
