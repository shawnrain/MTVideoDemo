//
//  NSDate+YLUtilities.m
//  KwaiUp
//
//  Created by melon on 2018/6/6.
//  Copyright © 2018年 melon. All rights reserved.
//

#import "NSDate+YLUtilities.h"
static const unsigned YL_NSDATE_UTILITIES_COMPONENT_FLAGS = (NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay  |NSCalendarUnitWeekOfYear | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond | NSCalendarUnitWeekday |    NSCalendarUnitWeekdayOrdinal);
@implementation NSDate (YLUtilities)

+ (NSCalendar *)yl_currentCalendar
{
    static NSCalendar *sharedCalendar = nil;
    if (!sharedCalendar)
        sharedCalendar = [NSCalendar autoupdatingCurrentCalendar];
    return sharedCalendar;
}
#pragma mark - String Properties
- (NSString *)yl_stringWithFormat:(NSString *)format
{
    NSDateFormatter *formatter = [NSDateFormatter new];
    formatter.dateFormat = format;
    return [formatter stringFromDate:self];
}
#pragma mark - 从当前日期相对日期时间

+ (NSDate *)yl_dateTomorrow
{
    return [NSDate yl_dateWithDaysFromNow:1];
}

+ (NSDate *)yl_dateYesterday
{
    return [NSDate yl_dateWithDaysBeforeNow:1];
}

+ (NSDate *)yl_dateWithDaysFromNow:(NSInteger)days
{
    return [[NSDate date] yl_dateByAddingDays:days];
}

+ (NSDate *)yl_dateWithDaysBeforeNow:(NSInteger)days
{
    return [[NSDate date] yl_dateBySubtractingDays:days];
}

+ (NSDate *)yl_dateWithHoursFromNow:(NSInteger)hours
{
    NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] + YL_D_HOUR * hours;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}

+ (NSDate *)yl_dateWithHoursBeforeNow:(NSInteger)hours
{
    NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] - YL_D_HOUR * hours;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}

+ (NSDate *)yl_dateWithMinutesFromNow:(NSInteger)minutes
{
    NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] + YL_D_MINUTE * minutes;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}

+ (NSDate *)yl_dateWithMinutesBeforeNow:(NSInteger)minutes
{
    NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] - YL_D_MINUTE * minutes;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}

#pragma mark - Comparing dates 比较时间
- (BOOL)yl_isEqualToDateIgnoringTime:(NSDate *)date
{
    NSDateComponents *components1 = [[NSDate yl_currentCalendar] components:YL_NSDATE_UTILITIES_COMPONENT_FLAGS   fromDate:self];
    NSDateComponents *components2 = [[NSDate yl_currentCalendar] components:YL_NSDATE_UTILITIES_COMPONENT_FLAGS fromDate:date];
    return ((components1.year == components2.year) &&
            (components1.month == components2.month) &&
            (components1.day == components2.day));
}
- (BOOL)yl_isToday
{
    NSDateComponents *components1 = [[NSDate yl_currentCalendar] components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay   fromDate:self];
    NSDateComponents *components2 = [[NSDate yl_currentCalendar] components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:[NSDate date]];
    return ((components1.year == components2.year) &&
            (components1.month == components2.month) &&
            (components1.day == components2.day));
}
- (BOOL)yl_isTomorrow
{
    return [self yl_isEqualToDateIgnoringTime:[NSDate yl_dateTomorrow]];
}
- (BOOL)yl_isYesterday
{
    return [self yl_isEqualToDateIgnoringTime:[NSDate yl_dateYesterday]];
}


- (BOOL)yl_isSameWeekAsDate:(NSDate *)date
{
    NSDateComponents *components1 = [[NSDate yl_currentCalendar] components:YL_NSDATE_UTILITIES_COMPONENT_FLAGS fromDate:self];
    NSDateComponents *components2 = [[NSDate yl_currentCalendar] components:YL_NSDATE_UTILITIES_COMPONENT_FLAGS fromDate:date];
    
    // Must be same week. 12/31 and 1/1 will both be week "1" if they are in the same week
    if (components1.weekOfYear != components2.weekOfYear) return NO;
    
    // Must have a time interval under 1 week. Thanks @aclark
    return (fabs([self timeIntervalSinceDate:date]) < YL_D_WEEK);
}
- (BOOL)yl_isThisWeek
{
    return [self yl_isSameWeekAsDate:[NSDate date]];
}
- (BOOL)yl_isNextWeek
{
    NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] + YL_D_WEEK;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return [self yl_isSameWeekAsDate:newDate];
}
- (BOOL)yl_isLastWeek
{
    NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] - YL_D_WEEK;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return [self yl_isSameWeekAsDate:newDate];
}



