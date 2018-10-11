//
//  UIViewController+Login.m
//  shipingdiandian
//
//  Created by MTShawn on 2018/7/23.
//  Copyright © 2018年 MT. All rights reserved.
//

#import "UIViewController+Helper.h"
//#import "SPLoginViewController.h"
#import "SPUserInfo.h"
@implementation UIViewController (Helper)
- (void)login:(complemtation)block{
    SPUserInfo * userInfo = [SPUserInfo shareInstance];
    if (userInfo.login) {
        if (block) {
            block(true);
        }
        return;
    }
//    SPLoginViewController * loginVc = [[SPLoginViewController alloc] init];
//    [loginVc setLoginBlock:^(BOOL loginSuccess) {
//        if (block) {
//            block(loginSuccess);
//        }
//    }];
//    UINavigationController * nava = [[UINavigationController alloc] initWithRootViewController:loginVc];
//    [self presentViewController:nava animated:YES completion:nil];
}

- (void)loginOut:(void (^)(void))block{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:nil preferredStyle:UIAlertControllerStyleAlert];
    NSMutableAttributedString * alertAttString = [[NSMutableAttributedString alloc] initWithString:@"是否退出登录？" attributes:@{NSFontAttributeName : [UIFont fontWithName:@"PingFangSC-Regular" size:16],NSForegroundColorAttributeName : color555555}];
    [alertController setValue:alertAttString forKey:@"attributedMessage"];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [cancelAction setValue:color999999 forKey:@"titleTextColor"];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (block) {
            block();
        }
    }];
    [okAction setValue:color555555 forKey:@"titleTextColor"];
    [alertController addAction:cancelAction];
    [alertController addAction:okAction];
    [self presentViewController:alertController animated:YES completion:nil];
}
- (void)shareWithType:(UMSocialPlatformType)type videourl:(NSString *)url{
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    [[UMSocialManager defaultManager] openLog:YES];
    //创建网页内容对象
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:@"快点点助手" descr:@"" thumImage:[UIImage imageNamed:@""]];
    //设置网页地址
    shareObject.webpageUrl = url;
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    messageObject.title = @"快点点助手";
    messageObject.text = url;
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:type messageObject:messageObject currentViewController:self completion:^(UMSocialShareResponse *result, NSError *error) {
        if (result) {
           // [[MTUserInstance shareInstance] addTaskType:MTHomeTypeShare];
        }
    }];
}
@end
