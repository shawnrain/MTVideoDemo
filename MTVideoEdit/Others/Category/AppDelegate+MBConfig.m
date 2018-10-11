//
//  AppDelegate+MBConfig.m
//  Constellation
//
//  Created by melon on 2018/7/10.
//  Copyright © 2018年 melon. All rights reserved.
//

#import "AppDelegate+MBConfig.h"
#import <CYLTabBarController/CYLTabBarController.h>
#import <UserNotifications/UserNotifications.h>
#import <IQKeyboardManager/IQKeyboardManager.h>
#import <UMSocialCore/UMSocialCore.h>
#import <AdSupport/AdSupport.h>
#import <Bugly/Bugly.h>
#import <QYSDK.h>
#import <JPush/JPUSHService.h>
#import <WRNavigationBar/WRNavigationBar.h>

#import "CYLPlusButtonSubclass.h"

//#import "LoginVC.h"

#import "BaseNavigationController.h"
//#import "HomeController.h"
//#import "BuyLogController.h"
//#import "ActivityController.h"
//#import "MineController.h"
@implementation AppDelegate (MBConfig)
- (void)configAllThirdPartyWithOptions:(NSDictionary *)launchOptions
{
    [self configUM];
    [self configJPush:launchOptions];
    [self configBugly];
    [self configShenCe];
    [self configQIYU];
}

- (void)mb_setNormal
{
    /*
    [CYLPlusButtonSubclass registerSubclass];
    CYLTabBarController *tabBarController = [[CYLTabBarController alloc] init];
    tabBarController.delegate = self;
    tabBarController.tabBar.barTintColor = [UIColor whiteColor];
    NSDictionary *first = @{
                            CYLTabBarItemTitle : @"刷粉",
                            CYLTabBarItemImage : @"刷粉丝",
                            CYLTabBarItemSelectedImage : @"刷粉丝-选中icon",
                            };
    NSDictionary *seconds = @{
                              CYLTabBarItemTitle : @"活动福利",
                              CYLTabBarItemImage : @"活动列表-未选中",
                              CYLTabBarItemSelectedImage : @"活动列表-选中",
                              };
    NSDictionary *third = @{
                            CYLTabBarItemTitle : @"订单",
                            CYLTabBarItemImage : @"订单-未选中",
                            CYLTabBarItemSelectedImage : @"订单-选中",
                            };
    NSDictionary *fourth = @{
                            CYLTabBarItemTitle : @"我的",
                            CYLTabBarItemImage : @"我的-未选中",
                            CYLTabBarItemSelectedImage : @"我的-选中icon",
                            };
    tabBarController.tabBarItemsAttributes= @[first,seconds,third,fourth];
    BaseNavigationController *nav1 = [[BaseNavigationController alloc] initWithRootViewController:[HomeController new]];
    BaseNavigationController *nav2 = [[BaseNavigationController alloc] initWithRootViewController:[ActivityController new]];
    BaseNavigationController *nav3 = [[BaseNavigationController alloc] initWithRootViewController:[BuyLogController new]];
    BaseNavigationController *nav4 = [[BaseNavigationController alloc] initWithRootViewController:[MineController new]];
    tabBarController.viewControllers=@[nav1,nav2,nav3,nav4];
    
    [self customizeTabBarAppearance:tabBarController];
    self.window= [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = tabBarController;
    [self.window makeKeyAndVisible];*/
}
- (void)configXHLaunchAd
{
    [XHLaunchAd setLaunchSourceType:SourceTypeLaunchImage];
    
    //配置广告数据
    XHLaunchImageAdConfiguration *imageAdconfiguration = [XHLaunchImageAdConfiguration new];
    //广告停留时间
    imageAdconfiguration.duration = 50;
    //广告frame
    imageAdconfiguration.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height * 0.8);
    //广告图片URLString/或本地图片名(.jpg/.gif请带上后缀)
    imageAdconfiguration.imageNameOrURLString = @"";
    //设置GIF动图是否只循环播放一次(仅对动图设置有效)
    imageAdconfiguration.GIFImageCycleOnce = NO;
    //图片填充模式
    imageAdconfiguration.contentMode = UIViewContentModeScaleAspectFill;
    //广告点击打开页面参数(openModel可为NSString,模型,字典等任意类型)
    imageAdconfiguration.openModel = @"";
    //广告显示完成动画
    imageAdconfiguration.showFinishAnimate =ShowFinishAnimateFadein;
    //广告显示完成动画时间
    imageAdconfiguration.showFinishAnimateTime = 0.8;
    //跳过按钮类型
    imageAdconfiguration.skipButtonType = SkipTypeNone;
    //后台返回时,是否显示广告
    imageAdconfiguration.showEnterForeground = NO;
    //显示开屏广告
    [XHLaunchAd imageAdWithImageAdConfiguration:imageAdconfiguration delegate:self];
}
- (void)customizeTabBarAppearance:(CYLTabBarController *)tabBarController
{
    BOOL isReview = [[NSUserDefaults standardUserDefaults] boolForKey:kIsReviewKey];
    
    // 普通状态下的文字属性
    NSMutableDictionary *normalAttrs = [NSMutableDictionary dictionary];
    normalAttrs[NSForegroundColorAttributeName] = [UIColor grayColor];
    
    // 选中状态下的文字属性
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSForegroundColorAttributeName] = HEXCOLOR(0xF5824D);
    
    // 设置文字属性
    UITabBarItem *tabBar = [UITabBarItem appearance];
    [tabBar setTitleTextAttributes:normalAttrs forState:UIControlStateNormal];
    [tabBar setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
}
- (void)mb_configNavigaitonBar
{
    BOOL isReview = [[NSUserDefaults standardUserDefaults] boolForKey:kIsReviewKey];
    // 设置导航栏默认的背景颜色
    [WRNavigationBar wr_setDefaultNavBarBarTintColor: [UIColor whiteColor]];
    // 设置导航栏所有按钮的默认颜色
    [WRNavigationBar wr_setDefaultNavBarTintColor:[UIColor whiteColor]];
    // 设置导航栏标题默认颜色
    [WRNavigationBar wr_setDefaultNavBarTitleColor:[UIColor whiteColor]];
    // 统一设置状态栏样式
    [WRNavigationBar wr_setDefaultStatusBarStyle:UIStatusBarStyleLightContent];
    // 如果需要设置导航栏底部分割线隐藏，可以在这里统一设置
    [WRNavigationBar wr_setDefaultNavBarShadowImageHidden:!isReview];
}


