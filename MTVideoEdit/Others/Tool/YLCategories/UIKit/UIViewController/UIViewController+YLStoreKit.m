//
//  UIViewController+YLStoreKit.m
//  OC-YL
//
//  Created by melon on 2018/5/25.
//  Copyright © 2018年 melon. All rights reserved.
//

#import "UIViewController+YLStoreKit.h"
#import <objc/runtime.h>

#import <StoreKit/StoreKit.h>
NSString* const yl_affiliateTokenKey = @"at";
NSString* const yl_campaignTokenKey = @"ct";
NSString* const yl_iTunesAppleString = @"itunes.apple.com";
@interface UIViewController (SKStoreProductViewControllerDelegate) <SKStoreProductViewControllerDelegate>

@end
@implementation UIViewController (YLStoreKit)
- (void)yl_presentStoreKitItemWithIdentifier:(NSInteger)itemIdentifier
{
    SKStoreProductViewController* storeViewController = [[SKStoreProductViewController alloc] init];
    storeViewController.delegate = self;
    
    NSString* campaignToken = self.yl_campaignToken ?: @"";
    
    NSDictionary* parameters = @{
                                 SKStoreProductParameterITunesItemIdentifier : @(itemIdentifier),
                                 yl_affiliateTokenKey : yl_affiliateTokenKey,
                                 yl_campaignTokenKey : campaignToken,
                                 };
    
    if (self.yl_loadingStoreKitItemBlock) {
        self.yl_loadingStoreKitItemBlock();
    }
    [storeViewController loadProductWithParameters:parameters completionBlock:^(BOOL result, NSError* error) {
        if (self.yl_loadedStoreKitItemBlock) {
            self.yl_loadedStoreKitItemBlock();
        }
        
        if (result && !error)
        {
            [self presentViewController:storeViewController animated:YES completion:nil];
        }
    }];
}

////////////////////////////////////////////////////////////////////////////////
#pragma mark - Delegation - SKStoreProductViewControllerDelegate

- (void)productViewControllerDidFinish:(SKStoreProductViewController *)viewController
{
    [viewController dismissViewControllerAnimated:YES completion:nil];
}

////////////////////////////////////////////////////////////////////////////////
#pragma mark - Public methods

+ (NSURL*)yl_appURLForIdentifier:(NSInteger)identifier
{
    NSString* appURLString = [NSString stringWithFormat:@"https://itunes.apple.com/cn/app/id%li", (long)identifier];
    return [NSURL URLWithString:appURLString];
}

+ (void)yl_openAppURLForIdentifier:(NSInteger)identifier
{
    NSString* appURLString = [NSString stringWithFormat:@"itms-apps://itunes.apple.com/app/id%li", (long)identifier];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:appURLString]];
}

+ (BOOL)yl_containsITunesURLString:(NSString*)URLString
{
    return ([URLString rangeOfString:yl_iTunesAppleString].location != NSNotFound);
}

+ (NSInteger)yl_IDFromITunesURL:(NSString*)URLString
{
    NSError* error;
    NSRegularExpression* regex = [NSRegularExpression regularExpressionWithPattern:@"id\\d+" options:0 error:&error];
    NSTextCheckingResult* match = [regex firstMatchInString:URLString options:0 range:NSMakeRange(0, URLString.length)];
    
    NSString* idString = [URLString substringWithRange:match.range];
    if (idString.length > 0) {
        idString = [idString stringByReplacingOccurrencesOfString:@"id" withString:@""];
    }
    
    return [idString integerValue];
}

////////////////////////////////////////////////////////////////////////////////
#pragma mark - Associated objects

- (void)setYl_campaignToken:(NSString*)campaignToken
{
    objc_setAssociatedObject(self, @selector(setYl_campaignToken:), campaignToken, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSString*)yl_campaignToken
{
    return objc_getAssociatedObject(self, @selector(setYl_campaignToken:));
}

- (void)setYl_loadingStoreKitItemBlock:(void (^)(void))loadingStoreKitItemBlock
{
    objc_setAssociatedObject(self, @selector(setYl_loadingStoreKitItemBlock:), loadingStoreKitItemBlock, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void (^)(void))yl_loadingStoreKitItemBlock
{
    return objc_getAssociatedObject(self, @selector(setYl_loadingStoreKitItemBlock:));
}

- (void)setYl_loadedStoreKitItemBlock:(void (^)(void))loadedStoreKitItemBlock
{
    objc_setAssociatedObject(self, @selector(setYl_loadedStoreKitItemBlock:), loadedStoreKitItemBlock, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void (^)(void))yl_loadedStoreKitItemBlock
{
    return objc_getAssociatedObject(self, @selector(setYl_loadedStoreKitItemBlock:));
}

@end
