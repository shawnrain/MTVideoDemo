//
//  PayOrderModel.h
//  pay
//
//  Created by melon on 2017/12/22.
//  Copyright © 2017年 melon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PayOrderModel : NSObject
@property (nonatomic, copy) NSString *code;

@property (nonatomic, copy) NSString *status;

@property (nonatomic, copy) NSString *notify_url;

@property (nonatomic, copy) NSString *success_url;

@property (nonatomic, copy) NSString *pay_url;

@property (nonatomic) PAY_FLOW_LIST pay_flow;
@end
