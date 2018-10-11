//
//  UIColor+GX.m
//  GIF-Browser
//
//  Created by fuguangxin on 16/6/17.
//  Copyright © 2016年 GuangXin Fu. All rights reserved.
//

#import "UIColor+GX.h"

@implementation UIColor(GX)

+ (UIColor *)colorWithHexString:(NSString *)color
{
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) {
        return [UIColor clearColor];
    }
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"])
        cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return [UIColor clearColor];
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    
    //r
    NSString *rString = [cString substringWithRange:range];
    
    //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    //b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    //NSLog(@"%d,%d,%d",r,g,b);
    return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:1.0f];
}


+ (UIColor *)randomColor{
    return [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1];
}

+(UIColor*)navColor
{
    if ([QOnlineConfigTool isReview])
    {
          return  [UIColor colorWithHexString:@"FFFFFF"];
    }
    return  [UIColor colorWithHexString:@"FF7751"];
}
+ (UIColor *)naviTitleColor{
    if ([QOnlineConfigTool isReview])
    {
        return  [UIColor colorWithHexString:@"000000"];
    }
    return  [UIColor colorWithHexString:@"FFFFFF"];
}
@end
