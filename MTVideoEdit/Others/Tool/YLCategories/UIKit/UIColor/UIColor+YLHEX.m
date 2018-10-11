//
//  UIColor+HEX.m
//  wanghongshenqi
//
//  Created by melon on 2018/5/7.
//  Copyright © 2018年 melon. All rights reserved.
//

#import "UIColor+YLHEX.h"
CGFloat yl_colorComponentFrom(NSString *string, NSUInteger start, NSUInteger length) {
    NSString *substring = [string substringWithRange:NSMakeRange(start, length)];
    NSString *fullHex = length == 2 ? substring : [NSString stringWithFormat: @"%@%@", substring, substring];
    
    unsigned hexComponent;
    [[NSScanner scannerWithString: fullHex] scanHexInt: &hexComponent];
    return hexComponent / 255.0;
}
@implementation UIColor (YLHEX)

+ (UIColor *)yl_colorWithHex:(UInt32)hex{
    return [UIColor yl_colorWithHex:hex andAlpha:1];
}
+ (UIColor *)yl_colorWithHex:(UInt32)hex andAlpha:(CGFloat)alpha{
    return [UIColor colorWithRed:((hex >> 16) & 0xFF)/255.0
                           green:((hex >> 8) & 0xFF)/255.0
                            blue:(hex & 0xFF)/255.0
                           alpha:alpha];
}

+ (UIColor *)yl_colorWithHexString:(NSString *)hexString {
    CGFloat alpha, red, blue, green;
    
    NSString *colorString = [[hexString stringByReplacingOccurrencesOfString:@"#" withString:@""] uppercaseString];
    switch ([colorString length]) {
        case 3: // #RGB
            alpha = 1.0f;
            red   = yl_colorComponentFrom(colorString, 0, 1);
            green = yl_colorComponentFrom(colorString, 1, 1);
            blue  = yl_colorComponentFrom(colorString, 2, 1);
            break;
            
        case 4: // #ARGB
            alpha = yl_colorComponentFrom(colorString, 0, 1);
            red   = yl_colorComponentFrom(colorString, 1, 1);
            green = yl_colorComponentFrom(colorString, 2, 1);
            blue  = yl_colorComponentFrom(colorString, 3, 1);
            break;
            
        case 6: // #RRGGBB
            alpha = 1.0f;
            red   = yl_colorComponentFrom(colorString, 0, 2);
            green = yl_colorComponentFrom(colorString, 2, 2);
            blue  = yl_colorComponentFrom(colorString, 4, 2);
            break;
            
        case 8: // #AARRGGBB
            alpha = yl_colorComponentFrom(colorString, 0, 2);
            red   = yl_colorComponentFrom(colorString, 2, 2);
            green = yl_colorComponentFrom(colorString, 4, 2);
            blue  = yl_colorComponentFrom(colorString, 6, 2);
            break;
            
        default:
            return nil;
    }
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}

- (NSString *)yl_HEXString{
    UIColor* color = self;
    if (CGColorGetNumberOfComponents(color.CGColor) < 4) {
        const CGFloat *components = CGColorGetComponents(color.CGColor);
        color = [UIColor colorWithRed:components[0]
                                green:components[0]
                                 blue:components[0]
                                alpha:components[1]];
    }
    if (CGColorSpaceGetModel(CGColorGetColorSpace(color.CGColor)) != kCGColorSpaceModelRGB) {
        return [NSString stringWithFormat:@"#FFFFFF"];
    }
    return [NSString stringWithFormat:@"#%02X%02X%02X", (int)((CGColorGetComponents(color.CGColor))[0]*255.0),
            (int)((CGColorGetComponents(color.CGColor))[1]*255.0),
            (int)((CGColorGetComponents(color.CGColor))[2]*255.0)];
}

+ (UIColor *)yl_colorWithWholeRed:(CGFloat)red
                            green:(CGFloat)green
                             blue:(CGFloat)blue
                            alpha:(CGFloat)alpha
{
    return [UIColor colorWithRed:red/255.f
                           green:green/255.f
                            blue:blue/255.f
                           alpha:alpha];
}

+ (UIColor *)yl_colorWithWholeRed:(CGFloat)red
                            green:(CGFloat)green
                             blue:(CGFloat)blue
{
    return [self yl_colorWithWholeRed:red
                                green:green
                                 blue:blue
                                alpha:1.0];
}
@end
