//
//  NSDate+Time.h
//  BaiSi
//
//  Created by cy on 16/1/31.
//  Copyright © 2016年 cy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Time)

/** 是否是今年 */
- (BOOL)isInThisYear;

/** 是否是今天 */
- (BOOL)isInToday;

/** 是否是昨天 */
- (BOOL)isInYesterday;

/** 是否是本月 */
- (BOOL)isInThisMonth;
@end
