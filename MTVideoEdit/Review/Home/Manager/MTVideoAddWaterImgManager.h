//
//  MTVideoAddWaterImgManager.h
//  MTVideoEdit
//
//  Created by MTShawn on 2018/9/17.
//  Copyright © 2018年 MT. All rights reserved.
//

#import "MTVideoClipManager.h"

@interface MTVideoAddWaterImgManager : MTVideoEditManager

/**
 添加水印

 @param waterImg 图片
 @param completion 回调
 */
- (void)addWaterImg:(UIImage *)waterImg completion:(completion)completion;
@end