- (void)configKeyboardManager
{
    [IQKeyboardManager sharedManager].enable = YES;
    [IQKeyboardManager sharedManager].enableAutoToolbar= YES;
    [[IQKeyboardManager sharedManager].disabledDistanceHandlingClasses addObject:[QYSessionViewController class]];
    [[IQKeyboardManager sharedManager].disabledToolbarClasses addObject:[QYSessionViewController class]];
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
}
- (void)configUM
{
    [[UMSocialManager defaultManager] openLog:NO];
    [[UMSocialManager defaultManager] setUmSocialAppkey:k_UM_APPKEY];
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:k_WECHAT_APPID appSecret:k_WECHAT_APPSECRET redirectURL:@"http://www.umeng.com/social"];
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatTimeLine appKey:k_WECHAT_APPID appSecret:k_WECHAT_APPSECRET redirectURL:@"http://www.umeng.com/social"];
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:k_QQ_APPID appSecret:nil redirectURL:@"http://www.umeng.com/social"];
}
- (void)configJPush:(NSDictionary *)launchOptions
{
    NSString *advertisingId = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
    entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound;
    [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
    [JPUSHService setupWithOption:launchOptions appKey:k_PUSH_APPKEY
                          channel:@"Publish channel"
                 apsForProduction:!(isDebug)
            advertisingIdentifier:advertisingId];
    [JPUSHService registrationIDCompletionHandler:^(int resCode, NSString *registrationID) {
        if(resCode == 0){
            NSLog(@"registrationID获取成功：%@",registrationID);
        }else{
            NSLog(@"registrationID获取失败，code：%d",resCode);
        }
    }];
}
- (void)configBugly
{
    [Bugly startWithAppId:k_BUG_APPID];
}
- (void)configShenCe
{
    NSDictionary *dict = [[NSBundle mainBundle] infoDictionary];
    NSString *appName = [dict objectForKey:@"CFBundleDisplayName"];
    if (kStringIsEmpty(appName)) {
        appName = [NSString stringWithFormat:@"%ld",UAID];
    }
    [SensorsAnalyticsSDK sharedInstanceWithServerURL:SA_SERVER_URL
                                        andDebugMode:SA_DEBUG_MODE];
    [[SensorsAnalyticsSDK sharedInstance] registerSuperProperties:@{
                                                                    @"platform" : @"IOS",
                                                                    @"appName" : appName,
                                                                    @"uniqueApplicationId" : @(UAID),
                                                                    @"systemSeries" : @"K",
                                                                    @"marketPosition" : marketPosition
                                                                    }];
    [[SensorsAnalyticsSDK sharedInstance] enableAutoTrack:SensorsAnalyticsEventTypeAppStart |
     SensorsAnalyticsEventTypeAppEnd |
     SensorsAnalyticsEventTypeAppViewScreen |
     SensorsAnalyticsEventTypeAppClick];
}
- (void)configQIYU
{
    NSDictionary *info = [[NSBundle mainBundle] infoDictionary];
    NSString *appName = [info objectForKey:@"CFBundleDisplayName"];
    [[QYSDK sharedSDK] registerAppId:k_QIYU_APPID appName:appName];
    [self setQIYUInfo];
}
- (void)setQIYUInfo
{
    if (UserInfo.isLogin) {
        [[QYSDK sharedSDK] customUIConfig].customerHeadImageUrl = UserInfo.avatar;
        QYUserInfo *userInfo = [QYUserInfo new];
        userInfo.userId = [NSString stringWithFormat:@"A%ld",UserInfo.id];
        NSMutableArray *array = [NSMutableArray new];
        NSMutableDictionary *dictRealName = [NSMutableDictionary new];
        [dictRealName setObject:@"real_name" forKey:@"key"];
        [dictRealName setObject:UserInfo.nickname forKey:@"value"];
        [array addObject:dictRealName];
        
        NSMutableDictionary *dictAcatar = [NSMutableDictionary new];
        [dictAcatar setObject:@"avatar" forKey:@"key"];
        [dictAcatar setObject:UserInfo.avatar forKey:@"value"];
        [array addObject:dictAcatar];
        
        NSMutableDictionary *dictPhone = [NSMutableDictionary new];
        [dictPhone setObject:@"mobile_phone" forKey:@"key"];
        [dictPhone setObject:@(YES) forKey:@"hidden"];
        [array addObject:dictPhone];
        
        NSMutableDictionary *dictEmail = [NSMutableDictionary new];
        [dictEmail setObject:@"email" forKey:@"key"];
        [dictEmail setObject:@(YES) forKey:@"hidden"];
        [array addObject:dictEmail];
        
        NSMutableDictionary *dictUser = [NSMutableDictionary new];
        [dictUser setObject:@"0" forKey:@"index"];
        [dictUser setObject:@"userId" forKey:@"key"];
        [dictUser setObject:@"用户ID" forKey:@"label"];
        [dictUser setObject:@(UserInfo.id) forKey:@"value"];
        [array addObject:dictUser];
        
        NSMutableDictionary *dictScore= [NSMutableDictionary new];
        [dictScore setObject:@"1" forKey:@"index"];
        [dictScore setObject:@"score" forKey:@"key"];
        [dictScore setObject:@"剩余积分" forKey:@"label"];
        [dictScore setObject:@(UserInfo.score) forKey:@"value"];
        [array addObject:dictScore];
        
        NSDictionary *dict = [[NSBundle mainBundle] infoDictionary];
        NSString *appName = [dict objectForKey:@"CFBundleDisplayName"];
        NSMutableDictionary *dictAppName= [NSMutableDictionary new];
        [dictAppName setObject:@"2" forKey:@"index"];
        [dictAppName setObject:@"appname" forKey:@"key"];
        [dictAppName setObject:@"应用名称" forKey:@"label"];
        [dictAppName setObject:appName forKey:@"value"];
        [array addObject:dictAppName];
        NSData *data = [NSJSONSerialization dataWithJSONObject:array
                                                       options:0
                                                         error:nil];
        if (data){
            userInfo.data = [[NSString alloc] initWithData:data
                                                  encoding:NSUTF8StringEncoding];
        }
        [[QYSDK sharedSDK] setUserInfo:userInfo];
    }
}

#pragma mark - DeviceToken
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    /// Required - 注册 DeviceToken
    [JPUSHService registerDeviceToken:deviceToken];
}
- (void)application:(UIApplication *)app didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    DLog(@"DeviceToken获取失败，code：%ld",(long)error.code);
}

