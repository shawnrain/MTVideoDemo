//
//  WKWebView+YLLoad.m
//  OC-YL
//
//  Created by melon on 2018/6/29.
//  Copyright © 2018年 melon. All rights reserved.
//

#import "WKWebView+YLLoad.h"

@implementation WKWebView (YLLoad)
- (void)yl_loadURL:(NSString *)URLString
{
    NSString *encodedUrl = [URLString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSURL *url = [NSURL URLWithString:encodedUrl];
    NSURLRequest *req = [NSURLRequest requestWithURL:url];
    [self loadRequest:req];
}

- (void)yl_loadLocalHtml:(NSString *)htmlName
{
    [self yl_loadLocalHtml:htmlName inBundle:[NSBundle mainBundle]];
}
- (void)yl_loadLocalHtml:(NSString *)htmlName inBundle:(NSBundle *)inBundle
{
    NSString *filePath = [inBundle pathForResource:htmlName ofType:nil];
    NSURL *url = [NSURL fileURLWithPath:filePath];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self loadRequest:request];
}
- (void)yl_clearCookies
{
    if (([UIDevice currentDevice].systemVersion.floatValue >= 9.0f)) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored  "-Wunguarded-availability"
        [[WKWebsiteDataStore defaultDataStore] fetchDataRecordsOfTypes:[WKWebsiteDataStore allWebsiteDataTypes] completionHandler:^(NSArray<WKWebsiteDataRecord *> * _Nonnull records) {
            for (WKWebsiteDataRecord *record in records) {
                [[WKWebsiteDataStore defaultDataStore] removeDataOfTypes:record.dataTypes forDataRecords:@[record] completionHandler:^{
                    //                NSLog(@"清除所有缓存");
                }];
            }
        }];
#pragma clang diagnostic pop
    }else{
        NSString *libraryPath = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        NSString *cookiesFolderPath = [libraryPath stringByAppendingString:@"/Cookies"];
        NSError *errors;
        [[NSFileManager defaultManager] removeItemAtPath:cookiesFolderPath error:&errors];
    }
}
@end
