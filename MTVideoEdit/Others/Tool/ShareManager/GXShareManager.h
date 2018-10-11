//
//  GXShare.h
//  RedEnvelopes
//
//  Created by fuguangxin on 16/8/24.
//  Copyright © 2016年 wazrx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UMSocialCore/UMSocialCore.h>

@interface GXShareManager : NSObject

typedef void (^GXShareComplete)(BOOL isSystemShare , BOOL success, UMSocialResponse * response);
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wstrict-prototypes"
typedef void (^GXConfiguration)(void);
#pragma clang diagnostic pop



+ (instancetype)defaultManager;

/**
 *  单个平台分享
 */
+ (void)shareInController:(UIViewController *)controller canSystemShare:(BOOL)canSystemShare type:(UMSocialPlatformType)type title:(NSString *)title shareText:(NSString *)shareText shareImage:(UIImage *)shareImage url:(NSString *)url configuration:(GXConfiguration)configuration complete:(GXShareComplete)complete;





@end

@interface GXShareHelpViewController : UIViewController

@end