- (BOOL)yl_isSameMonthAsDate:(NSDate *)date
{
    NSDateComponents *components1 = [[NSDate yl_currentCalendar] components:NSCalendarUnitYear | NSCalendarUnitMonth   fromDate:self];
    NSDateComponents *components2 = [[NSDate yl_currentCalendar] components:NSCalendarUnitYear | NSCalendarUnitMonth fromDate:date];
    return ((components1.year == components2.year) &&
            (components1.month == components2.month));
}
- (BOOL)yl_isThisMonth
{
    return [self yl_isSameMonthAsDate:[NSDate date]];
}
- (BOOL)yl_isNextMonth
{
    return [self yl_isSameMonthAsDate:[[NSDate date] yl_dateBySubtractingMonths:1]];
}
- (BOOL)yl_isLastMonth
{
    return [self yl_isSameMonthAsDate:[[NSDate date] yl_dateByAddingMonths:1]];
}



- (BOOL)yl_isSameYearAsDate:(NSDate *)date
{
    NSDateComponents *components1 = [[NSDate yl_currentCalendar] components:NSCalendarUnitYear   fromDate:self];
    NSDateComponents *components2 = [[NSDate yl_currentCalendar] components:NSCalendarUnitYear fromDate:date];
    return (components1.year == components2.year);
}
- (BOOL)yl_isThisYear
{
    return [self yl_isSameYearAsDate:[NSDate date]];
}
- (BOOL)yl_isNextYear
{
    NSDateComponents *components1 = [[NSDate yl_currentCalendar] components:NSCalendarUnitYear   fromDate:self];
    NSDateComponents *components2 = [[NSDate yl_currentCalendar] components:NSCalendarUnitYear fromDate:[NSDate date]];
    return (components1.year == (components2.year + 1));
}
- (BOOL)yl_isLastYear
{
    NSDateComponents *components1 = [[NSDate yl_currentCalendar] components:NSCalendarUnitYear   fromDate:self];
    NSDateComponents *components2 = [[NSDate yl_currentCalendar] components:NSCalendarUnitYear fromDate:[NSDate date]];
    return (components1.year == (components2.year - 1));
}

- (BOOL)yl_isWeekDay
{
    return ![self yl_isWeekend];
}

- (BOOL)yl_isWeekend
{
    NSDateComponents *components = [[NSDate yl_currentCalendar] components:NSCalendarUnitWeekday | NSCalendarUnitMonth   fromDate:self];
    if ((components.weekday == 1) ||
        (components.weekday == 7))
        return YES;
    return NO;
}
#pragma mark - Adjusting Dates
- (NSDate *)yl_dateByAddingYears:(NSInteger)years
{
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    [dateComponents setYear:years];
    NSDate *newDate = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:self options:0];
    return newDate;
}
- (NSDate *)yl_dateBySubtractingYears:(NSInteger)years
{
    return [self yl_dateBySubtractingYears:(years * -1)];
}
- (NSDate *)yl_dateByAddingMonths:(NSInteger)months
{
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    [dateComponents setMonth:months];
    NSDate *newDate = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:self options:0];
    return newDate;
}

- (NSDate *)yl_dateBySubtractingMonths:(NSInteger)months
{
    return [self yl_dateByAddingMonths:(months * -1)];
}

- (NSDate *)yl_dateByAddingDays:(NSInteger)days
{
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    [dateComponents setDay:days];
    NSDate *newDate = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:self options:0];
    return newDate;
}

- (NSDate *)yl_dateBySubtractingDays:(NSInteger)days
{
    return [self yl_dateByAddingDays:(days * -1)];
}

- (NSDate *)yl_dateByAddingHours:(NSInteger)hours
{
    NSTimeInterval aTimeInterval = [self timeIntervalSinceReferenceDate] + YL_D_HOUR * hours;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}

- (NSDate *)yl_dateBySubtractingHours:(NSInteger)hours
{
    return [self yl_dateByAddingHours: (hours * -1)];
}

- (NSDate *)yl_dateByAddingMinutes:(NSInteger)minutes
{
    NSTimeInterval aTimeInterval = [self timeIntervalSinceReferenceDate] + YL_D_MINUTE * minutes;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}

- (NSDate *)yl_dateBySubtractingMinutes:(NSInteger)minutes
{
    return [self yl_dateByAddingMinutes: (minutes * -1)];
}
@end
