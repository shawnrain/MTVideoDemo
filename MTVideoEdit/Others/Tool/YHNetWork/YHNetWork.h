//
//  YHNetWork.h
//  KmusicExpand
//
//  Created by melon on 2017/11/14.
//  Copyright © 2017年 melon. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef enum _Network_Type
{
    Network_NONE     = 0 ,//无网络
    Network_2G       = 1 ,//2G
    Network_3G       = 2 ,//3G
    Network_4G       = 3 ,//4G
    Network_WIFI     = 4 ,//WIFI
    
}Network_Type;
@interface YHNetWork : NSObject

/**
 单列

 @return YHNetWork
 */
+ (instancetype)sharedInstanse;
/*
 aMonitorInterval      监控时间间隔，默认为2秒监测一次
 BOOL                  isHasNetWork;//当前是否有网络链接
 BOOL                  isChange;//网络变化，无网与有网之间的变化
 Network_Type          networkType;//当前网络类型（无网，WIFI，2G，3G，4G）
 */
- (BOOL)startMonitorWithInterval:(float)aMonitorInterval andCallback:(void(^)(BOOL isHasNetWork,BOOL isChange,Network_Type networkType))callback;

//外部调用结束监控指令
- (void)stopMonitor;

//是否有网络连接
- (BOOL)hasNetwork;

//判断wifi是否真的可用（即能不能连外网）
- (BOOL)isEnableWIFI;

//网络类型获取
- (Network_Type)getCurrentNetworkType;
//判断是否有可用的网络连接
- (BOOL)isNetworkEnable;
@end
