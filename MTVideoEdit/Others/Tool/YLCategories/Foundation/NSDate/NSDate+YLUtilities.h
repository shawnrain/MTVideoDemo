//
//  NSDate+YLUtilities.h
//  KwaiUp
//
//  Created by melon on 2018/6/6.
//  Copyright © 2018年 melon. All rights reserved.
//

#import <Foundation/Foundation.h>
#define YL_D_MINUTE         (60)
#define YL_D_HOUR           (60*60)
#define YL_D_DAY            (60*60*24)
#define YL_D_WEEK           (60*60*60*7)
#define YL_D_YEAR           (60*60*24*30*12)
@interface NSDate (YLUtilities)

+ (NSCalendar *)yl_currentCalendar;

#pragma mark ======================== short time 格式化的时间
///给定format格式化时间
- (NSString *)yl_stringWithFormat:(NSString *)format;

#pragma mark ======================== 从当前日期相对日期时间
///明天
+ (NSDate *)yl_dateTomorrow;
///昨天
+ (NSDate *)yl_dateYesterday;
///今天后几天
+ (NSDate *)yl_dateWithDaysFromNow:(NSInteger)days;
///今天前几天
+ (NSDate *)yl_dateWithDaysBeforeNow:(NSInteger)days;
///当前小时后Hours个小时
+ (NSDate *)yl_dateWithHoursFromNow:(NSInteger)hours;
///当前小时前Hours个小时
+ (NSDate *)yl_dateWithHoursBeforeNow:(NSInteger)hours;
///当前分钟后Minutes个分钟
+ (NSDate *)yl_dateWithMinutesFromNow:(NSInteger)minutes;
///当前分钟前Minutes个分钟
+ (NSDate *)yl_dateWithMinutesBeforeNow:(NSInteger)minutes;


#pragma mark ======================== Comparing dates 比较时间
///比较年月日是否相等
- (BOOL)yl_isEqualToDateIgnoringTime:(NSDate *)date;
///是否是今天
- (BOOL)yl_isToday;
///是否是明天
- (BOOL)yl_isTomorrow;
///是否是昨天
- (BOOL)yl_isYesterday;


///是否是同一周
- (BOOL)yl_isSameWeekAsDate:(NSDate *)date;
///是否是本周
- (BOOL)yl_isThisWeek;
///是否是本周的下周
- (BOOL)yl_isNextWeek;
///是否是本周的上周
- (BOOL)yl_isLastWeek;


///是否是同一月
- (BOOL)yl_isSameMonthAsDate:(NSDate *)date;
///是否是本月
- (BOOL)yl_isThisMonth;
///是否是本月的下月
- (BOOL)yl_isNextMonth;
///是否是本月的上月
- (BOOL)yl_isLastMonth;


///是否是同一年
- (BOOL)yl_isSameYearAsDate:(NSDate *)date;
///是否是今年
- (BOOL)yl_isThisYear;
///是否是今年的下一年
- (BOOL)yl_isNextYear;
///是否是今年的上一年
- (BOOL)yl_isLastYear;


///是否是工作日
- (BOOL)yl_isWeekDay;
///是否是周末
- (BOOL)yl_isWeekend;
#pragma mark ======================== Adjusting dates 调节时间
///增加Years年
- (NSDate *)yl_dateByAddingYears:(NSInteger)years;
///减少Years年
- (NSDate *)yl_dateBySubtractingYears:(NSInteger)years;
///增加Months月
- (NSDate *)yl_dateByAddingMonths:(NSInteger)months;
///减少Months月
- (NSDate *)yl_dateBySubtractingMonths:(NSInteger)months;
///增加Days天
- (NSDate *)yl_dateByAddingDays:(NSInteger)days;
///减少Days天
- (NSDate *)yl_dateBySubtractingDays:(NSInteger)days;
///增加Hours小时
- (NSDate *)yl_dateByAddingHours:(NSInteger)hours;
///减少Hours小时
- (NSDate *)yl_dateBySubtractingHours:(NSInteger)hours;
///增加Minutes分钟
- (NSDate *)yl_dateByAddingMinutes:(NSInteger)minutes;
///减少Minutes分钟
- (NSDate *)yl_dateBySubtractingMinutes:(NSInteger)minutes;
@end
