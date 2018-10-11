//
//  MTVideoEditViewController.m
//  MTVideoEdit
//
//  Created by MTShawn on 2018/9/17.
//  Copyright © 2018年 MT. All rights reserved.
//

#import "MTVideoEditViewController.h"
#import "MTAVPlayerView.h"
#import "MTVideoClipManager.h"
#import "MTVideoAddWaterImgManager.h"
#import "MTVideoRoteManager.h"
#import "MTVideoEditToImgsManager.h"
#import "MTVideoClipBottomView.h"
#import "MTVideoTransBottomView.h"
#import "MTPopView.h"
#import "MTAddWaterView.h"
@interface MTVideoEditViewController ()
@property (nonatomic, strong) UIImage  * waterImg;//水印图片
@property (nonatomic, assign) CGFloat  rote;
@property (nonatomic, strong) MTVideoMaskView * maskView;//添加水印时 水印视图
@end

@implementation MTVideoEditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = colorEDEDED;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"return_backimg"] style:UIBarButtonItemStyleDone target:self action:@selector(backAction)];
    _rote = 0;
}
- (void)setAsset:(MTAssetsModel *)asset{
    _asset = asset;
    [self configureVideoUI];
}
- (void)setType:(MTVideoOperateType)type{
    _type = type;
    if (type == MTVideoOperateTypeClip) {
        self.navigationItem.title = @"视频剪辑";
    }else if (type == MTVideoOperateTypeAddWaterImg){
        self.navigationItem.title = @"文字添加";
    }else if (type == MTVideoOperateTypeTransform){
        self.navigationItem.title = @"旋转";
    }else if (type == MTVideoOperateTypeVideoToImg){
        self.navigationItem.title = @"视频转图片";
    }
}
- (void)configureVideoUI{
    MTAVPlayerView * videoView = [[MTAVPlayerView alloc] init];
    [videoView setVideoAssets:self.asset.AVAsset];
    [self.view addSubview:videoView];
    [videoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(kNaviBarHeight + 20));
        make.leading.equalTo(@15);
        make.trailing.equalTo(@-15);
        make.height.equalTo(@364);
    }];
    kWeakSelf
    if (_type == MTVideoOperateTypeClip) {
        MTVideoClipBottomView * bottomView = [[NSBundle mainBundle] loadNibNamed:@"MTVideoClipBottomView" owner:nil options:nil].firstObject;
        bottomView.asset = self.asset.AVAsset;
        [bottomView setClipBtnCallBack:^(NSInteger start, NSInteger endIndex) {
            [weakSelf videoClipStart:start endIndex:endIndex];
        }];
        [self.view addSubview:bottomView];
        [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(videoView.mas_bottom).offset(20);
            make.leading.equalTo(@15);make.trailing.equalTo(@-15);
            make.height.equalTo(@130);
        }];
    }
    if (_type == MTVideoOperateTypeAddWaterImg || _type == MTVideoOperateTypeVideoToImg) {
        [self configureButtonView:videoView];
    }
    
    if (_type == MTVideoOperateTypeTransform) {
        MTVideoTransBottomView * roteView = [[NSBundle mainBundle] loadNibNamed:@"MTVideoTransBottomView" owner:nil options:nil].firstObject;
        [roteView setVideoEditBtn:^{
            [weakSelf buttonSelected];
        }];
        [roteView setVideoTransform:^(CGFloat rote) {
            weakSelf.rote = rote;
        }];
        [self.view addSubview:roteView];
        [roteView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(videoView.mas_bottom).offset(20);
            make.leading.equalTo(@15);make.trailing.equalTo(@-15);
            make.height.equalTo(@130);
        }];
    }
}

/**
 显示按钮

 @param videoView videoView
 */
