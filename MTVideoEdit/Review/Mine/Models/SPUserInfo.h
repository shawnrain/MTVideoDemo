//
//  SPUserInfo.h
//  shipingdiandian
//
//  Created by MTShawn on 2018/7/20.
//  Copyright © 2018年 MT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface SPUserInfo : NSObject

@property (nonatomic, copy) NSString * name;//
@property (nonatomic, copy) NSString * avtar;//
@property (nonatomic, copy) NSString * info;//
@property (nonatomic, assign) BOOL      login;//
@property (nonatomic, assign) NSInteger score;//积分
@property (nonatomic, strong) NSDate   * date;//
@property (nonatomic, assign) NSInteger  userId;
@property (nonatomic, assign) NSInteger  videoSelected;
@property (nonatomic, strong) NSMutableArray  * messageArray;
+ (instancetype)shareInstance;
+ (void)archiveUserInstance;
- (void)resetInstance;
+ (void)setUserDefault:(NSString *)lStr;
+ (NSString *)getInstancename;
@end
