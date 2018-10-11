//
//  NSString+KKAddtions.m
//  kankan
//
//  Created by MTShawn on 2018/7/31.
//  Copyright © 2018年 MT. All rights reserved.
//

#import "NSString+KKAddtions.h"

@implementation NSString (KKAddtions)
- (NSDate *)getDate:(NSString *)dateFormat {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:dateFormat];
    return [formatter dateFromString:self];
}
@end
