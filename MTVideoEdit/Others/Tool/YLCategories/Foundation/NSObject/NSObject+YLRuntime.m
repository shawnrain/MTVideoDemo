//
//  NSObject+YLRuntime.m
//  OC-YL
//
//  Created by melon on 2018/5/25.
//  Copyright © 2018年 melon. All rights reserved.
//

#import "NSObject+YLRuntime.h"
#import <objc/runtime.h>
BOOL yl_method_swizzle(Class klass, SEL origSel, SEL altSel){
    if (!klass)
        return NO;
    
    Method __block origMethod, __block altMethod;
    
    void (^find_methods)(void) = ^{
        unsigned methodCount = 0;
        Method *methodList = class_copyMethodList(klass, &methodCount);
        origMethod = altMethod = NULL;
        if (methodList)
            for (unsigned i = 0; i < methodCount; ++i){
                if (method_getName(methodList[i]) == origSel)
                    origMethod = methodList[i];
                
                if (method_getName(methodList[i]) == altSel)
                    altMethod = methodList[i];
            }
        free(methodList);
    };
    find_methods();
    if (!origMethod){
        origMethod = class_getInstanceMethod(klass, origSel);
        if (!origMethod)
            return NO;
        if (!class_addMethod(klass, method_getName(origMethod), method_getImplementation(origMethod), method_getTypeEncoding(origMethod)))
            return NO;
    }
    if (!altMethod){
        altMethod = class_getInstanceMethod(klass, altSel);
        if (!altMethod)
            return NO;
        if (!class_addMethod(klass, method_getName(altMethod), method_getImplementation(altMethod), method_getTypeEncoding(altMethod)))
            return NO;
    }
    find_methods();
    if (!origMethod || !altMethod)
        return NO;
    method_exchangeImplementations(origMethod, altMethod);
    return YES;
}
void yl_method_append(Class toClass, Class fromClass, SEL selector){
    if (!toClass || !fromClass || !selector)
        return;
    Method method = class_getInstanceMethod(fromClass, selector);
    if (!method)
        return;
    class_addMethod(toClass, method_getName(method), method_getImplementation(method), method_getTypeEncoding(method));
}
void yl_method_replace(Class toClass, Class fromClass, SEL selector){
    if (!toClass || !fromClass || ! selector)
        return;
    Method method = class_getInstanceMethod(fromClass, selector);
    if (!method)
        return;
    class_replaceMethod(toClass, method_getName(method), method_getImplementation(method), method_getTypeEncoding(method));
}
@implementation NSObject (YLRuntime)
+ (void)yl_swizzleMethod:(SEL)originalMethod withMethod:(SEL)newMethod
{
    yl_method_swizzle(self.class, originalMethod, newMethod);
}
+ (void)yl_appendMethod:(SEL)newMethod fromClass:(Class)klass
{
    yl_method_append(self.class, klass, newMethod);
}

+ (void)yl_replaceMethod:(SEL)method fromClass:(Class)klass
{
    yl_method_replace(self.class, klass, method);
}

@end
