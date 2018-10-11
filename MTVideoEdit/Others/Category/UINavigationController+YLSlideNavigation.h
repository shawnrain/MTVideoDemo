//
//  UINavigationController+YLSlideNavigation.h
//  123
//
//  Created by melon on 2017/11/20.
//  Copyright © 2017年 melon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationController (YLSlideNavigation)<UIGestureRecognizerDelegate,UINavigationBarDelegate>
/**pushed时候隐藏tabBar，设置导航控制器该属性后对其push的所有控制器都有效*/
@property (nonatomic, assign) BOOL hideBottomBarWhenEveryPushed;
/**是否隐藏底部线条*/
@property (nonatomic, assign) BOOL hideBottomLine;
/**自定义返回按钮的图片，自定义后由于系统边缘pop手势会失效，建议调用xw_enableFullScreenGestureWithEdgeSpacing:开启自定义pop手势*/
@property (nonatomic, strong) UIImage *customBackImage;

- (void)yl_enableFullScreenGesture:(CGFloat)edgeSpacing;
@end
