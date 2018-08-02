//
//  MTVideoAddTextViewController.m
//  MTVideoEditDemo
//
//  Created by MTShawn on 2018/7/27.
//  Copyright © 2018年 MT. All rights reserved.
//

#import "MTVideoAddTextViewController.h"
#import "UIViewController+videoSave.h"
#import "UIViewController+MTVideoHelper.h"
#import "MTVideoView.h"
#import "AVUtilities.h"
#import <AssetsLibrary/AssetsLibrary.h>
@interface MTVideoAddTextViewController ()
@property (nonatomic, strong) MTVideoView  * videoView;

@end

@implementation MTVideoAddTextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self configure];   
}
- (void)configure{
    
}
- (void)setLAVsset:(PHAsset *)lAVsset{
    _lAVsset = lAVsset;
    kWeakSelf
    [self PHAVAssetArray:@[lAVsset] complemtion:^(NSMutableArray *lAVAssetArray) {
        weakSelf.videoView.lAVsset = self.videoAssets;
    }];
}
- (MTVideoView *)videoView{
    if (!_videoView) {
        _videoView = [[MTVideoView alloc] initWithFrame:CGRectMake(0, 100, 200, 200)];
        [self.view addSubview:_videoView];
    }
    return _videoView;
}

- (IBAction)capVideo:(id)sender {
    NSURL * lUrl = [self getExportVideoUrl];
    NSLog(@"======lUrl= %@",lUrl.path);
    AVAsset * asset = [AVUtilities assetByReversingAsset:self.videoAssets outputURL:lUrl];
    self.videoView.lAVsset = asset;
    //[self videoSaveWithWaterImg:nil];
}
- (IBAction)addBGAudio:(UIButton *)sender {
    NSURL * audioUrl = [NSURL fileURLWithPath:[[NSBundle mainBundle]pathForResource:@"月半弯" ofType:@"mp3"]];
    AVURLAsset * audio = [[AVURLAsset alloc] initWithURL:audioUrl options:nil];
    [self videoAddBackGroundMusic:audio captureVideoWithRange:NSMakeRange(3, 10) completion:^(AVAssetExportSessionStatus status, NSURL *videoUrl) {
        
    }];
}
- (IBAction)daofangbaocun:(UIButton *)sender {
    NSURL * lUrl = [self getExportVideoUrl];
    AVAsset * asset = [AVUtilities assetByReversingAsset:self.videoAssets outputURL:lUrl];
    self.videoView.lAVsset = asset;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
