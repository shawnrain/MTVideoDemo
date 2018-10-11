//
//  CommonTool.h
//  KwaiUp
//
//  Created by melon on 2018/3/30.
//  Copyright © 2018年 melon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommonTool : NSObject
+ (NSArray<NSString *> *)subUrlToOrderWithServiceList:(SERVICE_LIST)category url:(NSString *)url;
@end
