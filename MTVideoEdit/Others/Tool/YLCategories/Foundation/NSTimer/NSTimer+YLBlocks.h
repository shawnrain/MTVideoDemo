//
//  NSTimer+YLBlocks.h
//  OC-YL
//
//  Created by melon on 2018/5/25.
//  Copyright © 2018年 melon. All rights reserved.
//

#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN
@interface NSTimer (YLBlocks)
/**
 Creates and returns a new NSTimer object initialized with the specified block object and schedules it on the current run loop in the default mode.

 @param interval ti    The number of seconds between firings of the timer. If seconds is less than or equal to 0.0, this method chooses the nonnegative value of 0.1 milliseconds instead
 @param repeats repeats  If YES, the timer will repeatedly reschedule itself until invalidated. If NO, the timer will be invalidated after it fires.
 @param block The execution body of the timer; the timer itself is passed as the parameter to this block when executed to aid in avoiding cyclical references
 @return a new NSTimer
 */
+ (NSTimer *)yl_scheduledTimerWithTimeInterval:(NSTimeInterval)interval repeats:(BOOL)repeats block:(void (^)(void))block;

/**
 Creates and returns a new NSTimer object initialized with the specified block object.This timer needs to be scheduled on a run loop (via -[NSRunLoop addTimer:]) before it will fire.
 
 @param interval timeInterval  The number of seconds between firings of the timer. If seconds is less than or equal to 0.0, this method chooses the nonnegative value of 0.1 milliseconds instead
 @param repeats repeats  If YES, the timer will repeatedly reschedule itself until invalidated. If NO, the timer will be invalidated after it fires.
 @param block The execution body of the timer; the timer itself is passed as the parameter to this block when executed to aid in avoiding cyclical references
 @return a new NSTimer
 */
+ (NSTimer *)yl_timerWithTimeInterval:(NSTimeInterval)interval repeats:(BOOL)repeats block:(void (^)(void))block;
@end
NS_ASSUME_NONNULL_END
