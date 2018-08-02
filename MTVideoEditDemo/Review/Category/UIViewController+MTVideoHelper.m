//
//  UIViewController+MTVideoHelper.m
//  MTVideoEditDemo
//
//  Created by MTShawn on 2018/8/1.
//  Copyright © 2018年 MT. All rights reserved.
//

#import "UIViewController+MTVideoHelper.h"
#import <objc/runtime.h>
@implementation UIViewController (MTVideoHelper)
- (void)setVideoAssets:(AVAsset *)videoAssets{
    objc_setAssociatedObject(self, @selector(videoAssets), videoAssets, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (AVAsset *)videoAssets{
    return objc_getAssociatedObject(self, @selector(videoAssets));
}

- (void)setVideoTotalTime:(CGFloat)videoTotalTime{
    objc_setAssociatedObject(self, @selector(videoTotalTime), [NSNumber numberWithFloat:videoTotalTime], OBJC_ASSOCIATION_ASSIGN);
}
- (CGFloat)videoTotalTime{
    return [objc_getAssociatedObject(self, @selector(videoTotalTime)) floatValue];
}


- (NSArray *)setVideoAsset:(AVURLAsset *)videoAsset audioAsset:(AVURLAsset *)audioAsset avMutableComposition:(AVMutableComposition *)mixComposition{
    return [self setVideoAsset:videoAsset audioAsset:audioAsset avMutableComposition:mixComposition range:NSMakeRange(0, 0)];
}
- (NSArray *)setVideoAsset:(AVURLAsset *)videoAsset audioAsset:(AVURLAsset *)audioAsset avMutableComposition:(AVMutableComposition *)mixComposition range:(NSRange)range{
    CMTime startTime = CMTimeMakeWithSeconds(0.2, 600);
    CMTime endTime = CMTimeMakeWithSeconds(videoAsset.duration.value/videoAsset.duration.timescale-0.2, videoAsset.duration.timescale);
    if (range.length != 0) {
        startTime = CMTimeMakeWithSeconds(range.location, videoAsset.duration.timescale);
        endTime = CMTimeMakeWithSeconds(range.length, videoAsset.duration.timescale);
    }
    //3 视频通道  工程文件中的轨道，有音频轨、视频轨等，里面可以插入各种对应的素材
    AVMutableCompositionTrack *videoTrack = [mixComposition addMutableTrackWithMediaType:AVMediaTypeVideo
                                                                        preferredTrackID:kCMPersistentTrackID_Invalid];
    //把视频轨道数据加入到可变轨道中 这部分可以做视频裁剪TimeRange
    [videoTrack insertTimeRange:CMTimeRangeFromTimeToTime(startTime, endTime)
                        ofTrack:[[videoAsset tracksWithMediaType:AVMediaTypeVideo] objectAtIndex:0]
                         atTime:kCMTimeZero error:nil];
    //音频通道
    AVMutableCompositionTrack * audioTrack = [mixComposition addMutableTrackWithMediaType:AVMediaTypeAudio preferredTrackID:kCMPersistentTrackID_Invalid];
    //音频采集通道
    AVAssetTrack * audioAssetTrack = [[audioAsset tracksWithMediaType:AVMediaTypeAudio] firstObject];
    [audioTrack insertTimeRange:CMTimeRangeFromTimeToTime(startTime, endTime) ofTrack:audioAssetTrack atTime:kCMTimeZero error:nil];
    
    return @[videoTrack,videoAsset];
}

/**
 将媒体资源转换为 AVURLAsset
 
 @param PHASsetsArray 转换对象数组
 @param completion 回调
 */
- (void)PHAVAssetArray:(NSArray *)PHASsetsArray complemtion:(void(^)(NSMutableArray * lAVAssetArray))completion{
    __block NSMutableArray * videoAssetsArray = [NSMutableArray arrayWithCapacity:0];
    __weak typeof(self)weakSelf = self;
    dispatch_queue_t queue = dispatch_queue_create("dispatch_AVURLAsset", DISPATCH_QUEUE_CONCURRENT);
    dispatch_group_t group = dispatch_group_create();
    for (id avassets in PHASsetsArray) {
        dispatch_group_enter(group);
        dispatch_group_async(group, queue, ^{
            PHVideoRequestOptions *options = [[PHVideoRequestOptions alloc] init];
            options.version = PHImageRequestOptionsVersionCurrent;
            options.deliveryMode = PHVideoRequestOptionsDeliveryModeAutomatic;
            PHImageManager *manager = [PHImageManager defaultManager];
            [manager requestAVAssetForVideo:avassets options:options resultHandler:^(AVAsset * _Nullable asset, AVAudioMix * _Nullable audioMix, NSDictionary * _Nullable info) {
                [videoAssetsArray addObject:asset];
                dispatch_group_leave(group);
            }];
        });
    }
    dispatch_group_notify(group, queue, ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            if (videoAssetsArray.count == 1) {
                weakSelf.videoAssets = videoAssetsArray.firstObject;
            }
            if (completion) {
                completion(videoAssetsArray);
            }
        });
    });
}

@end
