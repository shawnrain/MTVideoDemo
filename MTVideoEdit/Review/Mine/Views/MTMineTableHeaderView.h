//
//  MTMineTableHeaderView.h
//  MTVideoEdit
//
//  Created by MTShawn on 2018/9/19.
//  Copyright © 2018年 MT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MTMineTableHeaderView : UIView
@property (nonatomic, copy) void(^videoSetBtnSelected)(void);
@property (nonatomic, copy) void(^messageBtnSelected)(void);
@end
