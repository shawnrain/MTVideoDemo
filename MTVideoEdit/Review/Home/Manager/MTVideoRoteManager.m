//
//  MTVideoRoteManager.m
//  MTVideoEdit
//
//  Created by MTShawn on 2018/9/18.
//  Copyright © 2018年 MT. All rights reserved.
//

#import "MTVideoRoteManager.h"
#define degreesToRadians( degrees ) ( ( degrees ) / 180.0 * M_PI )
@implementation MTVideoRoteManager
/**
 旋转视频
 
 @param asset 元数据
 @param rotation 旋转的角度
 @param completion 回调
 */
+ (void)videoAsset:(AVURLAsset *)asset angleOfRotation:(CGFloat)rotation completion:(completion)completion{
    MTVideoRoteManager * manager = [[MTVideoRoteManager alloc] init];
    manager.completionBlock = completion;
    manager.asset = asset;
    [manager videoAngleRotation:rotation];
}
- (void)videoAngleRotation:(CGFloat)rotation{
    
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
    
    CGAffineTransform t1;
    CGAffineTransform t2;
    if (rotation == 90){
        t1 = CGAffineTransformMakeTranslation(videoTrack.naturalSize.height, 0.0);
        t2 = CGAffineTransformRotate(t1, degreesToRadians(90));
    }else if (rotation == 180){
        t1 = CGAffineTransformMakeTranslation(videoTrack.naturalSize.width, videoTrack.naturalSize.height);
        t2 = CGAffineTransformRotate(t1, degreesToRadians(180));
    }else{
        t1 = CGAffineTransformMakeTranslation(0,videoTrack.naturalSize.width);
        t2 = CGAffineTransformRotate(t1, degreesToRadians(-90));
    }
    CGSize renderSize;
    if (rotation == 90.0 || rotation == 270.0) {
        renderSize = CGSizeMake(videoTrack.naturalSize.height, videoTrack.naturalSize.width);
    }else{
        renderSize = CGSizeMake(videoTrack.naturalSize.width,videoTrack.naturalSize.height);
    }
    
    //视频设置
    AVMutableVideoComposition * videoComposition = [AVMutableVideoComposition videoComposition];
    videoComposition.renderSize = renderSize;
    videoComposition.frameDuration = CMTimeMake(1, 30);
    
    AVMutableVideoCompositionInstruction * instruction = [AVMutableVideoCompositionInstruction videoCompositionInstruction];
    instruction.timeRange = CMTimeRangeMake(kCMTimeZero, [composition duration]);
    
    AVMutableVideoCompositionLayerInstruction * layerInstruction = [AVMutableVideoCompositionLayerInstruction videoCompositionLayerInstructionWithAssetTrack:videoTrack];
    [layerInstruction setTransform:t2 atTime:kCMTimeZero];
    instruction.layerInstructions = @[layerInstruction];
    videoComposition.instructions = @[instruction];
    [self exportVideoComposition:videoComposition composition:composition];
    
}
@end
