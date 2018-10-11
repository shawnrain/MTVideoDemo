//
//  QOnlineConfigTool.h
//  KwaiUp
//
//  Created by melon on 2018/1/2.
//  Copyright © 2018年 melon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QOnlineConfigTool : NSObject
+(BOOL)isReview;
+(NSString*)getValueForKey:(NSString*)key;
+(void)updataAllKey;
+ (void)updateIsOrder;
+ (void)isUSAIp:(void(^)(BOOL isUSAIp))complete;
@end
