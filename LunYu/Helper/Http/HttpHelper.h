//
//  HttpHelper.h
//  iTing_rebuild
//
//  Created by zhengqiang zhang on 2018/9/7.
//  Copyright © 2018年 上海宝云网络. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AFURLSessionManager;

typedef void(^HttpSuccessHandler)(id response);
typedef void(^HttpFailureHandler)(NSError * error);

@interface HttpHelper : NSObject

+ (NSString *)apiUrlPrefix;

+ (void)apiGet:(NSString *)path
        params:(NSDictionary *)params
       headers:(NSDictionary *)headers
       success:(HttpSuccessHandler)success
       failure:(HttpFailureHandler)failure;

+ (void)apiGet:(NSString *)path
        params:(NSDictionary *)params
       success:(HttpSuccessHandler)success
       failure:(HttpFailureHandler)failure;

+ (void)apiPost:(NSString *)path
         params:(NSDictionary *)params
        success:(HttpSuccessHandler)success
        failure:(HttpFailureHandler)failure ;

+ (void)apiPost:(NSString *)path
         params:(NSDictionary *)params
        headers:(NSDictionary *)headers
        success:(HttpSuccessHandler)success
        failure:(HttpFailureHandler)failure;

+ (NSString *)encodeURIComponent:(NSString *)str;

+ (AFURLSessionManager *)manager;

+ (void)htmlApiGet:(NSString *)path
            params:(NSDictionary *)params
           success:(HttpSuccessHandler)success
           failure:(HttpFailureHandler)failure;

@end


@interface NSError (code)

+ (instancetype)errorWithCode:(NSInteger)code;

@end
