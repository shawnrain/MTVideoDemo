//
//  CommonTool.m
//  KwaiUp
//
//  Created by melon on 2018/3/30.
//  Copyright © 2018年 melon. All rights reserved.
//

#import "CommonTool.h"

@implementation CommonTool
+ (NSArray<NSString *> *)subUrlToOrderWithServiceList:(SERVICE_LIST)category url:(NSString *)url
{
    NSMutableArray *arrM = [NSMutableArray new];
    if (category == SERVICE_LIST_KwaiFans || category == SERVICE_LIST_KwaiZhiBoDianLiang) {
        if ([url containsString:@"http"]) {
            NSString *userId = [self machesKwaiAndKmusicCategoryWithRegularExpression:@"[^\?&]?userId=([^&]+)" url:url];
            if (userId) {
                [arrM addObject:userId];
            }
        }else{
            [arrM addObject:url];
        }
    }else if (category == SERVICE_LIST_KwaiBoFangLiang || category == SERVICE_LIST_KwaiPingLun || category == SERVICE_LIST_KwaiShuangJi){
        NSString *userId = [self machesKwaiAndKmusicCategoryWithRegularExpression:@"[^\?&]?userId=([^&]+)" url:url];
        NSString *photoId = [self machesKwaiAndKmusicCategoryWithRegularExpression:@"[^\?&]?photoId=([^&]+)" url:url];
        if (userId && photoId) {
            [arrM addObject:photoId];
            [arrM insertObject:userId atIndex:0];
        }
    }else if (category == SERVICE_LIST_KmusicFans || category == SERVICE_LIST_KmusicPingLun || category == SERVICE_LIST_KmusicShiTingLiang || category == SERVICE_LIST_KmusicXianHua){
        NSString *playId = [self machesKwaiAndKmusicCategoryWithRegularExpression:@"[^\?&]?s=([^&]+)" url:url];
        if (playId) {
            [arrM addObject:playId];
        }
    }else if (category == SERVICE_LIST_DouyinFans){
        NSString *playId = [self machesDouyinOthersCategoryWithRegularExpression:@"user/([\\w-_]*)" url:url];
        if (playId) {
            [arrM addObject:playId];
        }
    }else if (category == SERVICE_LIST_DouyinBoFangLiang || category == SERVICE_LIST_DouyinShuangJi || category == SERVICE_LIST_DouyinPingLun || category == SERVICE_LIST_DouyinShare){
        NSString *videoId = [self machesDouyinOthersCategoryWithRegularExpression:@"video/([\\w-_]*)" url:url];
        if (videoId) {
            [arrM addObject:videoId];
        }
    }
    return arrM.copy;
}

+ (NSString *)machesKwaiAndKmusicCategoryWithRegularExpression:(NSString *)regex url:(NSString *)url
{
    NSRange range = [url rangeOfString:regex options:NSRegularExpressionSearch];
    if (range.location != NSNotFound) {
        NSString * str = [url substringWithRange:range];
        NSString *kwaiId = [str componentsSeparatedByString:@"="].lastObject;
        return kwaiId;
    }else{
        return nil;
    }
}
+ (NSString *)machesDouyinOthersCategoryWithRegularExpression:(NSString *)regex url:(NSString *)url
{
    NSRange range = [url rangeOfString:regex options:NSRegularExpressionSearch];
    if (range.location != NSNotFound) {
        NSString * str = [url substringWithRange:range];
        NSString *videoStr = [str componentsSeparatedByString:@"/"].lastObject;
        return videoStr;
    }else{
        return nil;
    }
}
@end
