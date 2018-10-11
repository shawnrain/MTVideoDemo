//
//  YLHUDManager.h
//  HUD
//
//  Created by melon on 2017/12/19.
//  Copyright © 2017年 melon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MBProgressHUD/MBProgressHUD.h>
typedef void (^MBProgressHUDManagerCompletionBlock)(void);
@interface YLHUDManager : NSObject
@property (strong, nonatomic) MBProgressHUD *HUD;
@property (nonatomic, copy) MBProgressHUDCompletionBlock completionBlock;
+ (instancetype)manager;

+ (void)showMessage:(NSString *)message;
+ (void)showMessage:(NSString *)message duration:(NSTimeInterval)duration;
+ (void)showMessage:(NSString *)message duration:(NSTimeInterval)duration complection:(MBProgressHUDCompletionBlock)completion;


+ (void)showIndicatorWithMessage:(NSString *)message;
+ (void)showIndicatorWithMessage:(NSString *)message duration:(NSTimeInterval)duration;
+ (void)showIndicatorWithMessage:(NSString *)message duration:(NSTimeInterval)duration complection:(MBProgressHUDCompletionBlock)completion;

+ (void)hide;
+ (void)hideWithAfterDelay:(NSTimeInterval)duration;
+ (void)hideWithAfterDelay:(NSTimeInterval)duration completion:(MBProgressHUDCompletionBlock)completion;
@end
