//
//  UserInfo.h
//  QzoneUp
//
//  Created by melon on 2017/12/22.
//  Copyright © 2017年 melon. All rights reserved.
//

#import <Foundation/Foundation.h>
#define UserInfo   [UserModel share]
@interface UserModel : NSObject
@property (nonatomic, assign) NSInteger id;

@property (nonatomic, assign) CGFloat discount;

@property (nonatomic, assign) NSInteger vip_end;

@property (nonatomic, assign) NSInteger federated;

@property (nonatomic, copy) NSString *channel;

@property (nonatomic, copy) NSString *uaid;

@property (nonatomic, copy) NSString *avatar;

@property (nonatomic, assign) NSInteger platform;

@property (nonatomic, assign) NSInteger vip_type;

@property (nonatomic, copy) NSString *nickname;

@property (nonatomic, assign) NSInteger score;

@property (nonatomic, assign) NSInteger status;

@property (nonatomic, copy) NSString *phone;

@property (nonatomic, assign) BOOL first_recharge;

@property (nonatomic, assign) BOOL is_refund;

@property (nonatomic, assign) BOOL show_red;

@property (nonatomic, copy) NSString *openid;
+(instancetype)share;
-(void)save;
-(BOOL)isLogin;
-(BOOL)isVip;
-(void)clear;
@end
