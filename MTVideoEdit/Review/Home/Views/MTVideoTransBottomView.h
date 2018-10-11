//
//  MTVideoTransBottomView.h
//  MTVideoEdit
//
//  Created by MTShawn on 2018/9/19.
//  Copyright © 2018年 MT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MTVideoTransBottomView : UIView
@property (nonatomic, copy) void(^videoTransform)(CGFloat rote);
@property (nonatomic, copy) void(^videoEditBtn)(void);
@end
