//
//  MTAVPlayerView.h
//  wanghong
//
//  Created by MTShawn on 2018/9/11.
//  Copyright © 2018年 MT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MTAVPlayerView : UIView
- (void)pause;
@property (nonatomic, assign) MTVideoOperateType  type;
- (void)setVideoAssets:(AVURLAsset *)asset;
- (void)setVideoAssetsUrl:(NSURL *)url;
- (void)changeRateValue:(CGFloat)rate;
@end
