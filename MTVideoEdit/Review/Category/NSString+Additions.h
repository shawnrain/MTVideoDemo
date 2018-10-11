//
//  NSString+Additions.h
//  IOSDuoduo
//
//  Created by 东邪 on 14-5-23.
//  Copyright (c) 2014年 dujia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface NSString (mogujieString)

+(NSString *)documentPath;
+(NSString *)cachePath;
+(NSString *)formatCurDate;
+(NSString *)formatCurDay;
+(NSString *)getAppVer;
- (NSString*)removeAllSpace;
+(NSString *)formatCurDayForVersion;
- (NSURL *) toURL;
- (BOOL) isEmail;
- (BOOL) isEmpty;
- (NSString *) MD5;
-(NSString *)trim;
+ (NSInteger)chineseCountOfString:(NSString *)string;
+ (NSInteger)characterCountOfString:(NSString *)string;

-(BOOL) isOlderVersionThan:(NSString*)otherVersion;
-(BOOL) isNewerVersionThan:(NSString*)otherVersion;
+ (BOOL)stringContainsEmoji:(NSString *)string;
+(NSString*)stringContainsEmotions:(NSString*)string;
-(CGFloat)lengthWidthLimitHeight:(CGFloat)maxHeight fontSize:(NSInteger)fontSize;
-(CGFloat)stringHeightLimitWidth:(CGFloat)maxWidth fontSize:(NSInteger)fontSize;
/**
 *  //获取拼音首字母
 *
 *  @return 传入汉字字符串, 返回大写拼音首字母
 */
- (NSString *)firstCharactor;

@end
