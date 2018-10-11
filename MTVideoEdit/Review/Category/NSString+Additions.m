//
//  NSString+Additions.m
//  IOSDuoduo
//
//  Created by 东邪 on 14-5-23.
//  Copyright (c) 2014年 dujia. All rights reserved.
//

#import "NSString+Additions.h"
#import <sys/xattr.h>

#import <CommonCrypto/CommonDigest.h>

@implementation NSString (TTString)

+(NSString *)documentPath {
    static NSString * path = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)
                 objectAtIndex:0] copy];
        [NSString addSkipBackupAttributeToItemAtURL:[NSURL fileURLWithPath:path]];
    });
    return path;
}
+(BOOL)addSkipBackupAttributeToItemAtURL:(NSURL *)URL
{
    if (URL==nil) {
        return NO;
    }
    NSString *systemVersion=[[UIDevice currentDevice] systemVersion];
    float version=[systemVersion floatValue];
    if (version<5.0) {
        return YES;
    }
    if ( version>=5.1) {
        assert([[NSFileManager defaultManager] fileExistsAtPath: [URL path]]);
        
        NSError *error = nil;
        BOOL success = [URL setResourceValue: [NSNumber numberWithBool: YES]
                                      forKey: NSURLIsExcludedFromBackupKey error: &error];
        if(!success){
        }
        return success;
    }
    
    if ([systemVersion isEqual:@"5.0"]) {
        return NO;
    }else{
        assert([[NSFileManager defaultManager] fileExistsAtPath: [URL path]]);
        
        const char* filePath = [[URL path] fileSystemRepresentation];
        
        const char* attrName = "com.apple.MobileBackup";
        u_int8_t attrValue = 1;
        
        int result = setxattr(filePath, attrName, &attrValue, sizeof(attrValue), 0, 0);
        return result == 0;
    }
    return YES;
}
+(NSString *)cachePath {
    static NSString * path = nil;
    if (!path) {
        path = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)
                 objectAtIndex:0] copy];
    }
    return path;
}

+(NSString *)formatCurDate {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *result = [dateFormatter stringFromDate:[NSDate date]];
    
    return result;
}
+(NSString *)formatCurDay {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *result = [dateFormatter stringFromDate:[NSDate date]];
    
    return result;
}
+(NSString *)formatCurDayForVersion {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy.MM.dd"];
    NSString *result = [dateFormatter stringFromDate:[NSDate date]];
    
    return result;
}
+(NSString *)getAppVer {
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
}
- (NSURL *) toURL {
    return [NSURL URLWithString:[self stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
}

- (BOOL) isEmpty {
    if (self == nil) {
        
        return YES;
        
    }
    
    if (self == NULL) {
        
        return YES;
        
    }
    
    if ([self isKindOfClass:[NSNull class]]) {
        
        return YES;
        
    }
    
    if ([[self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length]==0) {
        
        return YES;
        
    }
    
    return NO;
    
}


- (NSString *) MD5 {
    // Create pointer to the string as UTF8
    const char* ptr = [self UTF8String];
    unsigned char md5Buffer[CC_MD5_DIGEST_LENGTH];
    
    // Create 16 byte MD5 hash value, store in buffer
    CC_MD5(ptr, (CC_LONG)strlen(ptr), md5Buffer);
    
    // Convert MD5 value in the buffer to NSString of hex values
    NSMutableString* output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [output appendFormat:@"%02x",md5Buffer[i]];
    }
    
    return output;
}
-(NSString *)trim{
    return  [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}


-(BOOL) isOlderVersionThan:(NSString*)otherVersion
{
    return ([self compare:otherVersion options:NSNumericSearch] == NSOrderedAscending);
}

-(BOOL) isNewerVersionThan:(NSString*)otherVersion
{
    return ([self compare:otherVersion options:NSNumericSearch] == NSOrderedDescending);
}
- (NSString*)removeAllSpace
{
    NSString* result = [self stringByReplacingOccurrencesOfString:@" " withString:@""];
    result = [result stringByReplacingOccurrencesOfString:@"    " withString:@""];
    return result;
}

//计算输入的中文个数
+ (NSInteger)chineseCountOfString:(NSString *)string{
    //int characterCount = 0;
    int ChineseCount = 0;
    if (string.length == 0) {
        return 0;
    }
    for (int i = 0; i<string.length; i++) {
        unichar c = [string characterAtIndex:i];
        if (c >=0x4E00 && c <=0x9FA5){
            ChineseCount++ ;//汉字
        }
    }
    return  ChineseCount;
}


//计算输入的英文个数
+ (NSInteger)characterCountOfString:(NSString *)string{
    int characterCount = 0;
    if (string.length == 0) {
        return 0;
    }
    for (int i = 0; i<string.length; i++) {
        unichar c = [string characterAtIndex:i];
        if (!(c >=0x4E00 && c <=0x9FA5)){
            characterCount++;//英文
        }
    }
    return characterCount;
}


+ (BOOL)stringContainsEmoji:(NSString *)string
{
    __block BOOL returnValue = NO;
    
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length])
                               options:NSStringEnumerationByComposedCharacterSequences
                            usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
                                const unichar hs = [substring characterAtIndex:0];
                                if (0xd800 <= hs && hs <= 0xdbff) {
                                    if (substring.length > 1) {
                                        const unichar ls = [substring characterAtIndex:1];
                                        const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                                        if (0x1d000 <= uc && uc <= 0x1f77f) {
                                            returnValue = YES;
                                        }
                                    }
                                } else if (substring.length > 1) {
                                    const unichar ls = [substring characterAtIndex:1];
                                    if (ls == 0x20e3) {
                                        returnValue = YES;
                                    }
                                } else {
                                    if (0x2100 <= hs && hs <= 0x27ff) {
                                        returnValue = YES;
                                    } else if (0x2B05 <= hs && hs <= 0x2b07) {
                                        returnValue = YES;
                                    } else if (0x2934 <= hs && hs <= 0x2935) {
                                        returnValue = YES;
                                    } else if (0x3297 <= hs && hs <= 0x3299) {
                                        returnValue = YES;
                                    } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
                                        returnValue = YES;
                                    }
                                }
                            }];
    
    return returnValue;
}

