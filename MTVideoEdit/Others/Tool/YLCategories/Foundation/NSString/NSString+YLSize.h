//
//  NSString+Size.h
//  OC-YL
//
//  Created by melon on 2018/2/7.
//  Copyright © 2018年 melon. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@interface NSString (YLSize)
/**
  get size from maxsize
 
 @param font UIFont
 @return size
 */
- (CGSize)yl_sizeForFont:(UIFont *)font;

/**
 get size

 @param font UIFont
 @param size CGSize
 @return size
 */
- (CGSize)yl_sizeForFont:(UIFont *)font maxSize:(CGSize)size;

/**
 get size from lineBreakMode

 @param font UIFont
 @param size CGSize
 @param lineBreakMode lineBreakMode
 @return size
 */
- (CGSize)yl_sizeForFont:(UIFont *)font maxSize:(CGSize)size mode:(NSLineBreakMode)lineBreakMode;

/**
 get width from maxsize

 @param font UIFont
 @return width
 */
- (CGFloat)yl_widthForFont:(UIFont *)font;


/**
 get width from maxheight and limit width

 @param font UIFont
 @param width CGFloat
 @return height
 */
- (CGFloat)yl_heightForFont:(UIFont *)font maxWidth:(CGFloat)width;
@end
NS_ASSUME_NONNULL_END
