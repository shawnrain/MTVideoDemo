//
//  MHHUD.h
//  Merchandising
//
//  Created by fingle on 2017/6/19.
//  Copyright © 2017年 Cloudwave. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SVProgressHUD/SVProgressHUD.h>
@interface MHHUD : UIView
+ (void)showMessage:(NSString *)message dissmissDelay:(NSTimeInterval)delay;
+ (void)showMessage:(NSString *)message;
+ (void)showMessage:(NSString *)message dissmissDelay:(NSTimeInterval)delay completion:(SVProgressHUDDismissCompletion)completion;
+ (void)show;
+ (void)showMessage:(NSString *)message offset:(UIOffset)offset;
+ (void)dissmiss;
@end
