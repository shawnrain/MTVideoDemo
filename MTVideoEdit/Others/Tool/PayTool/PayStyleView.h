//
//  PayStyleView.h
//  KwaiUp
//
//  Created by melon on 2018/1/18.
//  Copyright © 2018年 melon. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSUInteger, PayStyle) {
    PayStyleAliPay = 1,
    PayStyleWeiXin,
    PayStyleQQ,
    PayStyleNone
};
typedef void(^PayStyleSelectedBlock)(PayStyle style);
@interface PayStyleView : UIView

+ (void)showInVC:(UIViewController *)vc withArray:(NSArray *)dataSource selectedBlock:(PayStyleSelectedBlock)selectedBlock;

+ (void)dismiss;
@end
