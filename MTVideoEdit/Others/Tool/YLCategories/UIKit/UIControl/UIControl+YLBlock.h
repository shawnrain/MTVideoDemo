//
//  UIControl+YLBlock.h
//  OC-YL
//
//  Created by melon on 2018/5/25.
//  Copyright © 2018年 melon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIControl (YLBlock)
- (void)yl_touchDown:(void (^)(void))eventBlock;
- (void)yl_touchDownRepeat:(void (^)(void))eventBlock;
- (void)yl_touchDragInside:(void (^)(void))eventBlock;
- (void)yl_touchDragOutside:(void (^)(void))eventBlock;
- (void)yl_touchDragEnter:(void (^)(void))eventBlock;
- (void)yl_touchDragExit:(void (^)(void))eventBlock;
- (void)yl_touchUpInside:(void (^)(void))eventBlock;
- (void)yl_touchUpOutside:(void (^)(void))eventBlock;
- (void)yl_touchCancel:(void (^)(void))eventBlock;
- (void)yl_valueChanged:(void (^)(void))eventBlock;
- (void)yl_editingDidBegin:(void (^)(void))eventBlock;
- (void)yl_editingChanged:(void (^)(void))eventBlock;
- (void)yl_editingDidEnd:(void (^)(void))eventBlock;
- (void)yl_editingDidEndOnExit:(void (^)(void))eventBlock;
@end
