//
//  NSObject+YLKVOBlocks.m
//  OC-YL
//
//  Created by melon on 2018/5/25.
//  Copyright © 2018年 melon. All rights reserved.
//

#import "NSObject+YLKVOBlocks.h"
#import <objc/runtime.h>
@implementation NSObject (YLKVOBlocks)
- (void)yl_addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(void *)context withBlock:(YLKVOBlock)block
{
    objc_setAssociatedObject(observer, (__bridge const void *)(keyPath), block, OBJC_ASSOCIATION_COPY);
    [self addObserver:observer forKeyPath:keyPath options:options context:context];
}
- (void)yl_removeBlockObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath
{
    objc_setAssociatedObject(observer, (__bridge const void *)(keyPath), nil, OBJC_ASSOCIATION_COPY);
    [self removeObserver:observer forKeyPath:keyPath];
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    YLKVOBlock block = objc_getAssociatedObject(self, (__bridge const void *)(keyPath));
    if (block) {
        block(change,context);
    }
}

- (void)yl_addObserverForKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(void *)context withBlock:(YLKVOBlock)block
{
    [self yl_addObserver:self forKeyPath:keyPath options:options context:context withBlock:block];
}
- (void)yl_removeBlockObserverForKeyPath:(NSString *)keyPath
{
    [self yl_removeBlockObserver:self forKeyPath:keyPath];
}
@end
