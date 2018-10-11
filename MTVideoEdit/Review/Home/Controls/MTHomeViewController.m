//
//  MTHomeViewController.m
//  MTVideoEdit
//
//  Created by MTShawn on 2018/9/17.
//  Copyright © 2018年 MT. All rights reserved.
//

#import "MTHomeViewController.h"
#import "MTChooseVideoViewController.h"
@interface MTHomeViewController ()
@property (nonatomic, strong) UIImageView  * banarView;
@end

@implementation MTHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"首页";
    UIImageView * lBGImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"review_bg"]];
    [self.view addSubview:lBGImage];
    [lBGImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];
    
    UIImageView * banarView = [YLUI imageViewWithName:@"review_banar"];
    [self.view addSubview:banarView];
    [banarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(kNaviBarHeight + 15));
        make.leading.equalTo(@15);
        make.trailing.equalTo(@-15);
        make.height.equalTo(@160);
    }];
    
    UIImageView * clipImageView = [YLUI imageViewWithName:@"视频剪辑"];
    clipImageView.tag = MTVideoOperateTypeClip;
    [self.view addSubview:clipImageView];
    
    UIImageView * addWater = [YLUI imageViewWithName:@"添加文字"];
    addWater.tag = MTVideoOperateTypeAddWaterImg;
    [self.view addSubview:addWater];
    
    UIImageView *videoToImgs = [YLUI imageViewWithName:@"视频转图片"];
    videoToImgs.tag = MTVideoOperateTypeVideoToImg;
    [self.view addSubview:videoToImgs];
    
    UIImageView *transformImg = [YLUI imageViewWithName:@"视频旋转"];
    transformImg.tag = MTVideoOperateTypeTransform;
    [self.view addSubview:transformImg];
    
    NSArray * lImageArray = @[clipImageView,addWater,videoToImgs,transformImg];
    [self imageAddGesture:lImageArray];
    
    [clipImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(banarView.mas_bottom).offset(23);
        make.leading.equalTo(@15);
        make.height.equalTo(@123);
    }];
    
    [addWater mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(@-15);
        make.width.mas_equalTo(clipImageView.mas_width).offset(0);
        make.top.mas_equalTo(clipImageView.mas_top).offset(0);
        make.height.mas_equalTo(clipImageView.mas_height).offset(0);
        make.leading.mas_equalTo(clipImageView.mas_trailing).offset(15);
    }];
    
    [videoToImgs mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(@15);
        make.width.mas_equalTo(clipImageView.mas_width).offset(0);
        make.top.mas_equalTo(clipImageView.mas_bottom).offset(22);
        make.height.mas_equalTo(clipImageView.mas_height).offset(0);
    }];
    
    [transformImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(@-15);
        make.width.mas_equalTo(clipImageView.mas_width).offset(0);
        make.top.mas_equalTo(videoToImgs.mas_top).offset(0);
        make.height.mas_equalTo(clipImageView.mas_height).offset(0);
        make.leading.mas_equalTo(addWater.mas_leading).offset(0);
    }];
}
- (void)imageAddGesture:(NSArray <UIImageView *>*)imageArray{
    for (UIImageView * imageView in imageArray) {
        imageView.userInteractionEnabled = YES;
        [imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageTapOn:)]];
    }
}
- (void)imageTapOn:(UITapGestureRecognizer *)gesture{
    UIImageView * imageView = (UIImageView *)gesture.view;
    MTChooseVideoViewController * lView = [[MTChooseVideoViewController alloc] init];
    lView.operateType = imageView.tag;
    [self.navigationController pushViewController:lView animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
@end
