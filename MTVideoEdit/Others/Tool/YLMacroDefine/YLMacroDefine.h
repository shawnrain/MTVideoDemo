//
//  YLMacroDefine_h
//  wanghongshenqi
//
//  Created by melon on 2018/5/7.
//  Copyright © 2018年 melon. All rights reserved.
//

#ifndef YLMacroDefine_h
#define YLMacroDefine_h


#pragma mark - Size
//Iphone4s
#define IPhone4S                       ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), \
    [[UIScreen mainScreen] currentMode].size) : NO)

//Iphone5
#define IPhone5                         ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), \
    [[UIScreen mainScreen] currentMode].size) : NO)

//Iphone6
#define IPhone6                         ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), \
    [[UIScreen mainScreen] currentMode].size) : NO)

//Iphone6p
#define IPhone6P                        ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), \
    [[UIScreen mainScreen] currentMode].size) : NO)

//IphoneX
#define IphoneX                        ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? \
    CGSizeEqualToSize(CGSizeMake(1125, 2436), \
    [[UIScreen mainScreen] currentMode].size) : NO)

//屏幕 宽度
#define kScreenWidth                   ([UIScreen mainScreen].bounds.size.width)
//屏幕 宽度
#define kScreenHeight                  ([UIScreen mainScreen].bounds.size.height)
//Navbar Safety Top Insets
#define kSafeAreaInsetsTop             (IphoneX ? 24.0f : 0)
//Tabbar Safety Bottom Insets
#define kSafeAreaInsetsBottom          (IphoneX ? 34.0f : 0)
//Tabbar Default Height
#define kDefaultTabBarHeight           (49.f)
//Navbar Default Height
#define kDefaultNavHeight              (64.f)
//Tabbar Normal Height
#define kTabbarHeight                  (IphoneX?kSafeAreaInsetsBottom+kDefaultTabBarHeight:kDefaultTabBarHeight)
//NaviBar Normal Height
#define kNaviBarHeight                 (IphoneX?kSafeAreaInsetsTop+kDefaultNavHeight:kDefaultNavHeight)

#define kAdaptWidth(value)             (value)*(kScreenWidth)/375.f
#define kAdaptHeight(value)            (value)*(kScreenHeight)/667.f

#pragma mark - Sysytem default
//Application
#define kApplication                    [UIApplication sharedApplication]
//KeyWindow
#define kKeyWindow                      [UIApplication sharedApplication].keyWindow
//AppDelegate
#define kAppDelegate                    ((AppDelegate*)[UIApplication sharedApplication].delegate)
//UserDefaults
#define kUserDefaults                   [NSUserDefaults standardUserDefaults]
//NotificationCenter
#define kNotificationCenter             [NSNotificationCenter defaultCenter]

#pragma mark - Color Function
#define HEXCOLOR(rgbValue)              [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
       green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
        blue:((float)((rgbValue & 0xFF))/255.0) \
       alpha:1.0]

#define RGBCOLOR(r,g,b)                 [UIColor \
colorWithRed:(r)/255.0f \
       green:(g)/255.0f \
        blue:(b)/255.0f \
        alpha:1]

#define RGBACOLOR(r,g,b,a)              [UIColor \
colorWithRed:(r)/255.0f \
       green:(g)/255.0f \
        blue:(b)/255.0f \
       alpha:(a)]


#pragma mark - Empty
//字符串是否为空
#define kStringIsEmpty(str)             ([str isKindOfClass:[NSNull class]] \
|| str == nil \
|| str.length == 0)
//数组是否为空
#define kArrayIsEmpty(array)            (array == nil \
|| [array isKindOfClass:[NSNull class]] \
|| array.count == 0)
//字典是否为空
#define kDictIsEmpty(dic)               (dic == nil \
|| [dic isKindOfClass:[NSNull class]] \
|| dic.allKeys == 0)
//是否是空对象
#define kObjectIsEmpty(_object)         (_object == nil \
|| [_object isKindOfClass:[NSNull class]] \
|| ([_object respondsToSelector:@selector(length)] && [(NSData *)_object length] == 0) \
|| ([_object respondsToSelector:@selector(count)] && [(NSArray *)_object count] == 0))

#pragma mark - Other
//由角度转换弧度
#ifndef kDegreesToRadian
#define kDegreesToRadian(x)             (M_PI * (x) / 180.0)
#endif

//由弧度转换角度
#ifndef kRadianToDegrees
#define kRadianToDegrees(radian)        (radian * 180.0) / (M_PI)
#endif

//判断block存在后执行
#ifndef doBlock
#define doBlock(_b_, ...)               if(_b_){_b_(__VA_ARGS__);}
#endif

//程序的本地化,引用国际化的文件
#ifndef MyLocalStr
#define MyLocalStr(_s_)                 NSLocalizedString((_s_), nil)
#endif


#pragma mark - Synthsize a weak or strong reference.
/**
 Example:
 @weakify(self)
 [self doSomething^{
 @strongify(self)
 if (!self) return;
 ...
 }];
 
 */
// weak reference
#ifndef weakify
#if DEBUG
#if __has_feature(objc_arc)
#define weakify(object) __weak __typeof__(object) weak##_##object = object
#else
#define weakify(object) __block __typeof__(object) block##_##object = object
#endif
#else
#if __has_feature(objc_arc)
#define weakify(object) __weak __typeof__(object) weak##_##object = object
#else
#define weakify(object) __block __typeof__(object) block##_##object = object
#endif
#endif
#endif

#ifndef strongify
#if DEBUG
#if __has_feature(objc_arc)
#define strongify(object) __typeof__(object) object = weak##_##object
#else
#define strongify(object) __typeof__(object) object = block##_##object
#endif
#else
#if __has_feature(objc_arc)
#define strongify(object) __typeof__(object) object = weak##_##object
#else
#define strongify(object) __typeof__(object) object = block##_##object
#endif
#endif
#endif



#pragma mark - Log
#ifdef DEBUG
#define DLog(FORMAT, ...) fprintf(stderr, "\
\n================================================\n\
File\t===>\t%s\n\
SEL\t===>\t%s\n\
Line\t===>\t%d\n\n\
LOG\t===>\t%s\
\n================================================\n",\
[[[NSString stringWithUTF8String: __FILE__] lastPathComponent] UTF8String],\
__FUNCTION__, \
__LINE__, \
[[NSString stringWithFormat: FORMAT, ## __VA_ARGS__] UTF8String]);
#else

#define DLog(...)

#endif


#endif
