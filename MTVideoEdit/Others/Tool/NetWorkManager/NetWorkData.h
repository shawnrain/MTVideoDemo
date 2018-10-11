//
//  NetWorkAPI.h
//  KwaiUp
//
//  Created by melon on 2018/1/19.
//  Copyright © 2018年 melon. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>
typedef void(^NetWorkResultBlock)(NSURLSessionDataTask * _Nullable dataTask, NSError * _Nullable error, id _Nullable responseObject);
@interface NetWorkData : AFHTTPSessionManager
+ (NetWorkData *_Nonnull)manager;

+ (NSURLSessionDataTask * _Nullable)GET:(NSString * _Nonnull)URLString parameters:(id _Nullable)parameters result:(NetWorkResultBlock _Nonnull)resultBlock;
+ (NSURLSessionDataTask * _Nullable)POST:(NSString * _Nonnull)URLString parameters:(id _Nullable)parameters result:(NetWorkResultBlock _Nonnull)resultBlock;
@end
