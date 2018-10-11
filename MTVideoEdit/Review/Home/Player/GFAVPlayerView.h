//
//  GFAVPlayerView.h
//  GFAPP
//  视频播放器
//  Created by XinKun on 2017/12/5.
//  Copyright © 2017年 North_feng. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol GFAVPlayerViewDelegate <NSObject>
@optional
- (void)videoPlayDidEnd;
@end
@interface GFAVPlayerView : UIView
@property (nonatomic, strong) AVPlayer *player;
/**
 播放视屏
 */
- (void)playWithAsset:(AVAsset *)asset;

/**
 开始视屏
 */
- (void)play;

/**
 暂停视屏
 */
- (void)pause;

/**
 控制播放速率
 */
- (void)changPlayerRateFloat:(float)rate;
@property (nonatomic, copy) void(^currentPlayTime)(NSInteger time);
@property (nonatomic, copy) void(^videoStartPlay)(NSInteger totalTime);
@property (nonatomic, weak) id<GFAVPlayerViewDelegate>  delegate;
@end
@interface GFAVPlayerItem : AVPlayerItem

@property (nonatomic, weak) id observer;

@end
