//
//  UILabel+YLUtils.h
//  OC-YL
//
//  Created by melon on 2018/7/11.
//  Copyright © 2018年 melon. All rights reserved.
//

#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN
@interface UILabel (YLUtils)

/**
 设置UILabel行高

 @param text 内容
 @param lineSpacing 行高
 */
- (void)yl_setText:(NSString *)text lineSpacing:(CGFloat)lineSpacing;
@end
NS_ASSUME_NONNULL_END
