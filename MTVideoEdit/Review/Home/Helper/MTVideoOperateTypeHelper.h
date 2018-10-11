//
//  MTVideoOperateTypeHelper.h
//  wanghong
//
//  Created by MTShawn on 2018/9/11.
//  Copyright © 2018年 MT. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSInteger,MTVideoOperateType){
    MTVideoOperateTypeReversing  = 888,//倒放视频
    MTVideoOperateTypeSeparate   = 889,//分离音视频
    MTVideoOperateTypeAddBGAudio = 890,//添加背景音乐
    MTVideoOperateTypeChangeRate = 891,//改变播放速率
    MTVideoOperateTypeMergeVideo = 892,//合成视频
    MTVideoOperateTypeReduction  = 893,//还原视频
    MTVideoOperateTypeClip       = 894,//视频剪辑
    MTVideoOperateTypeAddWaterImg= 895,//添加文字水印
    MTVideoOperateTypeVideoToImg = 896,//视频转图片
    MTVideoOperateTypeTransform  = 897,//视频旋转
    MTVideoOperateTypeCancel     = 999,//取消操作
    MTVideoOperateTypeDone       = 1000,//确定
};

@interface MTVideoOperateTypeHelper : NSObject

@end
