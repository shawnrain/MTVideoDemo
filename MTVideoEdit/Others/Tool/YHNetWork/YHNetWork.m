//
//  YHNetWork.m
//  KmusicExpand
//
//  Created by melon on 2017/11/14.
//  Copyright © 2017年 melon. All rights reserved.
//

#import "YHNetWork.h"
#import <Reachability/Reachability.h>
#import <netinet/in.h>
@interface  YHNetWork ()
{
    //计时变量
    NSDate           *mStartDate;
    //监控计时器
    NSTimer          *mMonitorTimer;
    //每隔多长时间需要做一次监控
    float             mMonitorInterval;
    
    BOOL              mIsHasNetWork;//是否有网
    BOOL              mIsChange;//网络变化，无网有网变化
    Network_Type      mIsNetworkType;//网络类型变化
    Network_Type      mLastNetworkType; //上一次网络类型
}
//收集回调函数
@property(nonatomic,retain) NSArray *mTheCallBackBlock;
@end
@implementation YHNetWork

+ (instancetype)sharedInstanse
{
    static YHNetWork *netWork;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        netWork = [[YHNetWork alloc] init];
    });
    return netWork;
}
-(id)init
{
    if (self = [super init])
    {
        mIsHasNetWork          = NO;
        mIsChange              = NO;
        mIsNetworkType         = Network_NONE;
        mLastNetworkType       = -1;
        self.mTheCallBackBlock = [NSArray array];
    }
    
    return self;
}

- (BOOL)startMonitorWithInterval:(float)aMonitorInterval andCallback:(void(^)(BOOL isHasNetWork,BOOL isChange,Network_Type networkType))callback
{
    if (aMonitorInterval <= 0.0)
    {
        mMonitorInterval = 2;
    }
    else
    {
        mMonitorInterval = aMonitorInterval;
    }
    
    self.mTheCallBackBlock = @[[callback copy]];
    // 添加计时器
    [self addTimers];
    // 开始监控
    [self startMonitor];
    
    return YES;
}

//外部调用开启监控指令
- (void)startMonitor
{
    [mMonitorTimer setFireDate:[NSDate date]]; // 开启监控指令
}

//外部调用结束监控指令
- (void)stopMonitor
{
    [mMonitorTimer invalidate];
}

- (void)addTimers
{
    mMonitorTimer = [NSTimer scheduledTimerWithTimeInterval:mMonitorInterval target:self selector:@selector(doStartMonitor) userInfo:nil repeats:YES];
    [mMonitorTimer setFireDate:[NSDate distantFuture]]; // 默认先不启动监控功能
}

//开始一次监控
- (void)doStartMonitor
{
    BOOL hasNetwork = [self hasNetwork];
    if (mIsHasNetWork != hasNetwork)
    {
        mIsChange = YES;
    }
    else
    {
        mIsChange = NO;
    }
    
    mIsNetworkType = [self getCurrentNetworkType];
    mIsHasNetWork  = hasNetwork;
    
    if (mIsNetworkType != mLastNetworkType) //wifi切2G3G4G的时候也是网络发生变化了
    {
        mIsChange = YES;
    }
    
    id callback    = [self.mTheCallBackBlock objectAtIndex:0];
    ((void(^)(BOOL isHasNetWork,BOOL isChange,Network_Type networkType))callback)(mIsHasNetWork,mIsChange,mIsNetworkType);
    
    mLastNetworkType = mIsNetworkType;
}

-(BOOL)hasNetwork
{
    return [self connectedToNetwork];
}

- (BOOL) isEnableWIFI
{
    BOOL ret = ([[Reachability reachabilityForLocalWiFi] currentReachabilityStatus] != NotReachable);
    
    if (ret)    //判断该wifi是否真的可用
    {
        Reachability *r = [Reachability reachabilityWithHostName:@"www.baidu.com"];
        int status = [r currentReachabilityStatus];
        
        if (status == NotReachable)
        {
            ret = NO;
        }
    }
    
    return ret;
}


-(BOOL)connectedToNetwork
{
    struct sockaddr_in zeroAddress;
    bzero(&zeroAddress, sizeof(zeroAddress));
    zeroAddress.sin_len    = sizeof(zeroAddress);
    zeroAddress.sin_family = AF_INET;
    
    SCNetworkReachabilityRef defaultRouteReachability = SCNetworkReachabilityCreateWithAddress(NULL, (struct sockaddr *)&zeroAddress);
    SCNetworkReachabilityFlags flags;
    
    BOOL didRetrieveFlags = SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags);
    CFRelease(defaultRouteReachability);
    
    if (!didRetrieveFlags)
    {
        return NO;
    }
    
    BOOL isReachable     = ((flags & kSCNetworkFlagsReachable) != 0);
    BOOL needsConnection = ((flags & kSCNetworkFlagsConnectionRequired) != 0);
    return (isReachable && !needsConnection) ? YES : NO;
}

