//
//  UMShareTool.h
//  weicou
//
//  Created by couba001 on 2017/4/17.
//  Copyright © 2017年 couba. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UMSocialCore/UMSocialCore.h>
@interface UMShareTool : NSObject
+ (instancetype)sharedInstance;

- (void)thirdLoginThithLoginType:(UMSocialPlatformType)LoginType complete:(void(^)(UMSocialUserInfoResponse *result,NSError *error))complete;
@end
