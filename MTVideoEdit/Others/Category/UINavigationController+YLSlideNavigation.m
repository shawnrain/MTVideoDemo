//
//  UINavigationController+YLSlideNavigation.m
//  123
//
//  Created by melon on 2017/11/20.
//  Copyright © 2017年 melon. All rights reserved.
//

#import "UINavigationController+YLSlideNavigation.h"
#import <objc/runtime.h>
static char *hideBottomLineKey = "hideBottomLineKey";
static char *hideBottomBarWhenEveryPushedKey = "hideBottomBarWhenEveryPushedKey";
static char *customBackImageKey = "customBackImageKey";
static char *edgeSpacingKey = "edgeSpacingKey";
@implementation UINavigationController (YLSlideNavigation)
+ (void)load
{
    NSArray *methodArray = @[
                             @"pushViewController:animated:"
                             ];
    for (int i = 0; i < methodArray.count; i++) {
        NSString *mySel = [[NSString stringWithFormat:@"yl_%@", methodArray[i]] stringByReplacingOccurrencesOfString:@"__" withString:@"_"];
        Method originalMethod = class_getInstanceMethod([self class], NSSelectorFromString(methodArray[i]));
        Method swizzledMethod = class_getInstanceMethod([self class], NSSelectorFromString(mySel));
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
    
}
- (void)yl_pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.hideBottomBarWhenEveryPushed && self.viewControllers.count == 1) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    UIImage *backImage = self.customBackImage;
    if (backImage && self.viewControllers.count > 0) {
        UIBarButtonItem *temporaryBarButtonItem = [[UIBarButtonItem alloc] initWithImage:backImage style:UIBarButtonItemStyleDone target:self action:@selector(yl_back)];
        viewController.navigationItem.leftBarButtonItem = temporaryBarButtonItem;
    }
    [self yl_pushViewController:viewController animated:animated];
}


- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    CGFloat edgeSpacing = [objc_getAssociatedObject(self,edgeSpacingKey) floatValue];
    if (!edgeSpacing) {
        edgeSpacing = MAXFLOAT;
    }
    //    || self.view.subviews.lastObject != self.navigationBar
    if (self.childViewControllers.count == 1 || [gestureRecognizer locationInView:gestureRecognizer.view].x > edgeSpacing ) {
        return NO;
    }
    return YES;
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    // 输出点击的view的类名
    //    NSLog(@"%@", NSStringFromClass([touch.view class]));
    
    // 若为UITableViewCellContentView（即点击了tableViewCell），则不截获Touch事件
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"]) {
        return NO;
    }
    return  YES;
}

#pragma mark - getter

- (BOOL)hideBottomLine
{
    return objc_getAssociatedObject(self, hideBottomLineKey);
}

- (BOOL)hideBottomBarWhenEveryPushed
{
    return objc_getAssociatedObject(self, hideBottomBarWhenEveryPushedKey);
}

- (UIImage *)customBackImage
{
    return objc_getAssociatedObject(self, customBackImageKey);
}
#pragma mark - setter
- (void)setHideBottomLine:(BOOL)hideBottomLine
{
    objc_setAssociatedObject(self, hideBottomLineKey, @(hideBottomLine), OBJC_ASSOCIATION_ASSIGN);
    static UIView *lineView = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        lineView = [self yl_findHairlineImageViewUnder:self.navigationBar];
    });
    lineView.hidden = hideBottomLine;
}
- (void)setHideBottomBarWhenEveryPushed:(BOOL)hideBottomBarWhenEveryPushed
{
    objc_setAssociatedObject(self, hideBottomBarWhenEveryPushedKey, @(hideBottomBarWhenEveryPushed), OBJC_ASSOCIATION_ASSIGN);
}
- (void)setCustomBackImage:(UIImage *)customBackImage
{
    objc_setAssociatedObject(self, customBackImageKey, customBackImage, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark - public
- (void)yl_enableFullScreenGesture:(CGFloat)edgeSpacing
{
    id taget = self.interactivePopGestureRecognizer.delegate;
    SEL handleNavigationTransition = NSSelectorFromString(@"handleNavigationTransition:");
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:taget action:handleNavigationTransition];
    objc_setAssociatedObject(self, edgeSpacingKey, @(edgeSpacing), OBJC_ASSOCIATION_RETAIN);
    pan.delegate = self;
    [self.view addGestureRecognizer:pan];
    self.interactivePopGestureRecognizer.enabled = NO;
}

#pragma mark - private

- (void)yl_back{
    [self popViewControllerAnimated:YES];
}

- (UIImageView *)yl_findHairlineImageViewUnder:(UIView *)view {
    if ([view isKindOfClass:UIImageView.class] && view.bounds.size.height <= 1.0) {
        return (UIImageView *)view;
    }
    
    for (UIView *subview in view.subviews) {
        UIImageView *imageView = [self yl_findHairlineImageViewUnder:subview];
        if (imageView) {
            return imageView;
        }
    }
    return nil;
}
@end
