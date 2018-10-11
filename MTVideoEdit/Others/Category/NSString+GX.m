//
//  NSString+GX.m
//  KwaiUp
//
//  Created by melon on 2017/12/28.
//  Copyright © 2017年 melon. All rights reserved.
//

#import "NSString+GX.h"
#import <CommonCrypto/CommonDigest.h>
@implementation NSString (GX)
- (BOOL)isEmpty
{
    if (self == nil || self == NULL) {
        return YES;
    }
    if (self.length == 0) {
        return YES;
    }
    if ([self isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    return NO;
}

- (NSString *)md5;
{
    const char *cStr = [self UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), digest);
    NSMutableString *result = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [result appendFormat:@"%02X", digest[i]];
    }
    return result.copy;
}
@end
