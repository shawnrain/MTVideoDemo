//
//  CommonTool.h
//  Kmusic
//
//  Created by melon on 2017/11/8.
//  Copyright © 2017年 cy. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSInteger, sensorsType) {
    sensorsTypeItem,
    sensorsTypeSubmit,
    sensorsTypeHelp
};
@interface SensorsTool : NSObject
@property (nonatomic) sensorsType type;
+ (void)sensorsAnalytics:(NSString *)label type:(sensorsType)type;
@end