- (Network_Type)getCurrentNetworkType
{
    Network_Type typeSet = Network_NONE;
    
    if ([[UIApplication sharedApplication] valueForKeyPath:@"statusBar"])
    {
        typeSet = [self getNetworkTypeFromApplicationStatusBar];
    }
    else
    {
        typeSet = [self getNetworkStatusFromSCNetworkReachability];
    }
    return typeSet;
}
- (BOOL)isNetworkEnable
{
    BOOL isEnable = NO;
    
    isEnable = [self hasNetwork];
    
    if (isEnable && [self getCurrentNetworkType] == Network_WIFI)
    {
        //判断wifi是否为外网可用
        isEnable = [self isEnableWIFI];
    }
    return isEnable;
}
- (Network_Type)getNetworkTypeFromApplicationStatusBar
{
    UIApplication *currentApp = [UIApplication sharedApplication];
    // iPhone X的状态栏是多嵌套了一层，多取一次即可，最终适配代码为：
     NSArray *array;
    // 不能用 [[self deviceVersion] isEqualToString:@"iPhone X"] 来判断，因为模拟器不会返回 iPhone X
    if ([[currentApp valueForKeyPath:@"_statusBar"] isKindOfClass:NSClassFromString(@"UIStatusBar_Modern")]) {
        array = [[[[currentApp valueForKeyPath:@"_statusBar"] valueForKeyPath:@"_statusBar"] valueForKeyPath:@"foregroundView"] subviews];
    } else {
        array = [[[currentApp valueForKeyPath:@"_statusBar"] valueForKeyPath:@"foregroundView"] subviews];
    };
    Network_Type typeSet      = Network_NONE;
    for (id sub in array)
    {
        if ([sub isKindOfClass:NSClassFromString(@"UIStatusBarDataNetworkItemView")])
        {
            int type = [[sub valueForKeyPath:@"dataNetworkType"] intValue];
            if (type)
            {
                switch (type)
                {
                    case 0:
                        typeSet = Network_NONE;
                        break;
                    case 1:
                        typeSet = Network_2G;
                        break;
                    case 2:
                        typeSet = Network_3G;
                        break;
                    case 3:
                        typeSet = Network_4G;
                        break;
                    case 5:
                        typeSet = Network_WIFI;
                        break;
                    default:
                        break;
                }
            }
            else
            {
                typeSet = Network_NONE;
            }
            break;
        }
    }
    NSLog(@"Network_Type is %d",typeSet);
    return typeSet;
}

- (Network_Type)getNetworkStatusFromSCNetworkReachability
{
    struct sockaddr_in zeroAddress;
    bzero(&zeroAddress, sizeof(zeroAddress));
    zeroAddress.sin_len    = sizeof(zeroAddress);
    zeroAddress.sin_family = AF_INET;
    SCNetworkReachabilityRef defaultRouteReachability = SCNetworkReachabilityCreateWithAddress(NULL, (struct sockaddr *)&zeroAddress);
    SCNetworkReachabilityFlags flags;
    SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags);
    Network_Type typeSet = Network_NONE;
    
    if ((flags & kSCNetworkReachabilityFlagsReachable) == 0)
    {
        //NSLog(@"Network_Type is %d",typeSet);
        return Network_NONE;
    }
    
    if ((flags & kSCNetworkReachabilityFlagsConnectionRequired) == 0)
    {
        typeSet = Network_WIFI;
    }
    
    if ((((flags & kSCNetworkReachabilityFlagsConnectionOnDemand ) != 0) ||(flags & kSCNetworkReachabilityFlagsConnectionOnTraffic) != 0))
    {
        if ((flags & kSCNetworkReachabilityFlagsInterventionRequired) == 0)
        {
            typeSet = Network_WIFI;
        }
    }
    
    if ((flags & kSCNetworkReachabilityFlagsIsWWAN) == kSCNetworkReachabilityFlagsIsWWAN)
    {
        if ((flags & kSCNetworkReachabilityFlagsReachable) == kSCNetworkReachabilityFlagsReachable)
        {
            if ((flags & kSCNetworkReachabilityFlagsTransientConnection) == kSCNetworkReachabilityFlagsTransientConnection)
            {
                typeSet = Network_3G;
            }
            else if((flags & kSCNetworkReachabilityFlagsConnectionRequired) == kSCNetworkReachabilityFlagsConnectionRequired)
            {
                typeSet = Network_2G;
            }
            else
            {
                typeSet = Network_4G;
            }
        }
    }
    
    // NSLog(@"Network_Type is %d",typeSet);
    return typeSet;
}

-(void)dealloc
{
    mStartDate             = nil;
    self.mTheCallBackBlock = nil;
}

@end
