//
//  UIView+YLBlockGesture.m
//  OC-YL
//
//  Created by melon on 2018/5/25.
//  Copyright © 2018年 melon. All rights reserved.
//

#import "UIView+YLBlockGesture.h"
#import <objc/runtime.h>
static char yl_kActionHandlerTapBlockKey;
static char yl_kActionHandlerTapGestureKey;
static char yl_kActionHandlerLongPressBlockKey;
static char yl_kActionHandlerLongPressGestureKey;
@implementation UIView (YLBlockGesture)
- (void)yl_addTapActionWithBlock:(YLGestureActionBlock)block
{
    UITapGestureRecognizer *gesture = objc_getAssociatedObject(self, &yl_kActionHandlerTapGestureKey);
    if (!gesture){
        gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(yl_handleActionForTapGesture:)];
        [self addGestureRecognizer:gesture];
        self.userInteractionEnabled = YES;
        objc_setAssociatedObject(self, &yl_kActionHandlerTapGestureKey, gesture, OBJC_ASSOCIATION_RETAIN);
    }
    objc_setAssociatedObject(self, &yl_kActionHandlerTapBlockKey, block, OBJC_ASSOCIATION_COPY);
}
- (void)yl_handleActionForTapGesture:(UITapGestureRecognizer *)gesture
{
    if (gesture.state == UIGestureRecognizerStateRecognized){
        YLGestureActionBlock block = objc_getAssociatedObject(self, &yl_kActionHandlerTapBlockKey);
        if (block){
            block(gesture);
        }
    }
}

- (void)yl_addLongPressActionWithBlock:(YLGestureActionBlock)block
{
    UILongPressGestureRecognizer *gesture = objc_getAssociatedObject(self, &yl_kActionHandlerLongPressGestureKey);
    if (!gesture){
        gesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(yl_handleActionForLongPressGesture:)];
        [self addGestureRecognizer:gesture];
        self.userInteractionEnabled = YES;
        objc_setAssociatedObject(self, &yl_kActionHandlerLongPressGestureKey, gesture, OBJC_ASSOCIATION_RETAIN);
    }
    objc_setAssociatedObject(self, &yl_kActionHandlerLongPressBlockKey, block, OBJC_ASSOCIATION_COPY);
}
- (void)yl_handleActionForLongPressGesture:(UITapGestureRecognizer*)gesture
{
    YLGestureActionBlock block = objc_getAssociatedObject(self, &yl_kActionHandlerLongPressBlockKey);
    if (block){
        block(gesture);
    }
}

@end
