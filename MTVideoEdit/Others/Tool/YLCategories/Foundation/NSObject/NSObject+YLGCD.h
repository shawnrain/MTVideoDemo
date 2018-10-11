//
//  NSObject+YLGCD.h
//  OC-YL
//
//  Created by melon on 2018/5/25.
//  Copyright © 2018年 melon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (YLGCD)

/**
 异步执行代码块

 @param block 代码块
 */
- (void)yl_performAsynchronous:(void(^)(void))block;

/**
 GCD主线程执行代码块

 @param block 代码块
 */
- (void)yl_performOnMainThread:(void(^)(void))block;

/**
 延迟执行代码块

 @param seconds 延迟时间 秒
 @param block 代码块
 */
- (void)yl_performAfter:(NSTimeInterval)seconds block:(void(^)(void))block;
@end
