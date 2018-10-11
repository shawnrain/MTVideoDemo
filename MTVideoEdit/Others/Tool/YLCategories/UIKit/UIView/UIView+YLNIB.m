//
//  UIView+xib.m
//  wanghongshenqi
//
//  Created by melon on 2018/5/7.
//  Copyright © 2018年 melon. All rights reserved.
//

#import "UIView+YLNIB.h"

@implementation UIView (YLNIB)
+ (instancetype)yl_viewFromNib
{
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil].firstObject;
}
@end
