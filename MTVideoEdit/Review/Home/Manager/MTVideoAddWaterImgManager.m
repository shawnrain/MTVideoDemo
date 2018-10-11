//
//  MTVideoAddWaterImgManager.m
//  MTVideoEdit
//
//  Created by MTShawn on 2018/9/17.
//  Copyright © 2018年 MT. All rights reserved.
//

#import "MTVideoAddWaterImgManager.h"

@implementation MTVideoAddWaterImgManager
/**
 添加水印
 
 @param waterImg 图片
 @param completion 回调
 */
- (void)addWaterImg:(UIImage *)waterImg completion:(completion)completion{
    self.completionBlock = completion;
    CGFloat durTime = self.asset.duration.value/self.asset.duration.timescale;
    CMTime endTime = CMTimeMakeWithSeconds(durTime, self.asset.duration.timescale);
    CMTimeRange timeRange = CMTimeRangeMake(kCMTimeZero, endTime);
    
    AVMutableComposition *composition = [AVMutableComposition composition];
    //
    AVMutableCompositionTrack * audioCompositionTrack = [composition addMutableTrackWithMediaType:AVMediaTypeAudio preferredTrackID:kCMPersistentTrackID_Invalid];
    AVAssetTrack * audioTrack = [self.asset tracksWithMediaType:AVMediaTypeAudio].firstObject;
    [audioCompositionTrack insertTimeRange:timeRange ofTrack:audioTrack atTime:kCMTimeZero error:nil];
    //
    AVMutableCompositionTrack * videoCompositionTrack = [composition addMutableTrackWithMediaType:AVMediaTypeVideo preferredTrackID:kCMPersistentTrackID_Invalid];
    AVAssetTrack * videoTrack = [self.asset tracksWithMediaType:AVMediaTypeVideo].firstObject;
    [videoCompositionTrack insertTimeRange:timeRange ofTrack:videoTrack atTime:kCMTimeZero error:nil];
    
    
    
    //3.1 AVMutableVideoCompositionInstruction 视频轨道中的一个视频，可以缩放、旋转等
    AVMutableVideoCompositionInstruction *mainInstruction = [AVMutableVideoCompositionInstruction videoCompositionInstruction];
    mainInstruction.timeRange = CMTimeRangeFromTimeToTime(kCMTimeZero, videoCompositionTrack.timeRange.duration);
    
    // 3.2 AVMutableVideoCompositionLayerInstruction 一个视频轨道，包含了这个轨道上的所有视频素材
    AVMutableVideoCompositionLayerInstruction *videolayerInstruction = [AVMutableVideoCompositionLayerInstruction videoCompositionLayerInstructionWithAssetTrack:videoTrack];

    [videolayerInstruction setTransform:videoTrack.preferredTransform atTime:kCMTimeZero];
    [videolayerInstruction setOpacity:0.0 atTime:endTime];
    mainInstruction.layerInstructions = [NSArray arrayWithObjects:videolayerInstruction,nil];
    
    
    AVMutableVideoComposition *mainCompositionInst = [AVMutableVideoComposition videoComposition];
    CGSize naturalSize = [self getVideoNaturalSizeWithTransform:videoTrack.preferredTransform];
    mainCompositionInst.renderSize = naturalSize;
    mainCompositionInst.instructions = [NSArray arrayWithObject:mainInstruction];
    mainCompositionInst.frameDuration = CMTimeMake(1, 25);
    
    [self applyVideoEffectsToComposition:mainCompositionInst watermark:waterImg size:naturalSize];
    [self exportVideoComposition:mainCompositionInst composition:composition];
}
//添加水印
- (void)applyVideoEffectsToComposition:(AVMutableVideoComposition *)composition watermark:(UIImage *)watermark size:(CGSize)size
{
    if (!watermark) {
        //need not add watermark;
        return;
    }
    // 1 - set up the overlay
    CALayer *overlayLayer = [CALayer layer];
    UIImage *overlayImage = watermark;
    
    [overlayLayer setContents:(id)[overlayImage CGImage]];
    overlayLayer.frame = CGRectMake(0, 0, size.width, size.height);
    [overlayLayer setMasksToBounds:YES];
    
    // 2 - set up the parent layer
    CALayer *parentLayer = [CALayer layer];
    CALayer *videoLayer = [CALayer layer];
    parentLayer.frame = CGRectMake(0, 0, size.width, size.height);
    videoLayer.frame = CGRectMake(0, 0, size.width, size.height);
    [parentLayer addSublayer:videoLayer];
    [parentLayer addSublayer:overlayLayer];
    
    // 3 - apply magic
    composition.animationTool = [AVVideoCompositionCoreAnimationTool
                                 videoCompositionCoreAnimationToolWithPostProcessingAsVideoLayer:videoLayer inLayer:parentLayer];
    
}

@end
