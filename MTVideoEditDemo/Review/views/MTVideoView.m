//
//  MTVideoView.m
//  MTVideoEditDemo
//
//  Created by MTShawn on 2018/7/27.
//  Copyright © 2018年 MT. All rights reserved.
//

#import "MTVideoView.h"

@interface MTVideoView()
@property (strong, nonatomic)AVPlayer *player;//播放器
@property (strong, nonatomic)AVPlayerItem *playerItem;//播放单元
@end

@implementation MTVideoView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self configure];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configure];
    }
    return self;
}
- (void)configure{
    self.backgroundColor = [UIColor whiteColor];
}
- (void)setLAVsset:(AVAsset *)lAVsset{
    _lAVsset = lAVsset;
    [self configurePlayerItem:lAVsset];
}
- (void)configurePlayerItem:(AVAsset *)avsset{
    _playerItem = [[AVPlayerItem alloc] initWithAsset:avsset];
    [self configurePlayer];
}
- (void)setAvPlayerUrl:(NSString *)avPlayerUrl{
    if (!avPlayerUrl || [avPlayerUrl isEqual:[NSNull null]]) {
        return;
    }
    _avPlayerUrl = avPlayerUrl;
    _playerItem = [[AVPlayerItem alloc] initWithURL:[NSURL URLWithString:avPlayerUrl]];
    [self configurePlayer];
}
- (void)configurePlayer{
    if (!_player) {
        _player = [AVPlayer playerWithPlayerItem:_playerItem];
        AVPlayerLayer *playerLayer = [AVPlayerLayer playerLayerWithPlayer:_player];
        playerLayer.frame = self.bounds;
        playerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
        [self.layer addSublayer:playerLayer];
    }else{
        [_player replaceCurrentItemWithPlayerItem:_playerItem];
    }
    [_player play];
}



@end
