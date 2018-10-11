//
//  MTVideoClipManager.m
//  MTVideoEdit
//
//  Created by MTShawn on 2018/9/17.
//  Copyright © 2018年 MT. All rights reserved.
//

#import "MTVideoClipManager.h"

@implementation MTVideoClipManager
- (void)clipVideoStartIndex:(CGFloat)start end:(CGFloat)end completion:(completion)completion{
    self.completionBlock = completion;
    AVMutableComposition * composition = [AVMutableComposition composition];
    
    CMTime startTime = CMTimeMakeWithSeconds(start, self.asset.duration.timescale);
    CMTime endTime = CMTimeMakeWithSeconds(end, self.asset.duration.timescale);
    CMTimeRange timeRange = CMTimeRangeFromTimeToTime(startTime, endTime);
    
    AVMutableCompositionTrack * audioCompositionTrack = [composition addMutableTrackWithMediaType:AVMediaTypeAudio preferredTrackID:kCMPersistentTrackID_Invalid];
    AVAssetTrack * audioTrack = [self.asset tracksWithMediaType:AVMediaTypeAudio].firstObject;
    [audioCompositionTrack insertTimeRange:timeRange ofTrack:audioTrack atTime:kCMTimeZero error:nil];
    
    AVMutableCompositionTrack * videoCompositionTrack = [composition addMutableTrackWithMediaType:AVMediaTypeVideo preferredTrackID:kCMPersistentTrackID_Invalid];
    AVAssetTrack * videoTrack = [self.asset tracksWithMediaType:AVMediaTypeVideo].firstObject;
    [videoCompositionTrack insertTimeRange:timeRange ofTrack:videoTrack atTime:kCMTimeZero error:nil];
    
    //最终成型的视频
    AVMutableVideoComposition *videoComposition = [AVMutableVideoComposition videoComposition];
    videoComposition.frameDuration = CMTimeMake(1,30);
    videoComposition.renderScale = 1.0;
    
    AVMutableVideoCompositionInstruction * videoCompositionInstructiion = [self correctVideoTransformWithvideoTrack:videoCompositionTrack];
    //设置方向
    videoComposition.instructions = [NSArray arrayWithObject:videoCompositionInstructiion];
    
    [self exportVideoComposition:nil composition:composition];    
}
@end
