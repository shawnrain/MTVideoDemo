//
//  QOnlineConfigTool.m
//  KwaiUp
//
//  Created by melon on 2018/1/2.
//  Copyright © 2018年 melon. All rights reserved.
//

#import "QOnlineConfigTool.h"
#import "YHNetWork.h"
@implementation QOnlineConfigTool
+(NSString*)getValueForKey:(NSString*)key
{
    if (!key.length)return @"";
    return [StandardUserDefaults objectForKey:key];
}
+(void)updataAllKey
{
    [self updateAddress];
    [self updateExclusiveServiceInfo];
    [self updateGzh];
    [self getAllCourses];
    [self updateIsOrder];
}
#pragma mark 电话 qqkey
+(void)updateAddress
{
    NSMutableDictionary *parameters = [NSMutableDictionary new];
    parameters[@"k"] = @"QZone_Address_Phone";
    parameters[@"uaid"] = @(UAID);
    [NetWorkTool POST:@"config" parameters:parameters result:^(NSURLSessionDataTask * _Nullable dataTask, NSError * _Nullable error, id  _Nullable responseObject) {
        if (error) {
            return;
        }
        NSArray *array = (NSArray*)responseObject;
        NSDictionary *dict = array.firstObject;
        if (!dict || !array.count) {
            return;
        }
        NSString *value = [dict objectForKey:@"value"];
        NSData *jsonData = [value dataUsingEncoding:NSUTF8StringEncoding];
        NSError *err;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                            options:NSJSONReadingMutableContainers
                                                              error:&err];
        NSMutableArray *arr = [dic objectForKey:@"dataList"];
        NSDictionary *infoDict = arr.firstObject;
        NSUserDefaults *defaul = [NSUserDefaults standardUserDefaults];
        [defaul setObject:[infoDict objectForKey:@"phone"] forKey:@"QKPhone"];
        [defaul setObject:[infoDict objectForKey:@"qun"] forKey:@"QKQun"];
        [defaul setObject:[infoDict objectForKey:@"key"] forKey:@"QKQKey"];
        [defaul synchronize];
    }];
}
#pragma mark 专属客服账户信息
+(void)updateExclusiveServiceInfo
{
    NSMutableDictionary *parameters = [NSMutableDictionary new];
    parameters[@"k"] = @"Exclusive_Service";
    parameters[@"uaid"] = @(UAID);
    [NetWorkTool POST:@"config" parameters:parameters result:^(NSURLSessionDataTask * _Nullable dataTask, NSError * _Nullable error, id  _Nullable responseObject) {
        if (error) {
            return;
        }
        NSArray *array = (NSArray*)responseObject;
        NSDictionary *dict = array.firstObject;
        if (!dict || !array.count) {
            return;
        }
        NSString *value = [dict objectForKey:@"value"];
        NSData *jsonData = [value dataUsingEncoding:NSUTF8StringEncoding];
        NSError *err;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                            options:NSJSONReadingMutableContainers
                                                              error:&err];
        
        NSUserDefaults *defaul = [NSUserDefaults standardUserDefaults];
        [defaul setObject:[dic objectForKey:@"name"] forKey:kExclusiveSerNameKey];
        [defaul setObject:[dic objectForKey:@"account"] forKey:kExclusiveSerAccountKey];
        [defaul synchronize];
    }];
}
#pragma mark 公众号
+ (void)updateGzh
{
    NSMutableDictionary *parameters = [NSMutableDictionary new];
    parameters[@"k"] = @"get_wx_gzh";
    parameters[@"uaid"] = @(UAID);
    [NetWorkTool POST:@"config" parameters:parameters result:^(NSURLSessionDataTask * _Nullable dataTask, NSError * _Nullable error, id  _Nullable responseObject) {
        if (error) {
            return;
        }
        NSArray *array = (NSArray*)responseObject;
        NSDictionary *dict = array.firstObject;
        if (!dict || !array.count) {
            return;
        }
        NSString *value = [dict objectForKey:@"value"];
        NSData *jsonData = [value dataUsingEncoding:NSUTF8StringEncoding];
        NSError *err;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                            options:NSJSONReadingMutableContainers
                                                              error:&err];
        //注意更换key
        NSString *gzh = [dic objectForKey:@"ks"];
        NSUserDefaults *defaul = [NSUserDefaults standardUserDefaults];
        [defaul setObject:gzh forKey:kWeChatGZHKey];
        [defaul synchronize];
    }];
}
#pragma mark - 获取教程的链接
+ (void)getAllCourses
{
    NSMutableDictionary *parameters = [NSMutableDictionary new];
    parameters[@"k"] = @"get_all_courses";
    parameters[@"uaid"] = @(UAID);
    [NetWorkTool POST:@"config" parameters:parameters result:^(NSURLSessionDataTask * _Nullable dataTask, NSError * _Nullable error, id  _Nullable responseObject) {
        if (error) {
            return;
        }
        NSArray *array = (NSArray*)responseObject;
        NSDictionary *dict = array.firstObject;
        if (!dict || !array.count) {
            return;
        }
        NSString *value = [dict objectForKey:@"value"];
        NSData *jsonData = [value dataUsingEncoding:NSUTF8StringEncoding];
        NSError *err;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                            options:NSJSONReadingMutableContainers
                                                              error:&err];
        NSString *course_url = [dic objectForKey:@"course_url"];
        NSUserDefaults *defaul = [NSUserDefaults standardUserDefaults];
        [defaul setObject:course_url forKey:kCoursesUrlKey];
        [defaul synchronize];
    }];
}
#pragma mark 是否有订单
+ (void)updateIsOrder
{
    if (![UserInfo isLogin])return;
    NSMutableDictionary *parameters = [NSMutableDictionary new];
    parameters[@"user_id"] = @(UserInfo.id);
    [NetWorkTool POST:@"tasks" parameters:parameters result:^(NSURLSessionDataTask * _Nullable dataTask, NSError * _Nullable error, id  _Nullable responseObject) {
        NSArray *array = (NSArray *)responseObject;
        [[NSUserDefaults standardUserDefaults] setBool:array.count forKey:kHaveOrderKey];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }];
}
#pragma mark 审核开关
+(BOOL)isReview
{
    BOOL isReview = [[NSUserDefaults standardUserDefaults] boolForKey:kIsReviewKey];
    return isReview;
}
+(BOOL)isTimeReview
{
    QOnlineConfigTool *tool = [QOnlineConfigTool new];
    NSDateFormatter *dateFormatter = [tool currentDateFormartter];
    NSDate *prevdate = [dateFormatter dateFromString:ReviewTime];
    NSInteger day = [tool compareOneDay:[tool getNowDateFromatAnDate:[NSDate date]] withAnotherDay:[tool getNowDateFromatAnDate:prevdate]];
    if (day == 1){
        return NO;
    }else if (day == -1){
        return YES;
    }else{
        return YES;
    }
}

