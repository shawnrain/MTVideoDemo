//
//  NSDate+Time.m
//  BaiSi
//
//  Created by cy on 16/1/31.
//  Copyright © 2016年 cy. All rights reserved.
//

#import "NSDate+Time.h"

@implementation NSDate (Time)
/** 是否是今年 */
- (BOOL)isInThisYear
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSInteger nowComps = [calendar component:NSCalendarUnitYear fromDate:self];
    NSInteger selfComps = [calendar component:NSCalendarUnitYear fromDate:[NSDate date]];
    return nowComps == selfComps;
}

/** 是否是今天 */
- (BOOL)isInToday
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth |NSCalendarUnitDay;
    NSDateComponents *nowComps = [calendar components:unit fromDate:self];
    NSDateComponents *selfComps = [calendar components:unit fromDate:[NSDate date]];
    return nowComps.year == selfComps.year
    &&nowComps.month == selfComps.month
    &&nowComps.day == selfComps.day;
   
}

/** 是否是昨天 */
- (BOOL)isInYesterday
{
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd";
    NSString *nowStr = [fmt stringFromDate:[NSDate date]];
    NSDate *nowDate = [fmt dateFromString:nowStr];
    
    NSString *selfStr = [fmt stringFromDate:self];
    NSDate *selfdate = [fmt dateFromString:selfStr];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth |NSCalendarUnitDay;
    NSDateComponents *cmps = [calendar components:unit fromDate:selfdate toDate:nowDate options:kNilOptions];
    
    return cmps.year == 0
    && cmps.month == 0
    && cmps.day == 1;
}

/** 是否是本月 */
- (BOOL)isInThisMonth
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth;
    NSDateComponents *nowComps = [calendar components:unit fromDate:self];
    NSDateComponents *selfComps = [calendar components:unit fromDate:[NSDate date]];
    return nowComps.year == selfComps.year
    &&nowComps.month == selfComps.month;
}
@end
