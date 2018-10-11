//
//  GFAVPlayerView.m
//  GFAPP
//
//  Created by XinKun on 2017/12/5.
//  Copyright © 2017年 North_feng. All rights reserved.
//

#import "GFAVPlayerView.h"
//引入视频框架
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>
@interface GFAVPlayerView (){
    id _playTimeObserver;
}
@end
@implementation GFAVPlayerView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createViewsWithFrame:frame];
        //监听程序进入后台
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationWillResignActive:)name:UIApplicationWillResignActiveNotification object:nil];
        
        //监听播放结束
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(moviePlayDidEnd:) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
    }
    return self;
}
- (void)pause{
    if (_player) {
        [_player pause];
    }
}
- (void)play{
    if (_player) {
        [_player play];
    }
}
#pragma mark - 监听视频进行状态处理
//程序进入后台
- (void)applicationWillResignActive:(NSNotification *)notification {
    [self pause];//暂停播放
}
//视频播放完毕
-(void)moviePlayDidEnd:(NSNotification *)notification
{
    NSLog(@"视频播放完毕！");
    //暂停
    [self pause];
    CMTime dur = _player.currentItem.duration;
    [_player seekToTime:CMTimeMultiplyByFloat64(dur, 0.)];
    if ([self.delegate respondsToSelector:@selector(videoPlayDidEnd)]) {
        [self.delegate videoPlayDidEnd];
    }
}

#pragma mark - 控制播放速率
- (void)changPlayerRateFloat:(float)rate{
    _player.rate = rate;
}
#pragma mark - AVPlayer的创建
- (void)playWithAsset:(AVAsset *)asset{
    //加载视频资源的类
    //AVURLAsset 通过tracks关键字会将资源异步加载在程序的一个临时内存缓冲区中
    [asset loadValuesAsynchronouslyForKeys:[NSArray arrayWithObject:@"tracks"] completionHandler:^{
        //能够得到资源被加载的状态
        AVKeyValueStatus status = [asset statusOfValueForKey:@"tracks" error:nil];
        if (status == AVKeyValueStatusLoaded) {
            GFAVPlayerItem *item = [GFAVPlayerItem playerItemWithAsset:asset];
            item.observer = self;
            //观察播放状态
            [item addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
            if (self->_player) {
                [self->_player removeTimeObserver:self->_playTimeObserver];
                [self->_player replaceCurrentItemWithPlayerItem:item];
            }else {
                self->_player = [[AVPlayer alloc] initWithPlayerItem:item];
            }
            //需要时时显示播放的进度
            //根据播放的帧数、速率，进行时间的异步(在子线程中完成)获取
            __weak AVPlayer *weakPlayer     = self->_player;
            __weak typeof(self) weakSelf    = self;
            //开始监听(这里面不断进行回调)---->返回的是这个函数的观察者，播放器销毁的时候要移除这个观察者
            self->_playTimeObserver = [self->_player addPeriodicTimeObserverForInterval:CMTimeMake(1.0, 1.0) queue:dispatch_get_main_queue() usingBlock:^(CMTime time) {
                //获取当前播放时间
                NSInteger current = CMTimeGetSeconds(weakPlayer.currentItem.currentTime);
                if (weakSelf.currentPlayTime) {
                    weakSelf.currentPlayTime(current);
                }
            }];
        }else if (status == AVKeyValueStatusFailed){
            NSLog(@"加载失败");
        }
    }];
}
#pragma mark - 相关监听（播放状态——>设置播放图层 && 缓存进度 && 缓存加载状态）
- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary<NSString *,id> *)change
                       context:(void *)context {
    if ([object isKindOfClass:[AVPlayerItem class]]) {
        AVPlayerItem *item = (AVPlayerItem *)object;
        if ([keyPath isEqualToString:@"status"]) {
            NSLog(@"监测播放状态");
            switch (item.status) {
                case AVPlayerStatusReadyToPlay:{
                    [self setPlayer:_player];
                    [self play];
                    NSInteger total = CMTimeGetSeconds(item.duration);
                    if (self.videoStartPlay) {
                        self.videoStartPlay(total);
                    }
                }break;
                case AVPlayerStatusFailed:{
                    [self pause];
                }break;
                case AVPlayerStatusUnknown:{
                }break;
                default:
                    break;
            }
            
        }
    }
}

//每个视图都对应一个层，改变视图的形状、动画效果\与播放器的关联等，都可以在层上操作
- (void)setPlayer:(AVPlayer *)myPlayer{
    AVPlayerLayer *playerLayer = (AVPlayerLayer *)self.layer;
//    playerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    [playerLayer setPlayer:myPlayer];
}
//在调用视图的layer时，会自动触发layerClass方法，重写它，保证返回的类型是AVPlayerLayer
+ (Class)layerClass
{
    return [AVPlayerLayer class];
}
#pragma mark - 创建视图
//创建相关UI
-(void)createViewsWithFrame:(CGRect)frame{
    self.backgroundColor=[UIColor blackColor];
}
#pragma mark - 播放器销毁  记得移除相关Item
- (void)dealloc{
    NSLog(@"playerView释放了,无内存泄漏");
    //移除注册的观察者
    [_player removeTimeObserver:_playTimeObserver];
    [_player.currentItem removeObserver:self forKeyPath:@"status"];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [_player cancelPendingPrerolls];
    [_player replaceCurrentItemWithPlayerItem:nil];
    _player = nil;
}
@end
@implementation GFAVPlayerItem

//实现kvo自动释放
- (void)dealloc {
    if (self.observer) {
        [self removeObserver:self.observer forKeyPath:@"status"];
    }
}

@end
