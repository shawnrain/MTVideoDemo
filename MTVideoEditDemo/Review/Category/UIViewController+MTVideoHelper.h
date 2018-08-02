//
//  UIViewController+MTVideoHelper.h
//  MTVideoEditDemo
//
//  Created by MTShawn on 2018/8/1.
//  Copyright © 2018年 MT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (MTVideoHelper)
@property (nonatomic, assign) CGFloat   videoTotalTime;
@property (nonatomic, strong) AVURLAsset  * videoAssets;

/**
 设置合成视频相关的东西

 @param videoAsset 视频
 @param audioAsset 音频
 @param mixComposition 音视频合成器
 @return return value @[AVAssetTrack,videoAsset]
 */
- (NSArray *)setVideoAsset:(AVURLAsset *)videoAsset
                audioAsset:(AVURLAsset *)audioAsset
      avMutableComposition:(AVMutableComposition *)mixComposition;


/**
 设置剪切合成视频相关的东西

 @param videoAsset 视频
 @param audioAsset 音频
 @param mixComposition 音视频合成器
 @param range 剪切的范围
 @return @[AVAssetTrack,videoAsset]
 */
- (NSArray *)setVideoAsset:(AVURLAsset *)videoAsset
                audioAsset:(AVURLAsset *)audioAsset
      avMutableComposition:(AVMutableComposition *)mixComposition
                     range:(NSRange)range;

/**
 将媒体资源转换为 AVURLAsset

 @param PHASsetsArray 转换对象数组
 @param completion 回调
 */
- (void)PHAVAssetArray:(NSArray *)PHASsetsArray complemtion:(void(^)(NSMutableArray * lAVAssetArray))completion;
@end
