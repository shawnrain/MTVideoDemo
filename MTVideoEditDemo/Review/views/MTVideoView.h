//
//  MTVideoView.h
//  MTVideoEditDemo
//
//  Created by MTShawn on 2018/7/27.
//  Copyright © 2018年 MT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MTWaterView.h"
@interface MTVideoView : UIView

@property (nonatomic, assign) NSString  * avPlayerUrl;
@property (nonatomic, strong) AVAsset  * lAVsset;
@end
