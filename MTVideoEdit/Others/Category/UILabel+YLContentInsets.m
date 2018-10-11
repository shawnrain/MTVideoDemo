//
//  UILabel+YLInsetsLabel.m
//  KwaiUp
//
//  Created by melon on 2018/1/24.
//  Copyright © 2018年 melon. All rights reserved.
//

#import "UILabel+YLContentInsets.h"
#import <objc/runtime.h>

/// 获取UIEdgeInsets在水平方向上的值
CG_INLINE CGFloat
UIEdgeInsetsGetHorizontalValue(UIEdgeInsets insets) {
    return insets.left + insets.right;
}

/// 获取UIEdgeInsets在垂直方向上的值
CG_INLINE CGFloat
UIEdgeInsetsGetVerticalValue(UIEdgeInsets insets) {
    return insets.top + insets.bottom;
}

CG_INLINE void
ReplaceMethod(Class _class, SEL _originSelector, SEL _newSelector) {
    Method oriMethod = class_getInstanceMethod(_class, _originSelector);
    Method newMethod = class_getInstanceMethod(_class, _newSelector);
    BOOL isAddedMethod = class_addMethod(_class, _originSelector, method_getImplementation(newMethod), method_getTypeEncoding(newMethod));
    if (isAddedMethod) {
        class_replaceMethod(_class, _newSelector, method_getImplementation(oriMethod), method_getTypeEncoding(oriMethod));
    } else {
        method_exchangeImplementations(oriMethod, newMethod);
    }
}

@implementation UILabel (YLContentInsets)
+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        ReplaceMethod([self class], @selector(drawTextInRect:), @selector(yl_drawTextInRect:));
        ReplaceMethod([self class], @selector(sizeThatFits:), @selector(yl_sizeThatFits:));
    });
}

- (void)yl_drawTextInRect:(CGRect)rect {
    UIEdgeInsets insets = self.yl_contentInsets;
    [self yl_drawTextInRect:UIEdgeInsetsInsetRect(rect, insets)];
}

- (CGSize)yl_sizeThatFits:(CGSize)size {
    UIEdgeInsets insets = self.yl_contentInsets;
    size = [self yl_sizeThatFits:CGSizeMake(size.width - UIEdgeInsetsGetHorizontalValue(insets), size.height-UIEdgeInsetsGetVerticalValue(insets))];
    size.width += UIEdgeInsetsGetHorizontalValue(insets);
    size.height += UIEdgeInsetsGetVerticalValue(insets);
    return size;
}

const void *kAssociatedYf_contentInsets;
- (void)setYl_contentInsets:(UIEdgeInsets)yl_contentInsets {
    objc_setAssociatedObject(self, &kAssociatedYf_contentInsets, [NSValue valueWithUIEdgeInsets:yl_contentInsets] , OBJC_ASSOCIATION_RETAIN);
}

- (UIEdgeInsets)yl_contentInsets {
    return [objc_getAssociatedObject(self, &kAssociatedYf_contentInsets) UIEdgeInsetsValue];
}
@end
