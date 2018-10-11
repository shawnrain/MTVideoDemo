//
//  NSString+YLHash.h
//  OC-YL
//
//  Created by melon on 2018/2/7.
//  Copyright © 2018年 melon. All rights reserved.
//

#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN
@interface NSString (YLHash)

/**
 Return a lowercase NSString for md5 hash.
 */
- (nullable NSString *)yl_md5;

/**
 Return a lowercase NSString for sha1 hash.
 */
- (nullable NSString *)yl_sha1;

/**
 Return a lowercase NSString for sha224 hash.
 */
- (nullable NSString *)yl_sha224;

/**
 Return a lowercase NSString for sha256 hash.
 */
- (nullable NSString *)yl_sha256;

/**
 Return a lowercase NSString for sha384 hash.
 */
- (nullable NSString *)yl_sha384;

/**
 Return a lowercase NSString for sha512 hash.
 */
- (nullable NSString *)yl_sha512;

/**
 Returns a lowercase NSString for hmac using algorithm md5 with key.
 @param key The hmac key.
 */
- (nullable NSString *)hmacMD5StringWithKey:(NSString *)key;

/**
 Returns a lowercase NSString for hmac using algorithm sha1 with key.
 @param key The hmac key.
 */
- (nullable NSString *)hmacSHA1StringWithKey:(NSString *)key;

/**
 Returns a lowercase NSString for hmac using algorithm sha224 with key.
 @param key The hmac key.
 */
- (nullable NSString *)hmacSHA224StringWithKey:(NSString *)key;

/**
 Returns a lowercase NSString for hmac using algorithm sha256 with key.
 @param key The hmac key.
 */
- (nullable NSString *)hmacSHA256StringWithKey:(NSString *)key;

/**
 Returns a lowercase NSString for hmac using algorithm sha384 with key.
 @param key The hmac key.
 */
- (nullable NSString *)hmacSHA384StringWithKey:(NSString *)key;

/**
 Returns a lowercase NSString for hmac using algorithm sha512 with key.
 @param key The hmac key.
 */
- (nullable NSString *)hmacSHA512StringWithKey:(NSString *)key;
@end
NS_ASSUME_NONNULL_END
