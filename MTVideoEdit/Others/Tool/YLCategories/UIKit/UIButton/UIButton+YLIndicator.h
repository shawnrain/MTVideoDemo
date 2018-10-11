//
//  UIButton+YLIndicator.h
//  OC-YL
//
//  Created by melon on 2018/6/29.
//  Copyright © 2018年 melon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (YLIndicator)

/**
 This method will show the activity indicator in place of the button text.
 */
- (void)yl_showIndicator;
/**
 This method will remove the indicator and put thebutton text back in place.
 */
- (void)yl_hideIndicator;
@end
