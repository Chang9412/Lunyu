//
//  HttpHelper.m
//  iTing_rebuild
//
//  Created by zhengqiang zhang on 2018/9/7.
//  Copyright © 2018年 上海宝云网络. All rights reserved.
//

#import "HttpHelper.h"
#import <AFNetworking.h>

@implementation HttpHelper

+ (void)load {
//    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectZero];
//    NSString *userAgent = [webView stringByEvaluatingJavaScriptFromString:@"navigator.userAgent"];
//    NSLog(@"userAgent :%@", userAgent);
}

#pragma mark -
+ (void)apiGet:(NSString *)path params:(NSDictionary *)params success:(HttpSuccessHandler)success failure:(HttpFailureHandler)failure {
    [self apiGet:path params:params headers:nil success:success failure:failure];
}

+ (void)apiGet:(NSString *)path params:(NSDictionary *)params headers:(NSDictionary *)headers success:(HttpSuccessHandler)success failure:(HttpFailureHandler)failure {
    NSURLRequest *request = [self apiRequestForPath:path params:params method:@"GET" headers:headers];
    [self sendRequest:request successHandler:^(id response) {
        if (success) {
            success(response);
        }
    } failureHandler:^(NSError * error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)apiPost:(NSString *)path params:(NSDictionary *)params success:(HttpSuccessHandler)success failure:(HttpFailureHandler)failure {
    [self apiPost:path params:params headers:nil success:success failure:failure];
}

+ (void)apiPost:(NSString *)path params:(NSDictionary *)params headers:(NSDictionary *)headers success:(HttpSuccessHandler)success failure:(HttpFailureHandler)failure {
    NSURLRequest *request = [self apiRequestForPath:path params:params method:@"POST" headers:headers];
    [self sendRequest:request successHandler:^(id response) {
        if (success) {
            success(response);
        }
    } failureHandler:^(NSError * error) {
        if (failure) {
            failure(error);
        }
    }];
}

#pragma mark - 配置参数
+ (NSString *)apiUrlPrefix {
    return @"https://g1q.gn.youyizhidao.com";
}

+ (NSString *)apiUrl:(NSString *)path {
    if ([path containsString:@"http"]) {
        return path;
    }
    return [[self apiUrlPrefix] stringByAppendingPathComponent:path];
}

+ (NSDictionary *)defaultHeaders {
    
    return nil;// @{@"User-Agent":@"New_wallpaper/4.4.1 (iPhone; iOS 12.1.4; Scale/2.00)"};
}


+ (void)addHeaders:(NSDictionary *)headers forRequest:(NSMutableURLRequest *)request {
    if (headers.count<1) {
        return;
    }
    [headers enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        if (![key isKindOfClass:[NSString class]]) {
            return ;
        }
        if (![obj isKindOfClass:[NSString class]]) {
            return ;
        }
        if ([key isEqualToString:@"User-Agent"]) {
            [request setValue:obj forHTTPHeaderField:key];
            return;
        }
        [request addValue:obj forHTTPHeaderField:key];
    }];
}

#pragma mark -

+ (AFURLSessionManager *)manager {
    static dispatch_once_t onceToken;
    static AFURLSessionManager *instance = nil;
    dispatch_once(&onceToken, ^{
        if (instance == nil) {
            instance = [AFHTTPSessionManager manager];
            AFJSONResponseSerializer *serializer = [AFJSONResponseSerializer serializer];
            serializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", @"application/json", @"text/json", @"text/javascript", @"text/plain", nil];
            instance.responseSerializer = serializer;
        }
    });
    return instance;
}

+ (NSMutableURLRequest *)apiRequestForPath:(NSString *)path
                                    params:(NSDictionary *)params
                                    method:(NSString *)httpMethod
                                   headers:(NSDictionary *)headers  {
    NSString *url = [self apiUrl:path];
    NSMutableDictionary *p = [NSMutableDictionary dictionaryWithDictionary:params];
    //TODO: 添加通用参数
    p[@"os"] = @"ios";
    p[@"hardware"] = @"iphone";
    p[@"version"] = @"4.4.1";
    p[@"appname"] = @"daibizhidaquan";
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer]
                                    requestWithMethod:httpMethod
                                    URLString:url
                                    parameters:p
                                    error:nil];
    //    [request setCachePolicy:0];
    //    request setAllHTTPHeaderFields:(NSDictionary<NSString *,NSString *> * _Nullable)
    [self addHeaders:[self defaultHeaders] forRequest:request];
    [self addHeaders:headers forRequest:request];
    request.timeoutInterval = 10;
    return request;
}


+ (void)sendRequest:(NSURLRequest *)request successHandler:(HttpSuccessHandler)success failureHandler:(HttpFailureHandler)failure {
    NSURLSessionDataTask *task = [[self manager] dataTaskWithRequest:request uploadProgress:nil downloadProgress:nil completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        if (error) {
            if (failure) {
                failure(error);
            }
        }else {
            if (success) {
                success(responseObject);
            }
        }
    }];
    [task resume];
}

+ (NSString *)encodeURIComponent:(NSString *)str {
    if (str) {
        return AFPercentEscapedStringFromString(str);
    }
    return nil;
}

+ (AFURLSessionManager *)htmlManager {
    static dispatch_once_t onceToken;
    static AFURLSessionManager *instance = nil;
    dispatch_once(&onceToken, ^{
        if (instance == nil) {
            instance = [AFHTTPSessionManager manager];
            instance.responseSerializer = [AFHTTPResponseSerializer serializer];;
        }
    });
    return instance;
}

+ (void)htmlApiGet:(NSString *)path
            params:(NSDictionary *)params
           success:(HttpSuccessHandler)success
           failure:(HttpFailureHandler)failure {
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer]
                                    requestWithMethod:@"GET"
                                    URLString:path
                                    parameters:params
                                    error:nil];
    NSURLSessionDataTask *task = [[self htmlManager] dataTaskWithRequest:request uploadProgress:nil downloadProgress:nil completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        if (error) {
            if (failure) {
                failure(error);
            }
        }else {
            if (success) {
                success(responseObject);
            }
        }
    }];
    [task resume];
}

@end


@implementation NSError (code)

+ (instancetype)errorWithCode:(NSInteger)code {
    return [NSError errorWithDomain:@"SSIT" code:code userInfo:nil];
}

@end
