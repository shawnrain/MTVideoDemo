//
//  NSObject+YLGCD.m
//  OC-YL
//
//  Created by melon on 2018/5/25.
//  Copyright © 2018年 melon. All rights reserved.
//

#import "NSObject+YLGCD.h"

@implementation NSObject (YLGCD)
- (void)yl_performAsynchronous:(void(^)(void))block {
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, block);
}

- (void)yl_performOnMainThread:(void(^)(void))block
{
    dispatch_queue_t queue = dispatch_get_main_queue();
    dispatch_async(queue, block);
}
- (void)yl_performAfter:(NSTimeInterval)seconds block:(void(^)(void))block {
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, seconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), block);
}
@end
