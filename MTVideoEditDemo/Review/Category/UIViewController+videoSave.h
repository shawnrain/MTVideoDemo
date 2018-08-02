//
//  UIViewController+videoSave.h
//  MTVideoEditDemo
//
//  Created by MTShawn on 2018/7/31.
//  Copyright © 2018年 MT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (videoSave)

//@property (nonatomic, strong) AVAssetExportSession *exporter;

/**
 给视频添加水印

 @param waterImage 水印图片
 @param completionBlock 回调
 */
- (void)videoSaveWithWaterImg:(UIImage *)waterImage completion:(void (^)(AVAssetExportSessionStatus status,NSURL * videoUrl))completionBlock;

/**
 截取视频并添加背景音乐

 @param audioAsset 音频数据
 @param videoRange 截取的范围
 @param completionBlock 回调
 */
- (void)videoAddBackGroundMusic:(AVURLAsset *)audioAsset captureVideoWithRange:(NSRange)videoRange completion:(void (^)(AVAssetExportSessionStatus status,NSURL * videoUrl))completionBlock;
/**
 多个视频合成

 @param tArray 数组视频 AVURLAsset
 @param completionBlock 回调地址
 */
-(void)mergeVideoToOneVideo:(NSArray *)tArray completion:(void (^)(AVAssetExportSessionStatus status,NSURL * videoUrl))completionBlock;
//存储地址
- (NSURL *)getExportVideoUrl;

@end
