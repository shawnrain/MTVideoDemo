//
//  MTAVPlayerView.m
//  wanghong
//
//  Created by MTShawn on 2018/9/11.
//  Copyright © 2018年 MT. All rights reserved.
//

#import "MTAVPlayerView.h"
#import "MTAVPlayerItem.h"
#import "GFAVPlayerView.h"
@interface MTAVPlayerView ()<GFAVPlayerViewDelegate>
@property (nonatomic, strong) GFAVPlayerView  * playView;
@property (nonatomic, assign) CGFloat  duration;
@property (nonatomic, strong) UILabel  * totalTimeLabel;
@property (nonatomic, strong) UILabel  * currentTimeLabel;
@property (nonatomic, strong) UISlider  * sliderView;
@property (nonatomic, strong) NSTimer  * timer;
@property (nonatomic, strong) UIButton  * playBtn;
@property (nonatomic, assign) BOOL  isForward;//快进
@end

@implementation MTAVPlayerView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = colorFFFFFF;
        self.layer.cornerRadius = 6.0;
        self.layer.masksToBounds = YES;
        [self configureUI];
    }
    return self;
}
- (void)changeRateValue:(CGFloat)rate{
    [self.playView.player setRate:rate];
}
- (void)setVideoAssetsUrl:(NSURL *)url{
    AVURLAsset *asset = [AVURLAsset assetWithURL:url];
    [self setVideoAssets:asset];
}
- (void)setVideoAssets:(AVURLAsset *)asset{
    kWeakSelf
    self.duration = self.duration = CMTimeGetSeconds(asset.duration);
    if (!self.playView) {
        self.playView = [[GFAVPlayerView alloc] initWithFrame:CGRectMake(10, 10, KSCREENWIDTH - 50, 200)];
        self.playView.delegate = self;
        [self.playView playWithAsset:asset];
    }else{
        [self.playView playWithAsset:asset];
    }
    [self.playView setCurrentPlayTime:^(NSInteger time) {
        float pro = time*1.0/weakSelf.duration;
        if (pro >= 0.0 && pro <= 1.0) {
            weakSelf.sliderView.value = pro;
            weakSelf.currentTimeLabel.text = [weakSelf getTime:time];
        }
    }];
    [self.playView setVideoStartPlay:^(NSInteger totalTime) {
        weakSelf.duration = totalTime;
        weakSelf.totalTimeLabel.text = [weakSelf getTime:totalTime];
        weakSelf.playBtn.selected = YES;
    }];
    [self addSubview:self.playView];
}
- (void)configureUI{
    UIButton * playBtn = [self createBtn:@"播放"];
    [playBtn setImage:[UIImage imageNamed:@"暂停"] forState:UIControlStateSelected];
    _playBtn = playBtn;
    [playBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.width.equalTo(@40);make.height.equalTo(@40);
        make.bottom.equalTo(@-89);
    }];
    
    
    UIImageView * faseForwardImg = [YLUI imageViewWithName:@"快进"];
    faseForwardImg.userInteractionEnabled = YES;
    faseForwardImg.tag = 5214;
    UIImageView * faseBackImg = [YLUI imageViewWithName:@"快退"];
    faseBackImg.userInteractionEnabled = YES;
    [faseForwardImg addGestureRecognizer:[[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPress:)]];
    [faseBackImg addGestureRecognizer:[[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPress:)]];
    [self addSubview:faseForwardImg];
    [self addSubview:faseBackImg];
    [faseBackImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.mas_equalTo(playBtn.mas_leading).offset(-40);
        make.centerY.mas_equalTo(playBtn.mas_centerY);
        make.width.equalTo(@30);
        make.height.equalTo(@30);
    }];
    [faseForwardImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(playBtn.mas_trailing).offset(40);
        make.centerY.mas_equalTo(playBtn.mas_centerY);
        make.width.equalTo(@30);
        make.height.equalTo(@30);
    }];

    _sliderView = [[UISlider alloc] init];
    _sliderView.minimumTrackTintColor = color2DC2F4;
    _sliderView.maximumTrackTintColor = colorFFFFFF;
    [_sliderView setThumbImage:[UIImage imageNamed:@"进度条圆"] forState:UIControlStateNormal];
    [_sliderView setMinimumTrackImage:[UIImage imageNamed:@"个人中心背景"] forState:UIControlStateNormal];
    [self addSubview:_sliderView];
    [_sliderView addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];
    [_sliderView addTarget:self action:@selector(slidertouchDown) forControlEvents:UIControlEventTouchDown];
    [_sliderView addTarget:self action:@selector(sliderTouchDone:) forControlEvents:UIControlEventTouchUpInside|UIControlEventTouchUpOutside|UIControlEventTouchCancel];
    [_sliderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(@25);make.trailing.equalTo(@-25);
        make.height.equalTo(@10);make.bottom.equalTo(@-53);
    }];
    _totalTimeLabel = [YLUI labelTextColor:color353535 fontSize:14 text:@"00:00"];
    _totalTimeLabel.textAlignment = NSTextAlignmentRight;
    [self addSubview:_totalTimeLabel];
    _currentTimeLabel = [YLUI labelTextColor:color353535 fontSize:14 text:@"00:00"];
    _currentTimeLabel.textAlignment = NSTextAlignmentLeft;
    [self addSubview:_currentTimeLabel];
    [_totalTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(@-28);
        make.bottom.equalTo(@-20);
        make.height.equalTo(@20);
    }];
    [_currentTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self->_totalTimeLabel.mas_centerY).offset(0);
        make.leading.equalTo(@25);
    }];
}
//快进 快退 按钮事件
- (void)longPress:(UILongPressGestureRecognizer*)gesture{
    UIImageView * imageView = (UIImageView *)gesture.view;
    _isForward = imageView.tag == 5214;
    if (gesture.state == UIGestureRecognizerStateBegan) {
        [self timer];
        [self pause];
    }else if (gesture.state == UIGestureRecognizerStateEnded || gesture.state == UIGestureRecognizerStateCancelled || gesture.state == UIGestureRecognizerStateFailed){
        [self invaliTimer];
        [self play];
    }else{
        
    }
}
//播放暂停按钮
- (UIButton *)createBtn:(NSString *)imageName{
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn addTarget:self action:@selector(buttonSelected:) forControlEvents:UIControlEventTouchUpInside];
    [btn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [self addSubview:btn];
    return btn;
}
- (void)buttonSelected:(UIButton *)sender{
    sender.selected = !sender.selected;
    if (sender.selected) {
        [self play];
    }else{
        [self pause];
    }
}
//slider相关操作
- (void)sliderValueChanged:(UISlider *)slider{
    if (self.playView.player) {
        CMTime dur = self.playView.player.currentItem.duration;
        float current = _sliderView.value;
        _currentTimeLabel.text = [self getTime:(NSInteger)(current*self.duration)];
        [self.playView.player seekToTime:CMTimeMultiplyByFloat64(dur, current)];
    }
}
- (void)slidertouchDown{
    [self pause];
}
- (void)sliderTouchDone:(UISlider *)slider{
    [self play];
}
#pragma mark - 播放和暂停
- (void)play {
    [self.playView play];
}
//暂停
- (void)pause{
    [self.playView pause];
}
#pragma mark -- GFAVPlayerViewDelegate
- (void)videoPlayDidEnd{
    self.playBtn.selected = false;
}
//将秒数换算成具体时长
- (NSString *)getTime:(NSInteger)second
{
    NSString *time;
    if (second < 3600) {
        time = [NSString stringWithFormat:@"%02ld:%02ld",(long)second/60,(long)second%60];
    }else {
        time = [NSString stringWithFormat:@"%02ld:%02ld:%02ld",(long)second/3600,(long)(second-second/3600*3600)/60,(long)second%60];
    }
    
    return time;
}
//快进 快退点击操作事件
- (NSTimer *)timer{
    if (!_timer) {
        _timer = [NSTimer timerWithTimeInterval:0.25 target:self selector:@selector(changeVideoCurrentPlay) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    }
    return _timer;
}
- (void)changeVideoCurrentPlay{
    if (self.playView.player) {
        CMTime dur = self.playView.player.currentItem.duration;
        CGFloat seconds = dur.value / dur.timescale;
        CGFloat speedProgress = 0.05;
        if (seconds <= 8) {//视频长度过小时 进度加载太慢
            speedProgress = 0.1;
        }
        float current = _sliderView.value;
        if (_isForward) {
            if (current + speedProgress < 1.0) {
                current += speedProgress;
            }else{
                [self invaliTimer];
            }
        }else{
            if (current - speedProgress > 0) {
                current -= speedProgress;
            }else{
                [self invaliTimer];
            }
        }
        _sliderView.value = current;
        _currentTimeLabel.text = [self getTime:(NSInteger)(current*self.duration)];
        [self.playView.player seekToTime:CMTimeMultiplyByFloat64(dur, current)];
    }
}
- (void)invaliTimer{
    [_timer invalidate];
    _timer = nil;
}
@end
