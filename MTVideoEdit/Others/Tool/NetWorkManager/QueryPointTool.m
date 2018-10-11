//
//  QueryPointModel.m
//  KwaiUp
//
//  Created by melon on 2018/1/29.
//  Copyright © 2018年 melon. All rights reserved.
//

#import "QueryPointTool.h"
#import "NetWorkData.h"
@interface  QueryPointTool ()

@property (nonatomic, copy) void(^complete) (NSInteger count);

@property (nonatomic, copy) NSString *adition;

@property (nonatomic) SERVICE_LIST service;
@end
@implementation QueryPointTool
+ (instancetype)shared
{
    static QueryPointTool *tool;
    tool = [[QueryPointTool alloc] init];
    return tool;
}
+ (void)queryStartPointWithAdition:(NSString *)adition service:(SERVICE_LIST)service complete:(void(^)(NSInteger count))complete
{
    QueryPointTool *tool = [QueryPointTool shared];
    tool.complete = complete;
    tool.adition = adition;
    tool.service = service;
    [tool request];
}
- (void)request
{
    [NetWorkData GET:self.adition parameters:nil result:^(NSURLSessionDataTask * _Nullable dataTask, NSError * _Nullable error, id  _Nullable responseObject) {
        if (!error) {
            NSString *responseStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
            switch (self.service) {
                case SERVICE_LIST_KwaiFans:case SERVICE_LIST_KwaiShuangJi: case SERVICE_LIST_KwaiBoFangLiang:case SERVICE_LIST_KwaiPingLun:
                    [self kwaiCategoryCount:responseStr];
                    break;
                case SERVICE_LIST_KmusicFans:case SERVICE_LIST_KmusicPingLun:case SERVICE_LIST_KmusicXianHua:case SERVICE_LIST_KmusicShiTingLiang:
                    [self kMusicCategoryCount:responseStr];
                    break;
                case SERVICE_LIST_DouyinBoFangLiang:case SERVICE_LIST_DouyinShuangJi:case SERVICE_LIST_DouyinPingLun:case SERVICE_LIST_DouyinShare:
                    [self douyinCategoryCount:responseStr];
                    break;
                default:
                {
                    if (self.complete) {
                        self.complete(-1);
                    }
                }
                    break;
            }
        }else{
            if (self.complete) {
                self.complete(-1);
            }
        }
    }];
}

#pragma mark -
#pragma mark - 快手类查询
- (void)kwaiCategoryCount:(NSString *)responseStr
{
    NSInteger count = -1;
    if ([responseStr containsString:@"window.__data__ = "]) {
        NSString *str1 = [responseStr componentsSeparatedByString:@"window.__data__ = "].lastObject;
        if ([str1 containsString:@"result"]) {
            NSString *jsonStr = [str1 componentsSeparatedByString:@";</script>"].firstObject;
            NSData *data = [jsonStr dataUsingEncoding:NSUTF8StringEncoding];
            NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
            NSDictionary *counts = [json objectForKey:@"counts"];
            NSDictionary *photo = [json objectForKey:@"photo"];
            if (self.service == SERVICE_LIST_KwaiFans) {
                count = [[counts objectForKey:@"fanCount"] integerValue];
            }else if (self.service == SERVICE_LIST_KwaiBoFangLiang) {
                count = [[photo objectForKey:@"viewCount"] integerValue];
            }else if (self.service == SERVICE_LIST_KwaiPingLun){
                count = [[photo objectForKey:@"commentCount"] integerValue];
            }else if (self.service == SERVICE_LIST_KwaiShuangJi){
                count = [[photo objectForKey:@"likeCount"] integerValue];
            }
        }
    }
    if (self.complete) {
        self.complete(count);
    }
}

#pragma mark -
#pragma mark - 全名k歌类查询
- (void)kMusicCategoryCount:(NSString *)responseStr
{
    NSInteger count = -1;
    if ([responseStr containsString:@"window.__DATA__ = "]) {
        NSString *str1 = [responseStr componentsSeparatedByString:@"window.__DATA__ = "].lastObject;
        if ([str1 containsString:@"shareid"]) {
            NSString *jsonStr = [str1 componentsSeparatedByString:@"; </script>"].firstObject;
            NSData *data = [jsonStr dataUsingEncoding:NSUTF8StringEncoding];
            NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
            NSDictionary *detail = [json objectForKey:@"detail"];
            if (self.service == SERVICE_LIST_KmusicFans){
                NSString *uid = [detail objectForKey:@"uid"];
                [self getKmusicFans:uid];
            }else{
                if (self.service == SERVICE_LIST_KmusicPingLun) {
                    count = [[detail objectForKey:@"comment_num"] integerValue];
                }else if (self.service == SERVICE_LIST_KmusicShiTingLiang){
                    count = [[detail objectForKey:@"play_num"] integerValue];
                }else if (self.service == SERVICE_LIST_KmusicXianHua){
                    count = [[detail objectForKey:@"flower_num"] integerValue];
                }
                if (self.complete) {
                    self.complete(count);
                }
            }
        }
    }else{
        if (self.complete) {
            self.complete(count);
        }
    }
}
- (void)getKmusicFans:(NSString *)uid
{
    NSString *url = [NSString stringWithFormat:@"https://node.kg.qq.com/personal?uid=%@",uid];
    [NetWorkData GET:url parameters:nil result:^(NSURLSessionDataTask * _Nullable dataTask, NSError * _Nullable error, id  _Nullable responseObject) {
        NSString *responseStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSInteger count = -1;
        if ([responseStr containsString:@"window.__DATA__ = "]) {
            NSString *str1 = [responseStr componentsSeparatedByString:@"window.__DATA__ = "].lastObject;
            if ([str1 containsString:@"personal"]) {
                NSString *jsonStr = [str1 componentsSeparatedByString:@"; </script>"].firstObject;
                NSData *data = [jsonStr dataUsingEncoding:NSUTF8StringEncoding];
                NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
                NSDictionary *data1 = [json objectForKey:@"data"];
                count = [[data1 objectForKey:@"follower"] integerValue];
            }
        }
        if (self.complete) {
            self.complete(count);
        }
    }];
}

#pragma mark -
#pragma mark - 抖音类查询
- (void)douyinCategoryCount:(NSString *)responseStr
{
    NSInteger count = -1;
    if ([responseStr containsString:@"data = "]) {
        NSString *str1 = [responseStr componentsSeparatedByString:@"data = "].lastObject;
        if ([str1 containsString:@"status"]) {
            NSString *jsonStr = [str1 componentsSeparatedByString:@";"].firstObject;
            NSData *data = [jsonStr dataUsingEncoding:NSUTF8StringEncoding];
            NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
            NSDictionary *json = jsonArray.firstObject;
            NSDictionary *detail = [json objectForKey:@"statistics"];
            if (self.service == SERVICE_LIST_DouyinBoFangLiang) {
                count = [[detail objectForKey:@"play_count"] integerValue];
            }else if (self.service == SERVICE_LIST_DouyinShuangJi){
                count = [[detail objectForKey:@"digg_count"] integerValue];
            }else if (self.service == SERVICE_LIST_DouyinPingLun){
                count = [[detail objectForKey:@"comment_count"] integerValue];
            }else if (self.service == SERVICE_LIST_DouyinShare){
                count = [[detail objectForKey:@"share_count"] integerValue];
            }
        }
    }
    if (self.complete) {
        self.complete(count);
    }
}
@end
