//
//  UIView+YLFind.h
//  OC-YL
//
//  Created by melon on 2018/5/25.
//  Copyright © 2018年 melon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (YLFind)
/**
 找到指定类名的SubVie对象
 
 @param clazz SubVie类名
 @return view对象
 */
- (id)yl_findSubViewWithSubViewClass:(Class)clazz;

/**
 找到指定类名的SuperView对象
 
 @param clazz SuperView类名
 @return view对象
 */
- (id)yl_findSuperViewWithSuperViewClass:(Class)clazz;

/**
 找到并且resign第一响应者

 @return 结果
 */
- (BOOL)yl_findAndResignFirstResponder;

/**
 找到第一响应者
 
 @return 第一响应者
 */
- (UIView *)yl_findFirstResponder;

@property (readonly) UIViewController *yl_viewController;/** 当前view所在的viewcontroler */
@end
