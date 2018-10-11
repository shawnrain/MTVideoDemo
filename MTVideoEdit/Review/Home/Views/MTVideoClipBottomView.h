//
//  MTVideoClipBottomView.h
//  MTVideoEdit
//
//  Created by MTShawn on 2018/9/18.
//  Copyright © 2018年 MT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MTVideoClipBottomView : UIView
@property (nonatomic, strong) AVAsset  * asset;
@property (nonatomic, copy) void(^clipBtnCallBack)(NSInteger start,NSInteger endIndex);
@end