- (void)configureButtonView:(UIView *)videoView{
    NSString * buttonTitle = @"一键转换图片";
    if (_type == MTVideoOperateTypeAddWaterImg) {
        buttonTitle = @"保存";
        [self addMaskViewWithVideoView:videoView];
    }
    UIView * btnBGView = [[UIView alloc] initWithFrame:CGRectZero];
    btnBGView.layer.cornerRadius = 6.0;
    btnBGView.layer.masksToBounds = YES;
    btnBGView.backgroundColor = colorFFFFFF;
    UIButton * btn = [YLUI buttonWithTitle:buttonTitle titleColor:colorFFFFFF fontSize:16 backgroundColor:colorFF687F Target:self action:@selector(buttonSelected)];
    btn.layer.cornerRadius = 6.0;
    btn.layer.masksToBounds = YES;
    [btnBGView addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(@-30);
        make.leading.equalTo(@30);
        make.height.equalTo(@38);
        make.trailing.equalTo(@-30);
    }];
    [self.view addSubview:btnBGView];
    [btnBGView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(videoView.mas_bottom).offset(-12);
        make.height.equalTo(@100);
        make.leading.equalTo(@15);
        make.trailing.equalTo(@-15);
    }];
}
//添加水印视图
- (void)addMaskViewWithVideoView:(UIView *)videoView{
    _maskView = [[MTVideoMaskView alloc] init];
    _maskView.frame = CGRectMake(10, 10, KSCREENWIDTH - 50, 200);
    kWeakSelf
    [_maskView setLabelTapOn:^(NSString *lStr) {
        [weakSelf waterViewPop:lStr];
    }];
    [videoView addSubview:_maskView];
}
//水印输入弹窗
- (void)waterViewPop:(NSString *)content{
    MTAddWaterView * waterView = [[MTAddWaterView alloc] init];
    waterView.content = content;
    kWeakSelf
    [waterView setBtnSelected:^(BOOL isSave, NSString * content) {
        if (isSave) weakSelf.maskView.content = content;
        [weakSelf lew_dismissPopupView];
    }];
    [self lew_presentPopupView:waterView animation:[LewPopupViewAnimationSpring new] backgroundClickable:false];
}
- (void)buttonSelected{
    if (self.type == MTVideoOperateTypeAddWaterImg){
        [self addWaterImg];
    }else if (self.type == MTVideoOperateTypeTransform){
        [self videoTrasnform];
    }else if (self.type == MTVideoOperateTypeVideoToImg){
        [self videoToImg];
    }
}
//剪辑
- (void)videoClipStart:(NSInteger)start endIndex:(NSInteger)end{
    [self showLoadingView];
    kWeakSelf
    MTVideoClipManager * clipManager = [[MTVideoClipManager alloc] init];
    clipManager.asset = self.asset.AVAsset;
    [clipManager clipVideoStartIndex:start end:end completion:^(AVAssetExportSession *exporter) {
        [weakSelf showHintView];
    }];
}
//添加文字
- (void)addWaterImg{
    if (self.maskView.content.length == 0) {
        [MHHUD showMessage:@"请输入水印文字"];
        return;
    }
    self.waterImg = [self.maskView generateImage];
    [self showLoadingView];
    MTVideoAddWaterImgManager * manager = [[MTVideoAddWaterImgManager alloc] init];
    manager.asset = self.asset.AVAsset;
    kWeakSelf
    [manager addWaterImg:self.waterImg completion:^(AVAssetExportSession *exporter) {
        [weakSelf showHintView];
    }];
}
//视频转图片
- (void)videoToImg{
    [self showLoadingView];
    kWeakSelf
    [MTVideoEditToImgsManager videoToImgs:self.asset.AVAsset calllBack:^(BOOL success) {
        [weakSelf showHintView];
    }];
}
//旋转
- (void)videoTrasnform{
    [self showLoadingView];
    kWeakSelf
    [MTVideoRoteManager videoAsset:self.asset.AVAsset angleOfRotation:self.rote completion:^(AVAssetExportSession *exporter) {
        [weakSelf showHintView];
    }];
}
//视频处理时旋转视图
- (void)showLoadingView{
    MTPopView *popView = [MTPopView MTPopViewShowLoading];
    [self lew_presentPopupView:popView animation:[LewPopupViewAnimationSpring new] backgroundClickable:false];
}
//处理完成时保存提醒
- (void)showHintView{
    [self lew_dismissPopupView];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        MTPopView *popView = [MTPopView MTPopViewShowWithStr:@"已保存至手机"];
        [self lew_presentPopupView:popView animation:[LewPopupViewAnimationSpring new]];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self lew_dismissPopupView];
        });
    });
}
- (void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
