//
//  MTPopView.h
//  MTVideoEdit
//
//  Created by MTShawn on 2018/9/19.
//  Copyright © 2018年 MT. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,MTPopViewType){
    MTPopViewTypeLoading,
    MTPopViewTypeNormal
};

@interface MTPopView : UIView
+(MTPopView *)MTPopViewShowLoading;
+(MTPopView *)MTPopViewShowWithStr:(NSString *)str;
+(MTPopView *)MTPopViewShowType:(MTPopViewType)type withStr:(NSString *)str withImage:(NSString *)imageName;
@end
