//
//  MHHUD.m
//  Merchandising
//
//  Created by fingle on 2017/6/19.
//  Copyright © 2017年 Cloudwave. All rights reserved.
//

#import "MHHUD.h"
#import "SVProgressHUD.h"
#define SV_APP_EXTENSIONS 1
@implementation MHHUD
+ (void)load
{
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleCustom];
    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
    [SVProgressHUD setBackgroundColor:[UIColor blackColor]];
}

+ (void)showMessage:(NSString *)message dissmissDelay:(NSTimeInterval)delay{
    
    [self customHUDMessage:message];
    [SVProgressHUD dismissWithDelay:delay];
    
}

+ (void)showMessage:(NSString *)message offset:(UIOffset)offset{
    
    [self showMessage:message];
    [SVProgressHUD setOffsetFromCenter:offset];
}
+ (void)showMessage:(NSString *)message{
    [self customHUDMessage:message];
    [SVProgressHUD dismissWithDelay:2];
    
}
+ (void)showMessage:(NSString *)message dissmissDelay:(NSTimeInterval)delay completion:(SVProgressHUDDismissCompletion)completion{
    [self customHUDMessage:message];
    [SVProgressHUD dismissWithDelay:delay completion:completion];
}
+ (void)customHUDMessage:(NSString *)message{
    [SVProgressHUD setFont:[UIFont systemFontOfSize:13]];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleCustom];
    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
    [SVProgressHUD setBackgroundColor:[UIColor blackColor]];
    [SVProgressHUD setInfoImage:nil];
    [SVProgressHUD setCornerRadius:3];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    [SVProgressHUD showInfoWithStatus:message];
    [SVProgressHUD setOffsetFromCenter:UIOffsetZero];
}
+ (void)show{
    [SVProgressHUD setOffsetFromCenter:UIOffsetZero];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleCustom];
    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
    [SVProgressHUD setBackgroundColor:[UIColor blackColor]];
    [SVProgressHUD show];
    
}
+ (void)dissmiss{
    [SVProgressHUD dismiss];
}
@end
