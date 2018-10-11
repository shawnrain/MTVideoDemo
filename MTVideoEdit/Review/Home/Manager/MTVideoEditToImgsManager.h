//
//  MTVideoEditToImgsManager.h
//  MTVideoEdit
//
//  Created by MTShawn on 2018/9/18.
//  Copyright © 2018年 MT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MTVideoEditToImgsManager : NSObject
/**
 视频转图片
 
 @param assets 视频数据源
 @param callback 回调
 */
+ (void)videoToImgs:(AVURLAsset *)assets calllBack:(void(^)(BOOL success))callback;
@end
