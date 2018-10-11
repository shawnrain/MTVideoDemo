//
//  LoadView.m
//  QzoneUp
//
//  Created by fuguangxin on 16/8/30.
//  Copyright © 2016年 fuguangxin. All rights reserved.
//

#import "LoadView.h"

@interface LoadView()

@property (nonatomic, strong) UIView *loadingView;
@property (nonatomic, strong) UILabel *loadingLabel;
@property (nonatomic, strong) UIImageView *loadImageView;

@property (nonatomic, strong) UIView *errorView;
@property (nonatomic, strong) UILabel *errorLabel;
@property (nonatomic, strong) UIImageView *errorImageView;
@end


@implementation LoadView

#pragma mark - life cycle

- (instancetype)init{
    self = [super init];
    if (self) {
        self.backgroundColor = HEXCOLOR(0xf6f6f6);
        [self loadSubView];
        [self layoutSubView];
    }
    return self;
}

- (void)loadSubView{
    [self addSubview:self.loadingView];
    [self.loadingView addSubview:self.loadingLabel];
    [self.loadingView addSubview:self.loadImageView];
    
    [self addSubview:self.errorView];
    [self.errorView addSubview:self.errorLabel];
    [self.errorView addSubview:self.errorImageView];
}

- (void)layoutSubView{
    [self.loadingView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    

    [self.loadImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.loadingView);
        make.size.mas_equalTo(CGSizeMake(65, 65));
    }];
    
    [self.loadingLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.loadImageView.mas_bottom).offset(10);
        make.centerX.equalTo(self.loadingView.mas_centerX);
        make.size.mas_greaterThanOrEqualTo(CGSizeZero);
    }];
    
    
    [self.errorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    
    [self.errorImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.errorView);
//        make.centerX.equalTo(self);
//        make.centerY.equalTo(self.loadingView.mas_centerY).offset(-(kNaviBarHeight));
        make.size.mas_equalTo(CGSizeMake(212, 186));
    }];
    
    [self.errorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.errorImageView.mas_bottom).offset(10);
        make.centerX.equalTo(self.errorView.mas_centerX);
        make.size.mas_greaterThanOrEqualTo(CGSizeZero);
    }];
}

#pragma mark - public method

- (void)showLoading{
    self.loadingView.hidden = NO;
    self.errorView.hidden = YES;
    self.hidden = NO;
    if(self.superview){
        [self.superview bringSubviewToFront:self];
    }
}

- (void)showFailed{
    self.loadingView.hidden = YES;
    self.errorView.hidden = NO;
    self.hidden = NO;
    if(self.superview){
        [self.superview bringSubviewToFront:self];
    }
}


- (void)dismiss{
    self.hidden = YES;
}

#pragma mark - response event

- (void)clickAction{
    if ([self.delegate respondsToSelector:@selector(loadViewRequestButtonBeClicked:)]) {
        [self.delegate loadViewRequestButtonBeClicked:self];
    }
}



#pragma mark - getter setter
- (UIView *)loadingView
{
    if (!_loadingView) {
        _loadingView = [UIView new];
        
    }
    return _loadingView;
}

- (UILabel *)loadingLabel
{
    if (!_loadingLabel) {
        UILabel* label = [[UILabel alloc]init];
        label.backgroundColor = [UIColor clearColor];
        label.textColor = HEXCOLOR(0xcccccc);
        label.font = [UIFont systemFontOfSize:14];
        label.text = @"正在努力加载中，请稍后...";
        _loadingLabel = label;
    }
    return _loadingLabel;
}

- (UIImageView *)loadImageView
{
    if (!_loadImageView) {
        UIImageView *imageView = [[UIImageView alloc]init];
        imageView.animationImages = @[[UIImage imageNamed:@"加载1"],[UIImage imageNamed:@"加载2"],[UIImage imageNamed:@"加载3"],[UIImage imageNamed:@"加载4"]];
        imageView.contentMode = UIViewContentModeScaleToFill;
        imageView.animationDuration = 0.45;//设置动画时间
        imageView.animationRepeatCount = 0;//设置动画次数 0 表示无限
        [imageView startAnimating];//开始播放动画
        _loadImageView = imageView;
    }
    return _loadImageView;
}


- (UIView *)errorView
{
    if (!_errorView) {
        _errorView = [UIView new];
        _errorView.hidden = YES;
        [_errorView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickAction)]];
        
    }
    return _errorView;
}

- (UILabel *)errorLabel
{
    if (!_errorLabel) {
        UILabel* label = [[UILabel alloc]init];
        label.backgroundColor = [UIColor clearColor];
        label.textColor = HEXCOLOR(0xcccccc);
        label.numberOfLines = 0;
        label.font = [UIFont systemFontOfSize:14];
        label.textAlignment = NSTextAlignmentCenter;
        label.text = @"点击屏幕重新加载";
        
        _errorLabel = label;
    }
    return _errorLabel;
}

- (UIImageView *)errorImageView
{
    if (!_errorImageView) {
        UIImageView *imageView = [[UIImageView alloc]init];
        imageView.image = [UIImage imageNamed:@"无网络_img"];
        imageView.contentMode = UIViewContentModeScaleToFill;
        
        _errorImageView = imageView;
    }
    return _errorImageView;
}




@end
