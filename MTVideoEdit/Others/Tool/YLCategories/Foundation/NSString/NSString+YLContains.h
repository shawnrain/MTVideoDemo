//
//  NSString+YLContains.h
//  OC-YL
//
//  Created by melon on 2018/5/25.
//  Copyright © 2018年 melon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (YLContains)
/**
 是否包含中文

 @return 是否包含中文
 */
- (BOOL)yl_isContainChinese;

/**
 是否包含空格

 @return 是否包含空格
 */
- (BOOL)yl_isContainBlank;

/**
 Unicode编码的字符串转成NSString

 @return Unicode编码的字符串转成NSString
 */
- (NSString *)yl_makeUnicodeToString;

/**
 获取字符数量

 @return 字符数量
 */
- (int)yl_wordsCount;
@end
