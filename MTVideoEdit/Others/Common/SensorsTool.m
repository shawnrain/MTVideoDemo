//
//  CommonTool.m
//  Kmusic
//
//  Created by melon on 2017/11/8.
//  Copyright © 2017年 cy. All rights reserved.
//

#import "SensorsTool.h"
#import <SensorsAnalyticsSDK/SensorsAnalyticsSDK.h>

@implementation SensorsTool
+ (void)sensorsAnalytics:(NSString *)label type:(sensorsType)type
{
    NSDictionary *dict = @{
              @"全民K歌粉丝":Kgfensi ,
              @"全民K歌评论":Kgpinglun ,
              @"全民K歌试听量":Kgshitingliang,
              @"全民K歌鲜花":Kgxianhua,
              @"快手粉丝":Kfensi,
              @"快手播放量":Kbofangliang,
              @"快手双击":Kshuangji,
              @"快手评论":Kpinglun,
              @"抖音粉丝":Dfensi,
              @"抖音播放量":Dbofangliang,
              @"抖音双击":Dshuangji,
              @"抖音评论":Dpinglun,
              @"名片赞":Qmingpianzan,
              @"说说赞":Qshuoshuozan,
              @"空间主页赞":Qzhuyezan,
              @"空间留言":Qliuyan,
              @"说说浏览量":Qshuoshuoliuyan,
              @"空间访问量":QzoneLiulang,
              };
    NSString *str = [dict objectForKey:label];
    if (!str.length) {
        return;
    }
    if (type == sensorsTypeItem) {
        NSString *title = [NSString stringWithFormat:@"%@%@",MainCategory,str];
        [[SensorsAnalyticsSDK sharedInstance] track:title];
    }else if (type == sensorsTypeSubmit){
        NSString *title = [NSString stringWithFormat:@"%@%@",KaShangSubmit,str];
        [[SensorsAnalyticsSDK sharedInstance] track:title];
    }else{
        NSString *title = [NSString stringWithFormat:@"%@%@",KaShangHelp,str];
        [[SensorsAnalyticsSDK sharedInstance] track:title];
    }
}
@end
