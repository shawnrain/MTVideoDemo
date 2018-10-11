//
//  UIColor+HEX.h
//  wanghongshenqi
//
//  Created by melon on 2018/5/7.
//  Copyright © 2018年 melon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (YLHEX)

/**
 get color from UInt32 hex

 @param hex hex
 @return UIColor
 */
+ (UIColor *)yl_colorWithHex:(UInt32)hex;


/**
 get color from UInt32 hex

 @param hex hex
 @param alpha alpha
 @return UIColor
 */
+ (UIColor *)yl_colorWithHex:(UInt32)hex andAlpha:(CGFloat)alpha;


/**
  get color from hexString

 @param hexString hexString
 @return UIColor
 */
+ (UIColor *)yl_colorWithHexString:(NSString *)hexString;

/**
 get color HEXString

 @return HEXString
 */
- (NSString *)yl_HEXString;

/**
 get color from R.G.B
 
 @param red red
 @param green green
 @param blue blue
 @return UIColor
 */
+ (UIColor *)yl_colorWithWholeRed:(CGFloat)red
                            green:(CGFloat)green
                             blue:(CGFloat)blue;

/**
 get color from R.G.B alpha

 @param red red
 @param green green
 @param blue blue
 @param alpha alpha
 @return UIColor
 */
+ (UIColor *)yl_colorWithWholeRed:(CGFloat)red
                            green:(CGFloat)green
                             blue:(CGFloat)blue
                            alpha:(CGFloat)alpha;

@end
