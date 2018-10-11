//
//  NSObject+YLRuntime.h
//  OC-YL
//
//  Created by melon on 2018/5/25.
//  Copyright © 2018年 melon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (YLRuntime)
/**
 Exchange methods' implementations.
 
 @param originalMethod Method to exchange.
 @param newMethod Method to exchange.
 */
+ (void)yl_swizzleMethod:(SEL)originalMethod withMethod:(SEL)newMethod;

/**
 Append a new method to an object.
 
 @param newMethod Method to exchange.
 @param klass Host class.
 */
+ (void)yl_appendMethod:(SEL)newMethod fromClass:(Class)klass;

/**
 Replace a method in an object.
 
 @param method Method to exchange.
 @param klass Host class.
 */
+ (void)yl_replaceMethod:(SEL)method fromClass:(Class)klass;
@end
