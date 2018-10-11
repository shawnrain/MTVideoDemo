//
//  NSObject+YLKVOBlocks.h
//  OC-YL
//
//  Created by melon on 2018/5/25.
//  Copyright © 2018年 melon. All rights reserved.
//

#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN
typedef void (^YLKVOBlock)(NSDictionary<NSKeyValueChangeKey,id> *change, void *context);
@interface NSObject (YLKVOBlocks)

/**
 添加观察者与监听属性

 @param observer 观察者,一般为其他对象(谁想监听)
 @param keyPath 监听的属性
 @param options 监听模式
 @param context context
 @param block 监听回调
 */
- (void)yl_addObserver:(NSObject *)observer
            forKeyPath:(NSString *)keyPath
               options:(NSKeyValueObservingOptions)options
               context:(void *)context
             withBlock:(YLKVOBlock)block;

/**
 移除观察者对属性的监听
 
 @param observer 观察者,一般为其他对象(谁想监听)
 @param keyPath 监听的属性
 */
- (void)yl_removeBlockObserver:(NSObject *)observer
                    forKeyPath:(NSString *)keyPath;

/**
 对象本身作为观察者
 
 @param keyPath 监听的属性
 @param options 监听模式
 @param context context
 @param block 监听回调
 */
- (void)yl_addObserverForKeyPath:(NSString *)keyPath
                         options:(NSKeyValueObservingOptions)options
                         context:(void *)context
                       withBlock:(YLKVOBlock)block;

/**
 移除观察者对属性的监听
 
 @param keyPath 监听的属性
 */
- (void)yl_removeBlockObserverForKeyPath:(NSString *)keyPath;
@end
NS_ASSUME_NONNULL_END
