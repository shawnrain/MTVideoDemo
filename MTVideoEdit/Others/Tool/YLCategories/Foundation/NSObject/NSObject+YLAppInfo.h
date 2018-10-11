//
//  NSObject+YLAppInfo.h
//  OC-YL
//
//  Created by melon on 2018/5/25.
//  Copyright © 2018年 melon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (YLAppInfo)
/**
 App display name
 
 @return CFBundleDisplayName
 */
- (NSString *)yl_displayName;

/**
 App version

 @return CFBundleShortVersionString
 */
- (NSString *)yl_version;

/**
 App build

 @return CFBundleVersion
 */
- (NSString *)yl_build;

/**
 App Bundle Identifier

 @return CFBundleIdentifier
 */
- (NSString *)yl_identifier;

/**
 App Current Language

 @return current language
 */
- (NSString *)yl_currentLanguage;

/**
 construct model string
 
 @return construct model
 */
- (NSString *)yl_deviceModel;
@end
