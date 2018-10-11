//
//  UIApplication+YLSandBoxPath.m
//  OC-YL
//
//  Created by melon on 2018/5/25.
//  Copyright © 2018年 melon. All rights reserved.
//

#import "UIApplication+YLSandBoxPath.h"

@implementation UIApplication (YLSandBoxPath)
+ (NSURL *)yl_URLForDirectory:(NSSearchPathDirectory)directory
{
    return [NSURL URLWithString:[self yl_pathForDirectory:directory]];
}

+ (NSString *)yl_pathForDirectory:(NSSearchPathDirectory)directory
{
    return NSSearchPathForDirectoriesInDomains(directory, NSUserDomainMask, YES)[0];
}

+ (NSURL *)yl_documentsURL
{
    return [self yl_URLForDirectory:NSDocumentDirectory];
}

+ (NSString *)yl_documentsPath
{
    return [self yl_pathForDirectory:NSDocumentDirectory];
}

+ (NSURL *)yl_libraryURL
{
    return [self yl_URLForDirectory:NSLibraryDirectory];
}

+ (NSString *)yl_libraryPath
{
    return [self yl_pathForDirectory:NSLibraryDirectory];
}

+ (NSURL *)yl_cachesURL
{
    return [self yl_URLForDirectory:NSCachesDirectory];
}

+ (NSString *)yl_cachesPath
{
    return [self yl_pathForDirectory:NSCachesDirectory];
}

@end
