//
//  QueryPointModel.h
//  KwaiUp
//
//  Created by melon on 2018/1/29.
//  Copyright © 2018年 melon. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface QueryPointTool : NSObject

+ (instancetype)shared;

+ (void)queryStartPointWithAdition:(NSString *)adition service:(SERVICE_LIST)service complete:(void(^)(NSInteger count))complete;
@end
