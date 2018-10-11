//
//  UIViewController+YLStoreKit.h
//  OC-YL
//
//  Created by melon on 2018/5/25.
//  Copyright © 2018年 melon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (YLStoreKit)
@property NSString *yl_campaignToken;
@property (nonatomic, copy) void (^yl_loadingStoreKitItemBlock)(void);
@property (nonatomic, copy) void (^yl_loadedStoreKitItemBlock)(void);

- (void)yl_presentStoreKitItemWithIdentifier:(NSInteger)itemIdentifier;

+ (NSURL *)yl_appURLForIdentifier:(NSInteger)identifier;

+ (void)yl_openAppURLForIdentifier:(NSInteger)identifier;

+ (BOOL)yl_containsITunesURLString:(NSString*)URLString;
+ (NSInteger)yl_IDFromITunesURL:(NSString*)URLString;
@end
