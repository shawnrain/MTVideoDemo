//
//  UIViewController+Login.h
//  shipingdiandian
//
//  Created by MTShawn on 2018/7/23.
//  Copyright © 2018年 MT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <UMSocialCore/UMSocialCore.h>
typedef void(^complemtation)(BOOL success);
@interface UIViewController (Helper)
- (void)login:(complemtation)block;
- (void)loginOut:(void (^)(void))block;
- (void)shareWithType:(UMSocialPlatformType)type videourl:(NSString *)url;
@end
