//
//  WKWebView+YLLoad.h
//  OC-YL
//
//  Created by melon on 2018/6/29.
//  Copyright © 2018年 melon. All rights reserved.
//

#import <WebKit/WebKit.h>

@interface WKWebView (YLLoad)

/**
 读取一个网页地址

 @param URLString 网页地址
 */
- (void)yl_loadURL:(NSString *)URLString;
/**
 读取bundle中的webview

 @param htmlName 文件名称 xxx.html
 */
- (void)yl_loadLocalHtml:(NSString*)htmlName;
/**
 读取bundle中的webview

 @param htmlName 文件名称 xxx.html
 @param inBundle bundle
 */
- (void)yl_loadLocalHtml:(NSString*)htmlName inBundle:(NSBundle*)inBundle;
/**
 清空cookie
 */
- (void)yl_clearCookies;
@end
