//
//  NetWorkManager.h
//  KwaiUp
//
//  Created by melon on 2017/12/28.
//  Copyright © 2017年 melon. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>
/**
 开发环境
 */
#define Test_Url @"https://dev.melonblock.com/app/"
/**
 正式环境
 */
#define Normal_Url @"https://qzone.melonblock.com/app/"

#define Domain_Url (isDebug ? Test_Url : Normal_Url)

@class NetWorkResult;
typedef void(^NetWorkResultBlock)(NSURLSessionDataTask * _Nullable dataTask, NSError * _Nullable error, id _Nullable responseObject);
@interface NetWorkTool : AFHTTPSessionManager
+ (NetWorkTool * _Nonnull)manager;

+ (NSURLSessionDataTask * _Nullable)GET:(NSString * _Nonnull)URLString parameters:(id _Nullable)parameters result:(NetWorkResultBlock _Nonnull)resultBlock;
+ (NSURLSessionDataTask * _Nullable)POST:(NSString * _Nonnull)URLString parameters:(id _Nullable)parameters result:(NetWorkResultBlock _Nonnull)resultBlock;


//在主线程中执行会导致应用发生死锁

+ (NetWorkResult * _Nullable)GETWithSYNC:(NSString * _Nonnull)URLString parameters:(id _Nullable)parameters;
+ (NetWorkResult * _Nullable)POSTWithSYNC:(NSString * _Nonnull)URLString parameters:(id _Nullable)parameters;


//处理请求结果  返回YES表示请求结果没问题  返回NO表示请求结果出错
+ (BOOL)handleResponseObject:(id _Nullable)responseObject error:(NSError *_Nullable)error;
@end
@interface NetWorkResult: NSObject

@property (nonatomic, strong) id _Nullable responseObject;
@property (nonatomic, strong) NSURLSessionDataTask *_Nonnull dataTask;
@property (nonatomic, strong) NSError * _Nullable error;

@end