- (void)application:(UIApplication*)application didReceiveRemoteNotification:(NSDictionary*)userInfo
{
    //jpush
    [JPUSHService handleRemoteNotification:userInfo];
}
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    // Required, iOS 7 Support
    [JPUSHService handleRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
}
#pragma mark- JPUSHRegisterDelegate
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wunguarded-availability"
// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler {
    // Required
    NSDictionary * userInfo = notification.request.content.userInfo;
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    completionHandler(UNNotificationPresentationOptionBadge|UNNotificationPresentationOptionSound|UNNotificationPresentationOptionAlert);
}

#pragma clang diagnostic ignored "-Wstrict-prototypes"
// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
    // Required
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    completionHandler();  // 系统要求执行这个方法
}


- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString *,id> *)options {
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url];
    return result;
}


#pragma mark ======================== UITabBarControllerDelegate ========================
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    CYLTabBarController *tabBar = (CYLTabBarController *)tabBarController;
    NSInteger index = [tabBar.viewControllers indexOfObject:viewController];
    switch (index) {
        case 0:
            [[SensorsAnalyticsSDK sharedInstance] track:MainBottomFensi];
            break;
        case 1:
            [[SensorsAnalyticsSDK sharedInstance] track:MainBottomActivity];
            break;
        case 2:
        {
            if (![UserInfo isLogin]) {
                [YLHUDManager showMessage:@"你还未登录,请登录" duration:1.0f complection:^{
                    UIViewController *viewController = tabBar.selectedViewController;
//                    LoginVC *login = [LoginVC new];
//                    login.finish = ^{
//                        [QOnlineConfigTool updateIsOrder];
//                    };
//                    [viewController presentViewController:login animated:YES completion:nil];
                }];
            }
            [[SensorsAnalyticsSDK sharedInstance] track:MainBottomOrder];
        }
            
            break;
        case 3:
            [[SensorsAnalyticsSDK sharedInstance] track:MainBottomPerson];
            break;
        default:
            break;
    }
}

@end
