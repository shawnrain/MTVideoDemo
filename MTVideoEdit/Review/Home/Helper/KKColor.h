//
//  KKColor.h
//  kankan
//
//  Created by MTShawn on 2018/7/27.
//  Copyright © 2018年 MT. All rights reserved.
//

#define HEXCOLOR(rgbValue)              [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)((rgbValue & 0xFF))/255.0) \
alpha:1.0]
#import <Foundation/Foundation.h>
#define color000000  HEXCOLOR(0x000000)
#define color0F8781  HEXCOLOR(0x0F8781)
#define color18A69E  HEXCOLOR(0x18A69E)
#define color1D1D1D  HEXCOLOR(0x1D1D1D)
#define color2DC2F4  HEXCOLOR(0x2DC2F4)
#define color333333  HEXCOLOR(0x333333)
#define color353535  HEXCOLOR(0x353535)
#define color454545  HEXCOLOR(0x454545)
#define color555555  HEXCOLOR(0x555555)
#define color59CA5F  HEXCOLOR(0x59CA5F)
#define color5FCC6E  HEXCOLOR(0x5FCC6E)
#define color6FC0F3  HEXCOLOR(0x6FC0F3)
#define color8655DE  HEXCOLOR(0x8655DE)
#define color888888  HEXCOLOR(0x888888)
#define color999999  HEXCOLOR(0x999999)
#define colorAAAAAA  HEXCOLOR(0xAAAAAA)
#define colorB2B2B2  HEXCOLOR(0xB2B2B2)
#define colorC4C4C4  HEXCOLOR(0xC4C4C4)
#define colorCCCCCC  HEXCOLOR(0xCCCCCC)
#define colorDCE4ED  HEXCOLOR(0xDCE4ED)
#define colorDDDDDD  HEXCOLOR(0xDDDDDD)
#define colorEEEEEE  HEXCOLOR(0xEEEEEE)
#define colorEDEDED  HEXCOLOR(0xEDEDED)
#define colorF0F0F0  HEXCOLOR(0xF0F0F0)
#define colorF5F5F5  HEXCOLOR(0xF5F5F5)
#define colorF74848  HEXCOLOR(0xF74848)
#define colorF8F8F8  HEXCOLOR(0xF8F8F8)
#define colorFAFAFA  HEXCOLOR(0xFAFAFA)
#define colorFFF5EF  HEXCOLOR(0xFFF5EF)
#define colorFF5F6C  HEXCOLOR(0xFF5F6C)
#define colorFF657C  HEXCOLOR(0xFF657C)
#define colorFF687F  HEXCOLOR(0xFF687F)
#define colorFF8450  HEXCOLOR(0xFF8450)
#define colorFFBC23  HEXCOLOR(0xFFBC23)
#define colorFFFFFF  HEXCOLOR(0xFFFFFF)
@interface KKColor : NSObject

@end
