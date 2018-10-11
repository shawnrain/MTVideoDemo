//
//  NetWorkAPI.m
//  KwaiUp
//
//  Created by melon on 2018/1/19.
//  Copyright © 2018年 melon. All rights reserved.
//

#import "NetWorkData.h"

@implementation NetWorkData
+ (NetWorkData * _Nonnull)manager
{
    static NetWorkData *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        //设置我们的缓存大小 其中内存缓存大小设置10M  磁盘缓存5M
        NSURLCache *cache = [[NSURLCache alloc] initWithMemoryCapacity:10 * 1024 * 1024
                                                          diskCapacity:50 * 1024 * 1024
                                                              diskPath:nil];
        [config setURLCache:cache];
        manager = [[NetWorkData
                    alloc] initWithSessionConfiguration:config];
//        AFJSONResponseSerializer *responseSerializer = [AFJSONResponseSerializer serializer];
//        [responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"application/json",   @"text/json", @"text/javascript",@"application/x-javascript",@"text/html",nil]];
        //[responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"application/json", @"text/json",@"text/html",nil]];
        //manager.responseSerializer.acceptableContentTypes= [NSSet setWithObject:@"text/html"];
        AFSecurityPolicy *securityPolicy = [AFSecurityPolicy defaultPolicy];
        securityPolicy.validatesDomainName = NO;
        securityPolicy.allowInvalidCertificates = YES;
        manager.securityPolicy = securityPolicy;
        manager.requestSerializer.timeoutInterval = 10;
        AFHTTPResponseSerializer *responseSerializer = [AFHTTPResponseSerializer serializer];
        manager.responseSerializer = responseSerializer;
        
        //  manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        
    });
    
    return manager;
}
+ (NSURLSessionDataTask * _Nullable)GET:(NSString * _Nonnull)URLString parameters:(id _Nullable)parameters result:(NetWorkResultBlock _Nonnull)resultBlock
{
    NSURLSessionDataTask *dataTask = [[self manager] GET:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (resultBlock) resultBlock(task, nil, responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (resultBlock) resultBlock(task, error, nil);
    }];
    return dataTask;
}
+ (NSURLSessionDataTask * _Nullable)POST:(NSString * _Nonnull)URLString parameters:(id _Nullable)parameters result:(NetWorkResultBlock _Nonnull)resultBlock
{
    NSURLSessionDataTask *dataTask = [[self manager] POST:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (resultBlock) resultBlock(task, nil, responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (resultBlock) resultBlock(task, error, nil);
    }];
    return dataTask;
}
@end
