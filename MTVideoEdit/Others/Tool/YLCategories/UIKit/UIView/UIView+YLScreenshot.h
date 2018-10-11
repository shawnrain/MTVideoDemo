//
//  UIView+YLScreenshot.h
//  OC-YL
//
//  Created by melon on 2018/5/25.
//  Copyright © 2018年 melon. All rights reserved.
//

#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN
@interface UIView (YLScreenshot)

/**
 Create a snapshot image of the complete view hierarchy.
 */
- (nullable UIImage *)yl_screenshot;


/**
 Create a snapshot PDF of the complete view hierarchy.
 */
- (nullable NSData *)yl_snapshotPDF;
@end
NS_ASSUME_NONNULL_END
