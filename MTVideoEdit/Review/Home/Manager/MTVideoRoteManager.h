//
//  MTVideoRoteManager.h
//  MTVideoEdit
//
//  Created by MTShawn on 2018/9/18.
//  Copyright © 2018年 MT. All rights reserved.
//

#import "MTVideoEditManager.h"

@interface MTVideoRoteManager : MTVideoEditManager

/**
 旋转视频

 @param asset 元数据
 @param rotation 旋转的角度
 @param completion 回调
 */
+ (void)videoAsset:(AVURLAsset *)asset angleOfRotation:(CGFloat)rotation completion:(completion)completion;
@end
