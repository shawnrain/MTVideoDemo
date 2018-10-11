//
//  UMShareTool.m
//  weicou
//
//  Created by couba001 on 2017/4/17.
//  Copyright © 2017年 couba. All rights reserved.
//

#import "UMShareTool.h"

@implementation UMShareTool
+(UMShareTool *)sharedInstance
{
    static dispatch_once_t DeviceDBHelperonce;
    static UMShareTool * DeviceDBHelperstatic;
    dispatch_once(&DeviceDBHelperonce, ^{
        DeviceDBHelperstatic = [[UMShareTool alloc] init];
    });
    return DeviceDBHelperstatic;
}

- (void)thirdLoginThithLoginType:(UMSocialPlatformType)LoginType complete:(void(^)(UMSocialUserInfoResponse *resp,NSError *mError))complete
{
    [[UMSocialManager defaultManager] getUserInfoWithPlatform:LoginType currentViewController:nil completion:^(id result, NSError *error) {
        UMSocialUserInfoResponse *resp = result;
        if (complete) {
            complete(resp,error);
        }
    }];
}
@end