+ (void)isUSAIp:(void(^)(BOOL isUSAIp))complete
{
    BOOL isNet = [[YHNetWork sharedInstanse] isNetworkEnable];
    if (isNet) {
        NSMutableDictionary *parameters = [NSMutableDictionary new];
        parameters[@"uaid"] = @(UAID);
        [NetWorkTool POST:@"get_ip" parameters:parameters result:^(NSURLSessionDataTask * _Nullable dataTask, NSError * _Nullable error, id  _Nullable responseObject) {
            if ([responseObject[@"status"] isEqualToString:@"ok"]) {
                NSDictionary *dict = responseObject[@"data"];
                BOOL is_foreign = [[dict objectForKey:@"is_forbidden"] boolValue];
                [[NSUserDefaults standardUserDefaults] setBool:is_foreign forKey:kIsReviewKey];
                [[NSUserDefaults standardUserDefaults] synchronize];
                if (complete) {
                    complete(is_foreign);
                }
            }else{
                [[NSUserDefaults standardUserDefaults] setBool:YES forKey:kIsReviewKey];
                [[NSUserDefaults standardUserDefaults] synchronize];
                if (complete) {
                    complete(YES);
                }
            }
        }];
    }else{
        BOOL isReview = [QOnlineConfigTool isTimeReview];
        [[NSUserDefaults standardUserDefaults] setBool:isReview forKey:kIsReviewKey];
        [[NSUserDefaults standardUserDefaults] synchronize];
        if (complete) {
            complete(isReview);
        }
    }
}
#pragma mark time
- (NSDate *)getNowDateFromatAnDate:(NSDate *)anyDate
{
    NSTimeZone* sourceTimeZone = [NSTimeZone timeZoneWithAbbreviation:@"GMT"];
    NSTimeZone* destinationTimeZone = [NSTimeZone localTimeZone];
    NSInteger sourceGMTOffset = [sourceTimeZone secondsFromGMTForDate:anyDate];
    NSInteger destinationGMTOffset = [destinationTimeZone secondsFromGMTForDate:anyDate];
    NSTimeInterval interval = destinationGMTOffset - sourceGMTOffset;
    NSDate* destinationDateNow = [[NSDate alloc] initWithTimeInterval:interval sinceDate:anyDate];
    return destinationDateNow;
}
- (NSDateFormatter*)currentDateFormartter
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    return dateFormatter;
}
- (NSInteger)compareOneDay:(NSDate *)oneDay withAnotherDay:(NSDate *)anotherDay
{
    NSDateFormatter *dateFormatter = [self currentDateFormartter];
    NSString *oneDayStr = [dateFormatter stringFromDate:oneDay];
    NSString *anotherDayStr = [dateFormatter stringFromDate:anotherDay];
    NSDate *dateA = [dateFormatter dateFromString:oneDayStr];
    NSDate *dateB = [dateFormatter dateFromString:anotherDayStr];
    NSComparisonResult result = [dateA compare:dateB];
    if (result == NSOrderedDescending) {
        return 1;
    }else if (result == NSOrderedAscending){
        return -1;
    }
    return 0;
}
@end
