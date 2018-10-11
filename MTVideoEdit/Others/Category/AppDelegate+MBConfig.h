//
//  AppDelegate+MBConfig.h
//  Constellation
//
//  Created by melon on 2018/7/10.
//  Copyright © 2018年 melon. All rights reserved.
//

#import "AppDelegate.h"
#import <JPush/JPUSHService.h>
#import <XHLaunchAd/XHLaunchAd.h>
@interface AppDelegate (MBConfig)<JPUSHRegisterDelegate,UITabBarControllerDelegate>

- (void)configAllThirdPartyWithOptions:(NSDictionary *)launchOptions;

- (void)mb_setNormal;

- (void)mb_configNavigaitonBar;

- (void)setQIYUInfo;

- (void)configKeyboardManager;


- (void)configXHLaunchAd;

@end
