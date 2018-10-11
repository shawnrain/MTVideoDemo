//
//  Config.h
//  QzoneUp
//
//  Created by melon on 2017/12/22.
//  Copyright © 2017年 melon. All rights reserved.
//

#ifndef Config_h
#define Config_h
#pragma mark
#pragma mark - Debug状态
#define kjenkins_config_dict [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"jenkins-config" ofType:@"plist"]]
#define isDebug (![[kjenkins_config_dict objectForKey:@"jenkins_on_line"] boolValue])
#define ReviewTime ([kjenkins_config_dict objectForKey:@"jenkins_review_time"])
#pragma mark

#pragma mark

#define TabbarSafeBottomInsets IphoneX ? 34.0f : 0
#define NavbarSafeTopInsets  IphoneX ? 24.0f : 0
#define TabBarHeight 49.0f
#define NavHeight 64.0f


#pragma mark -
#pragma mark - UserDefault
#define StandardUserDefaults [NSUserDefaults standardUserDefaults]
#define DefaultNotificationCenter [NSNotificationCenter defaultCenter]

#pragma mark -
#pragma mark - 引用相关
#define kWeakSelf          __weak typeof(self) weakSelf = self;
//数组是否为空
#define kArrayIsEmpty(array)            (array == nil \
|| [array isKindOfClass:[NSNull class]] \
|| array.count == 0)

#pragma mark -
#pragma mark - 第三方
/** QQ密钥 */
#define k_QQ_APPID @"1107749153"
#define k_QQ_APPKEY @"fPulD5Tj7DX8Cr7E"
/** QQ Bugly */
#define k_BUG_APPID @"b2f8bbd533"
#define k_BUG_APPKEY @"e9cd1b2d-1697-4e42-9725-ecbb53c2c6f0"
/** 友盟 */
#define k_UM_APPKEY @"599177d2bbea8376f1001791"
/** 极光 */
#define k_PUSH_APPKEY @"0082d31773f35c163d71b38a"
/** 微信 */
#define k_WECHAT_APPID @"wxa4bdcc8b5e02663e"
#define k_WECHAT_APPSECRET @"daef6554f929d42234ea1b7ded2772a9"
/** 七鱼客服 */
#define k_QIYU_APPID @"8568eccd7b3ba7b90a96866ce77de2d4"
/** 神策统计 */
//#define SA_SERVER_URL @"http://melonblock.cloud.sensorsdata.cn:8006/sa?project=default&token=08fcc11f3a83a683"//测试环境
#define SA_SERVER_URL @"http://melonblock.cloud.sensorsdata.cn:8006/sa?project=melon&token=08fcc11f3a83a683"//正式环境
#define SA_DEBUG_MODE SensorsAnalyticsDebugOff
#endif /* Config_h */
