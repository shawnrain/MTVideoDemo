//
//  YLGradientProgressView.m
//  KwaiUp
//
//  Created by melon on 2018/1/28.
//  Copyright © 2018年 melon. All rights reserved.
//

#import "YLGradientProgressView.h"

#define YLRGBColor(R,G,B) [UIColor colorWithRed:(R)/255.0 green:(G)/255.0 blue:(B)/255.0 alpha:1]
@interface  YLGradientProgressView ()

@property (nonatomic, strong) CAGradientLayer *gradientLayer;

@end
@implementation YLGradientProgressView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = YLRGBColor(237, 237, 237);
        [self configUI];
    }
    return self;
}

- (void)configUI
{
    self.colorArr = @[(id)YLRGBColor(252, 244, 77).CGColor,(id)HEXCOLOR(0xff7751).CGColor];
    [self.layer addSublayer:self.gradientLayer];
}
- (void)updateView
{
    [self layoutSubviews];
}
#pragma mark -
#pragma mark - Setter
- (void)setProgress:(CGFloat)progress
{
    _progress = progress;
    [self updateView];
}
- (void)setColorArr:(NSArray *)colorArr
{
    _colorArr = colorArr;
   self.gradientLayer.colors = colorArr;
}
#pragma mark - Getter
- (CAGradientLayer *)gradientLayer
{
    if (!_gradientLayer) {
        _gradientLayer = [CAGradientLayer layer];
        _gradientLayer.startPoint = CGPointMake(0, 0);
        _gradientLayer.endPoint = CGPointMake(1, 0);
        _gradientLayer.anchorPoint = CGPointMake(0, 0);
        NSArray *colorArr = self.colorArr;
        _gradientLayer.colors = colorArr;
    }
    return _gradientLayer;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    if (self.progress >1) {
        self.progress = 1;
    }
    self.gradientLayer.bounds = CGRectMake(0, 0, self.frame.size.width * self.progress, self.frame.size.height);
    self.layer.cornerRadius = self.frame.size.height / 2.;
    self.gradientLayer.cornerRadius = self.frame.size.height / 2.;
}

@end
