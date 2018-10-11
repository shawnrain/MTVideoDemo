//
//  PayTool.h
//  KwaiUp
//
//  Created by melon on 2018/1/4.
//  Copyright © 2018年 melon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PayStyleView.h"
typedef NS_ENUM(NSInteger,PayFinishType){
    PayFinishTypeSuccess, //支付成功
    PayFinishTypeFailure,//支付失败
    PayFinishTypeError,//支付错误
    PayFinishTypeClose,//支付关闭
    PayFinishTypeNone,//未支付
};
typedef void(^PayFinishBlock)(PayFinishType type);
@interface PayTool : UIViewController
+ (void)payWithViewController:(UIViewController *)vc good_id:(NSInteger)good_id price:(NSString *)price label:(NSString *)label finish:(PayFinishBlock)finish;

+ (void)payCampaignWithViewController:(UIViewController *)vc good_id:(NSInteger)good_id price:(NSString *)price campaign_category:(NSInteger)campaign_category label:(NSString *)label campaign_id:(NSInteger)campaign_id finish:(PayFinishBlock)finish;
@end
