//
//  MTAddWaterView.h
//  MTVideoEdit
//
//  Created by MTShawn on 2018/9/19.
//  Copyright © 2018年 MT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MTAddWaterView : UIView
@property (nonatomic, copy) void(^btnSelected)(BOOL isSave,NSString * content);
@property (nonatomic, copy) NSString  * content;
@end

@interface MTVideoMaskView : UIView
@property (nonatomic, copy) NSString  * content;

@property (nonatomic, copy) void(^labelTapOn)(NSString *lStr);
@end
