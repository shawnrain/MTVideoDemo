//
//  YLLapmView.m
//  KwaiUp
//
//  Created by melon on 2018/1/4.
//  Copyright © 2018年 melon. All rights reserved.
//

#import "YLLapmView.h"
#import "TXScrollLabelView/TXScrollLabelView.h"
@interface  YLLapmView ()

@property (nonatomic, strong) TXScrollLabelView *scrollLabelView;
@property (nonatomic,strong) UIImageView *speakerImageView;

@end
@implementation YLLapmView
- (UIImageView *)speakerImageView
{
    if (!_speakerImageView) {
        _speakerImageView= [[UIImageView alloc]init];
        _speakerImageView.image = [UIImage imageNamed:@"喇叭"];
        _speakerImageView.contentMode = UIViewContentModeScaleToFill;
        
    }
    return _speakerImageView;
}
- (TXScrollLabelView *)scrollLabelView
{
    if(!_scrollLabelView){
        _scrollLabelView = [TXScrollLabelView scrollWithTextArray:_array type:TXScrollLabelViewTypeLeftRight velocity:0.5 options:UIViewAnimationOptionCurveEaseInOut inset:UIEdgeInsetsZero];
        _scrollLabelView.backgroundColor = [UIColor whiteColor];
        _scrollLabelView.font = [UIFont systemFontOfSize:14];
        _scrollLabelView.scrollTitleColor = [UIColor blackColor];
        _scrollLabelView.scrollSpace = 0;
        //        _scrollLabelView.scrollSpace = 0;
        [_scrollLabelView beginScrolling];
        
        [self addSubview:_scrollLabelView];
        
    }
    return _scrollLabelView;
}
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.clipsToBounds = YES;
        self.backgroundColor = [UIColor whiteColor];
        [self addSubviews];
    }
    return self;
}
- (void)addSubviews
{
    [self addSubview:self.speakerImageView];
}
- (void)awakeFromNib
{
    [super awakeFromNib];
    [self addSubviews];
}
- (void)setTitleColor:(UIColor *)titleColor
{
    _titleColor = titleColor;
    self.scrollLabelView.scrollTitleColor = titleColor;
}
- (void)setArray:(NSArray *)array
{
    _array = array;
    self.scrollLabelView.backgroundColor = [UIColor clearColor];
    
}
- (void)setName:(NSString *)name
{
    _name = name;
    self.speakerImageView.image = [UIImage imageNamed:name];
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    UIImage *image = nil;
    if (self.name) {
        image = [UIImage imageNamed:self.name];
    }else{
        image = [UIImage imageNamed:@"喇叭"];
    }
    self.speakerImageView.frame = CGRectMake(15, (self.height-image.size.height)/2, image.size.width, image.size.height);
    if (_scrollLabelView) {
        _scrollLabelView.frame = CGRectMake(self.speakerImageView.right+20,0,self.width  - self.speakerImageView.right-20-15, self.height);
    }
    
}
@end
