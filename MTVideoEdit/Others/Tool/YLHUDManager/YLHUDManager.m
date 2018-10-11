//
//  YLHUDManager.m
//  HUD
//
//  Created by melon on 2017/12/19.
//  Copyright © 2017年 melon. All rights reserved.
//

#import "YLHUDManager.h"

@interface  YLHUDManager ()<MBProgressHUDDelegate>

@end
@implementation YLHUDManager
+ (instancetype)manager
{
    static YLHUDManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[YLHUDManager alloc] init];
    });
    return manager;
}
#pragma mark - Private
- (void)createHUDWithMode:(MBProgressHUDMode)mode
{
    if (!self.HUD) {
        self.HUD = [[MBProgressHUD alloc] initWithView:[UIApplication sharedApplication].keyWindow.rootViewController.view];
        self.HUD.delegate = self;
        self.HUD.userInteractionEnabled = NO;
        self.HUD.removeFromSuperViewOnHide = NO;
        self.HUD.animationType = MBProgressHUDAnimationFade;
        self.HUD.bezelView.color = [UIColor colorWithWhite:0 alpha:0.8];
        [UIActivityIndicatorView appearanceWhenContainedIn:[MBProgressHUD class], nil].color = [UIColor whiteColor];
        [[UIApplication sharedApplication].keyWindow addSubview:self.HUD];
    }
}
- (void)hideWithAfterDuration:(NSTimeInterval)duration completion:(MBProgressHUDCompletionBlock)completion
{
    self.completionBlock = completion;
    if (!self.HUD){
        if (self.completionBlock) {
            self.completionBlock();
            self.completionBlock = NULL;
        }
        return;
    }
    dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), ^{
        sleep(duration);
        dispatch_async(dispatch_get_main_queue(), ^{
            completion();
            [self.HUD hideAnimated:YES];
        });
    });
}
- (void)showMessage:(NSString *)message mode:(MBProgressHUDMode)mode duration:(NSTimeInterval)duration animated:(BOOL)animated complection:(void (^)(void))completion
{
    [self createHUDWithMode:mode];
    self.HUD.mode = mode;
    if (mode == MBProgressHUDModeIndeterminate) {
        self.HUD.label.font = [UIFont boldSystemFontOfSize:14.0f];
    }else{
        self.HUD.label.font = [UIFont boldSystemFontOfSize:15.0f];
    }
    self.HUD.label.text = message;
    self.HUD.label.textColor = [UIColor whiteColor];
    CGSize maxSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    CGSize textSize = [message boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.HUD.label.font} context:nil].size;
    if (textSize.width > (self.HUD.frame.size.width - self.HUD.margin*4)){
        self.HUD.label.text = @"";
        self.HUD.detailsLabel.font = [UIFont boldSystemFontOfSize:15.0f];
        self.HUD.detailsLabel.text = message;
    }
    [self.HUD showAnimated:YES];
    if (completion) {
        [self hideWithAfterDuration:duration completion:completion];
    }else{
        self.completionBlock = NULL;
        if (duration>=0) {
            [self.HUD hideAnimated:animated afterDelay:duration];
        }
    }
}
#pragma mark - Public
//Show Text
+ (void)showMessage:(NSString *)message
{
    [YLHUDManager showMessage:message duration:-1];
}
+ (void)showMessage:(NSString *)message duration:(NSTimeInterval)duration
{
    [YLHUDManager showMessage:message duration:duration complection:nil];
}
+ (void)showMessage:(NSString *)message duration:(NSTimeInterval)duration complection:(MBProgressHUDCompletionBlock)completion
{
    [[YLHUDManager manager] showMessage:message mode:MBProgressHUDModeText duration:duration animated:YES complection:completion];
}

//Show UIActivityIndicatorView
+ (void)showIndicatorWithMessage:(NSString *)message
{
    [YLHUDManager showIndicatorWithMessage:message duration:-1];
}

+ (void)showIndicatorWithMessage:(NSString *)message duration:(NSTimeInterval)duration
{
    [YLHUDManager showIndicatorWithMessage:message duration:duration complection:nil];
}

+ (void)showIndicatorWithMessage:(NSString *)message duration:(NSTimeInterval)duration complection:(MBProgressHUDCompletionBlock)completion
{
    [[YLHUDManager manager] showMessage:message mode:MBProgressHUDModeIndeterminate duration:duration animated:YES complection:completion];
}

//Hide
+ (void)hide
{
    [YLHUDManager hideWithAfterDelay:0];
}
+ (void)hideWithAfterDelay:(NSTimeInterval)duration
{
    [YLHUDManager hideWithAfterDelay:duration completion:nil];
}
+ (void)hideWithAfterDelay:(NSTimeInterval)duration completion:(MBProgressHUDCompletionBlock)completion
{
    if (completion) {
        [[YLHUDManager manager] hideWithAfterDuration:duration completion:completion];
    }else{
        if (duration >= 0) {
            [[YLHUDManager manager].HUD hideAnimated:YES afterDelay:duration];
        }else{
            NSAssert(duration >= 0, @"duration must be greater than zero ");
        }
    }
    
}
@end
