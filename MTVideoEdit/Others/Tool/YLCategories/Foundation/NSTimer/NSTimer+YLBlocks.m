//
//  NSTimer+YLBlocks.m
//  OC-YL
//
//  Created by melon on 2018/5/25.
//  Copyright © 2018年 melon. All rights reserved.
//

#import "NSTimer+YLBlocks.h"

@implementation NSTimer (YLBlocks)
+ (NSTimer *)yl_scheduledTimerWithTimeInterval:(NSTimeInterval)interval repeats:(BOOL)repeats block:(void (^)(void))block
{
    void (^inBlock)(void) = [block copy];
    return [self scheduledTimerWithTimeInterval:interval target:self selector:@selector(yl_jdExecuteSimpleBlock:) userInfo:inBlock repeats:repeats];;
}
+ (NSTimer *)yl_timerWithTimeInterval:(NSTimeInterval)interval repeats:(BOOL)repeats block:(void (^)(void))block
{
    void (^inBlock)(void) = [block copy];
    return [self timerWithTimeInterval:interval target:self selector:@selector(yl_jdExecuteSimpleBlock:) userInfo:inBlock repeats:repeats];
}
+ (void)yl_jdExecuteSimpleBlock:(NSTimer *)timer
{
    if ([timer userInfo]) {
        void (^block)(void) = (void (^)(void))[timer userInfo];
        block();
    }
}
@end
