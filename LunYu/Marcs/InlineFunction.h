//
//  InlineFunction.h
//  iWhy
//
//  Created by zhengqiang zhang on 2018/11/16.
//  Copyright © 2018 上海宝云网络. All rights reserved.
//

#ifndef InlineFunction_h
#define InlineFunction_h

static inline NSString * formatObject(NSString *obj, NSString *replace) {
    if ([obj isKindOfClass:[NSNull class]]) {
        obj = replace;
    }
    if (obj.length == 0 || obj == nil) {
        obj = replace;
    }
    return obj;
}

#endif /* InlineFunction_h */
