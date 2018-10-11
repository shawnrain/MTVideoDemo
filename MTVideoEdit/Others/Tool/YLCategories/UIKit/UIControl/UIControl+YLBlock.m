//
//  UIControl+YLBlock.m
//  OC-YL
//
//  Created by melon on 2018/5/25.
//  Copyright © 2018年 melon. All rights reserved.
//

#import "UIControl+YLBlock.h"
#import <objc/runtime.h>
#define YL_UICONTROL_EVENT(methodName, eventName)                                \
-(void)methodName : (void (^)(void))eventBlock {                              \
objc_setAssociatedObject(self, @selector(methodName:), eventBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);\
[self addTarget:self                                                        \
action:@selector(methodName##Action:)                                       \
forControlEvents:UIControlEvent##eventName];                                \
}                                                                               \
-(void)methodName##Action:(id)sender {                                        \
void (^block)(void) = objc_getAssociatedObject(self, @selector(methodName:));  \
if (block) {                                                                \
block();                                                                \
}                                                                           \
}
@implementation UIControl (YLBlock)
YL_UICONTROL_EVENT(yl_touchDown, TouchDown)
YL_UICONTROL_EVENT(yl_touchDownRepeat, TouchDownRepeat)
YL_UICONTROL_EVENT(yl_touchDragInside, TouchDragInside)
YL_UICONTROL_EVENT(yl_touchDragOutside, TouchDragOutside)
YL_UICONTROL_EVENT(yl_touchDragEnter, TouchDragEnter)
YL_UICONTROL_EVENT(yl_touchDragExit, TouchDragExit)
YL_UICONTROL_EVENT(yl_touchUpInside, TouchUpInside)
YL_UICONTROL_EVENT(yl_touchUpOutside, TouchUpOutside)
YL_UICONTROL_EVENT(yl_touchCancel, TouchCancel)
YL_UICONTROL_EVENT(yl_valueChanged, ValueChanged)
YL_UICONTROL_EVENT(yl_editingDidBegin, EditingDidBegin)
YL_UICONTROL_EVENT(yl_editingChanged, EditingChanged)
YL_UICONTROL_EVENT(yl_editingDidEnd, EditingDidEnd)
YL_UICONTROL_EVENT(yl_editingDidEndOnExit, EditingDidEndOnExit)
@end