/**
 *  替换表情符号，方便计算字符串长度
 *
 *  @param string 原字符串
 *
 *  @return 替换表情后的字符串
 */
+(NSString*)stringContainsEmotions:(NSString*)string{
    NSString *emotionNewPath = [[NSBundle mainBundle] pathForResource:@"emotionNew" ofType:@"plist"];
    NSArray *emotionNewList = [NSArray arrayWithContentsOfFile:emotionNewPath];
    for (NSDictionary *dic in emotionNewList) {
        if( [string containsString:dic[@"chs"]]){
            NSString *text = [string stringByReplacingOccurrencesOfString:dic[@"chs"] withString:@"EMJ"];
            string = text;
        }
    }
    /**
       for (int i=0; i<[string length]; i++) {
        NSRange range1 = [string rangeOfString:@"[" options:NSBackwardsSearch];
        NSRange range2 = [string rangeOfString:@"]" options:NSBackwardsSearch];
        if (range1.location != NSNotFound && range2.location !=NSNotFound) {
            
            if (range2.location - range1.location == 3) { //是emotion表情的时候&& range2.location == string.length - 1
                range1.length = 4;
                NSString *text = [string stringByReplacingCharactersInRange:range1 withString:@"哈"];
                string = text;
            }else if ([string length]- range1.location <3){
                NSString *text = [string stringByReplacingCharactersInRange:range1 withString:@"H"];
                string = text;
            }else if ([string length]- range2.location <3){
                NSString *text = [string stringByReplacingCharactersInRange:range2 withString:@"H"];
                string = text;
            }else if ([string length]- range1.location >=3&&range1.location>=3){
                range1.location =range1.location+3;
                range1.length=1;
                NSString *afterStr = [string substringWithRange:range1];
                if (![afterStr isEqualToString:@"]"]) {
                    range1.location=range1.location-3;
                    NSString *text = [string stringByReplacingCharactersInRange:range1 withString:@"H"];
                    string = text;
                }else{
                    range1.location=range1.location-3;
                    range1.length = 4;
                    NSString *text = [string stringByReplacingCharactersInRange:range1 withString:@"哈"];
                    string = text;
                    
                }
            }else if ([string length]- range2.location >=3&&range2.location>=3){
                range2.location =range2.location-3;
                range2.length=1;
                NSString *afterStr = [string substringWithRange:range2];
                if (![afterStr isEqualToString:@"["]) {
                    range2.location=range2.location+3;
                    NSString *text = [string stringByReplacingCharactersInRange:range2 withString:@"H"];
                    string = text;
                }else{
                    range2.length = 4;
                    NSString *text = [string stringByReplacingCharactersInRange:range2 withString:@"哈"];
                    string = text;
                    
                }
            }
            else
                break;
            
        }
    } */
    return string;
}

-(CGFloat)lengthWidthLimitHeight:(CGFloat)maxHeight fontSize:(NSInteger)fontSize
{
    return [self boundingRectWithSize:CGSizeMake(MAXFLOAT, maxHeight) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]} context:NULL].size.width;
}

-(CGFloat)stringHeightLimitWidth:(CGFloat)maxWidth fontSize:(NSInteger)fontSize
{
    return [self boundingRectWithSize:CGSizeMake(maxWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]} context:NULL].size.height;
}

//获取拼音首字母(传入汉字字符串, 返回大写拼音首字母)
- (NSString *)firstCharactor
{
    //转成了可变字符串
    NSMutableString *str = [NSMutableString stringWithString:self];
    //先转换为带声调的拼音
    CFStringTransform((CFMutableStringRef)str,NULL, kCFStringTransformMandarinLatin,NO);
    //再转换为不带声调的拼音
    CFStringTransform((CFMutableStringRef)str,NULL, kCFStringTransformStripDiacritics,NO);
    //转化为大写拼音
    NSString *pinYin = [str capitalizedString];
    //获取并返回首字母
    return [pinYin substringToIndex:1];
}


@end