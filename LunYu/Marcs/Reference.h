//
//  Reference.h
//  iWhy
//
//  Created by zhengqiang zhang on 2018/11/8.
//  Copyright © 2018 上海宝云网络. All rights reserved.
//

#ifndef Reference_h
#define Reference_h

#define SWWeak(x) __weak __typeof__(x) __weak_##x##__ = x;

#define SWStrong(x) __typeof__(x) x = __weak_##x##__;

#ifdef DEBUG
#define AppLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#else
#define AppLog(...)
#endif


#endif /* Reference_h */
