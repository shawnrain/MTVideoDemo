//
//  NetWorkManager.m
//  KwaiUp
//
//  Created by melon on 2017/12/28.
//  Copyright © 2017年 melon. All rights reserved.
//

#import "NetWorkTool.h"
typedef NS_ENUM(NSInteger, NetMethod){
    Get,
    Post
};
@implementation NetWorkTool
+ (NetWorkTool * _Nonnull)manager
{
    static NetWorkTool *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        //设置我们的缓存大小 其中内存缓存大小设置10M  磁盘缓存5M
        NSURLCache *cache = [[NSURLCache alloc] initWithMemoryCapacity:10 * 1024 * 1024
                                                          diskCapacity:50 * 1024 * 1024
                                                              diskPath:nil];
        [config setURLCache:cache];
        manager = [[NetWorkTool alloc] initWithBaseURL:[NSURL URLWithString:Domain_Url] sessionConfiguration:config];
        AFJSONResponseSerializer *responseSerializer = [AFJSONResponseSerializer serializer];
        [responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"application/json",   @"text/json", @"text/javascript",@"application/x-javascript",@"text/html",@"text/plain",@"text/text",nil]];
        //[responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"application/json", @"text/json",@"text/html",nil]];
        //manager.responseSerializer.acceptableContentTypes= [NSSet setWithObject:@"text/html"];
        manager.requestSerializer.timeoutInterval = 10;
        manager.responseSerializer = responseSerializer;
        //  manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        
    });
    
    return manager;
}

#pragma mark - Privite
- (NSURLSessionDataTask * _Nullable)method:(NetMethod)method URLString:(NSString * _Nonnull)URLString parameters:(id _Nullable)parameters result:(NetWorkResultBlock _Nonnull)resultBlock
{
    NSMutableDictionary *para;
    if (parameters) {
        para = parameters;
    }else{
        para = [NSMutableDictionary new];
    }
    for (NSString *key in para.allKeys) {
        if ([key containsString:@"user_id"]) {
            para[@"openid"] = UserInfo.openid;
            break;
        }
    }
    para[@"sign"] = [self getPrivteKeyWithParameters:para];
    if (method == Get) {
        NSURLSessionDataTask *dataTask = [self GET:URLString parameters:para progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if (resultBlock) resultBlock(task, nil, responseObject);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            if (resultBlock) resultBlock(task, error, nil);
        }];
        return dataTask;
    }else{
        NSURLSessionDataTask *dataTask = [self POST:URLString parameters:para progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if (resultBlock) resultBlock(task, nil, responseObject);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            if (resultBlock) resultBlock(task, error, nil);
        }];
        return dataTask;
    }
}
- (NSString *)getTimeInterval
{
    NSTimeInterval time = [[NSDate date] timeIntervalSince1970]/10.f;
    NSString *timeStr = [NSString stringWithFormat:@"time=%ld",(long)time];
    return timeStr;
}
- (NSString *)getPrivteKeyWithParameters:(NSMutableDictionary *)params{
    NSArray *allKeys = params.allKeys;
    NSArray *afterSortKeyArray = [allKeys sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        NSComparisonResult resuest = [obj1 compare:obj2];
        return resuest;
    }];
    NSMutableArray *valueArray = [NSMutableArray array];
    for (NSString *sortsing in afterSortKeyArray) {
        NSString *valueString = [params objectForKey:sortsing];
        [valueArray addObject:valueString];
    }
    NSMutableArray *signArray = [NSMutableArray array];
    for (int i = 0 ; i < afterSortKeyArray.count; i++) {
        NSString *keyValue = [NSString stringWithFormat:@"%@=%@",afterSortKeyArray[i],valueArray[i]];
        [signArray addObject:keyValue];
    }
    NSMutableString *key = [NSMutableString string];
    for (int i = 0; i < signArray.count; i ++) {
        [key appendFormat:@"%@",signArray[i]];
    }
    [key appendString:[self getTimeInterval]];
    [key appendString:@"key=AppMelonBlock2017"];
    return [key md5].lowercaseString;
}
#pragma mark - Public
+ (NSURLSessionDataTask * _Nullable)GET:(NSString * _Nonnull)URLString parameters:(id _Nullable)parameters result:(NetWorkResultBlock _Nonnull)resultBlock
{
    NSURLSessionDataTask *dataTask = [[self manager] method:Get URLString:URLString parameters:parameters result:resultBlock];
    return dataTask;
}
+ (NSURLSessionDataTask * _Nullable)POST:(NSString * _Nonnull)URLString parameters:(id _Nullable)parameters result:(NetWorkResultBlock _Nonnull)resultBlock
{
    
    NSURLSessionDataTask *dataTask = [[self manager] method:Post URLString:URLString parameters:parameters result:resultBlock];
    return dataTask;
}

+ (NetWorkResult * _Nullable)GETWithSYNC:(NSString * _Nonnull)URLString parameters:(id _Nullable)parameters{
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    __block NetWorkResult *result = [[NetWorkResult alloc] init];
    
    NSURLSessionDataTask *dataTask = [self GET:URLString parameters:parameters result:^(NSURLSessionDataTask * _Nonnull dataTask, NSError * _Nullable error, id  _Nullable responseObject) {
        if (error) {
            result.error = error;
        }else{
            result.responseObject = responseObject;
        }
        dispatch_semaphore_signal(semaphore);
    }];
    if (!dataTask) {
        return nil;
    }
    
    result.dataTask = dataTask;
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    return result;
}

+ (NetWorkResult * _Nullable)POSTWithSYNC:(NSString * _Nonnull)URLString parameters:(id _Nullable)parameters{
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    __block NetWorkResult *result = [[NetWorkResult alloc] init];
    NSURLSessionDataTask *dataTask = [self POST:URLString parameters:parameters result:^(NSURLSessionDataTask * _Nonnull dataTask, NSError * _Nullable error, id  _Nullable responseObject) {
        if (error) {
            result.error = error;
        }else{
            result.responseObject = responseObject;
        }
        dispatch_semaphore_signal(semaphore);
    }];
    if (!dataTask) {
        return nil;
    }
    
    result.dataTask = dataTask;
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    return result;
}

+ (BOOL)handleResponseObject:(id _Nullable)responseObject error:(NSError *_Nullable)error{
    if (error) {
        DLog(@"网络错误:%@",error);
        return NO;
    }
    
    NSInteger status = [[responseObject objectForKey:@"status"] integerValue];
    if (status == 0) {
        NSString *msg = [responseObject objectForKey:@"msg"];
        DLog(@"数据返回错误:%@",msg);
        return NO;
    }
    return YES;
    
}
@end
@implementation NetWorkResult

@end
