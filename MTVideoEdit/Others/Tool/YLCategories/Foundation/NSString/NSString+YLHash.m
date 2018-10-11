//
//  NSString+YLHash.m
//  OC-YL
//
//  Created by melon on 2018/2/7.
//  Copyright © 2018年 melon. All rights reserved.
//

#import "NSString+YLHash.h"
#include <CommonCrypto/CommonCrypto.h>
@implementation NSString (YLHash)

- (nullable NSString *)yl_md5
{
    return [self yl_stringFromUsingAlg:CC_MD5_DIGEST_LENGTH];
}

- (nullable NSString *)yl_sha1
{
    return [self yl_stringFromUsingAlg:CC_SHA1_DIGEST_LENGTH];
}

- (nullable NSString *)yl_sha224
{
    return [self yl_stringFromUsingAlg:CC_SHA224_DIGEST_LENGTH];
}


- (nullable NSString *)yl_sha256
{
    return [self yl_stringFromUsingAlg:CC_SHA256_DIGEST_LENGTH];
}


- (nullable NSString *)yl_sha384
{
    return [self yl_stringFromUsingAlg:CC_SHA384_DIGEST_LENGTH];
}


- (nullable NSString *)yl_sha512
{
    return [self yl_stringFromUsingAlg:CC_SHA512_DIGEST_LENGTH];
}


- (nullable NSString *)hmacMD5StringWithKey:(NSString *)key
{
    return [self yl_hmacStringUsingAlg:CC_MD5_DIGEST_LENGTH withKey:key];
}

- (nullable NSString *)hmacSHA1StringWithKey:(NSString *)key
{
    return [self yl_hmacStringUsingAlg:CC_SHA1_DIGEST_LENGTH withKey:key];
}

- (nullable NSString *)hmacSHA224StringWithKey:(NSString *)key
{
    return [self yl_hmacStringUsingAlg:CC_SHA224_DIGEST_LENGTH withKey:key];
}

- (nullable NSString *)hmacSHA256StringWithKey:(NSString *)key
{
    return [self yl_hmacStringUsingAlg:CC_SHA256_DIGEST_LENGTH withKey:key];
}

- (nullable NSString *)hmacSHA384StringWithKey:(NSString *)key
{
    return [self yl_hmacStringUsingAlg:CC_SHA384_DIGEST_LENGTH withKey:key];
}

- (nullable NSString *)hmacSHA512StringWithKey:(NSString *)key
{
    return [self yl_hmacStringUsingAlg:CC_SHA512_DIGEST_LENGTH withKey:key];
}

#pragma mark - Helpers
- (NSString *)yl_stringFromUsingAlg:(CCHmacAlgorithm)alg
{
    const char *string = [self UTF8String];
    int length = (int)strlen(string);
    unsigned char bytes[alg];
    CC_MD5(string, length, bytes);
    return [self yl_stringFromBytes:bytes length:alg];
}
- (NSString *)yl_hmacStringUsingAlg:(CCHmacAlgorithm)alg withKey:(NSString *)key {
    size_t size;
    switch (alg) {
        case kCCHmacAlgMD5: size = CC_MD5_DIGEST_LENGTH; break;
        case kCCHmacAlgSHA1: size = CC_SHA1_DIGEST_LENGTH; break;
        case kCCHmacAlgSHA224: size = CC_SHA224_DIGEST_LENGTH; break;
        case kCCHmacAlgSHA256: size = CC_SHA256_DIGEST_LENGTH; break;
        case kCCHmacAlgSHA384: size = CC_SHA384_DIGEST_LENGTH; break;
        case kCCHmacAlgSHA512: size = CC_SHA512_DIGEST_LENGTH; break;
        default: return nil;
    }
    
    NSData *keyData = [key dataUsingEncoding:NSUTF8StringEncoding];
    NSData *messageData = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSMutableData *mutableData = [NSMutableData dataWithLength:size];
    CCHmac(alg, keyData.bytes, keyData.length, messageData.bytes, messageData.length, mutableData.mutableBytes);
    return [self yl_stringFromBytes:(unsigned char *)mutableData.bytes length:(int)mutableData.length];
}
- (NSString *)yl_stringFromBytes:(unsigned char *)bytes length:(int)length
{
    NSMutableString *mutableString = [NSMutableString new];
    for (int i = 0; i < length; i++)
        [mutableString appendFormat:@"%02x", bytes[i]];
    return [NSString stringWithString:mutableString].lowercaseString;
}
@end

