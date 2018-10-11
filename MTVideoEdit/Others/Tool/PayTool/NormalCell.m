//
//  NormalCell.m
//  New_QzoneUp
//
//  Created by 张有为 on 2017/5/8.
//  Copyright © 2017年 zyw113. All rights reserved.
//

#import "NormalCell.h"

@interface NormalCell()

@end


@implementation NormalCell

#pragma mark - life cycle

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self loadSubView];
        [self addConstraints];
    }
    return self;
}

- (void)loadSubView{
    [self.contentView addSubview:self.mainLabel];
    [self.contentView addSubview:self.subLabel];
    [self.contentView addSubview:self.leftImageView];
    [self.contentView addSubview:self.rightImageView];
    [self.contentView addSubview:self.arrowImageView];
    [self.contentView addSubview:self.bottomLine];
}

- (void)addConstraints{
    [self.leftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(15);
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(20, 20));
    }];
    
    [self.mainLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.left.equalTo(self.leftImageView.mas_right).offset(10);
        make.width.mas_greaterThanOrEqualTo(0);
    }];
    
    [self.arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.right.equalTo(self.contentView.mas_right).offset(-14);
        make.size.mas_equalTo(CGSizeMake(7, 10));
    }];
    
    [self.rightImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.arrowImageView.mas_left).offset(-10);
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(40, 40));
    }];
    [self.mainLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    
    [self.subLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.greaterThanOrEqualTo(self.mainLabel.mas_right).offset(10);
        make.right.equalTo(self.arrowImageView.mas_left).offset(-10);
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.size.mas_greaterThanOrEqualTo(CGSizeZero);
    }];
    
    [self.bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(15);
        make.bottom.equalTo(self.contentView.mas_bottom);
        make.right.equalTo(self.contentView.mas_right);
        make.height.mas_equalTo(0.5);
    }];
}

#pragma mark - public method

- (void)setMainTitle:(NSString *)mainTitle subTitle:(NSString *)subTitle leftImagePath:(NSString *)leftImagePath rightImagePath:(NSString *)rightImagePath showArrow:(BOOL)showArrow{
    self.mainLabel.text = mainTitle;
    self.subLabel.text = subTitle;
    if (rightImagePath.length > 0) {
        if ([rightImagePath hasPrefix:@"http"]) {
            [self.rightImageView sd_setImageWithURL:[NSURL URLWithString:rightImagePath]];
        }else{
            self.rightImageView.image = [UIImage imageNamed:rightImagePath];
        }
    }else{
        self.rightImageView.image = nil;
    }
    
    if (leftImagePath.length > 0) {
        [self.leftImageView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_left).offset(15);
            make.size.mas_equalTo(CGSizeMake(20, 20));
        }];
        if ([leftImagePath hasPrefix:@"http"]){
            [self.leftImageView sd_setImageWithURL:[NSURL URLWithString:leftImagePath]];
        }else{
            self.leftImageView.image = [UIImage imageNamed:leftImagePath];
        }
    }else{
        [self.leftImageView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_left).offset(5);
            make.size.mas_equalTo(CGSizeZero);
        }];
        self.leftImageView.image = nil;
    }
    
    self.arrowImageView.hidden = !showArrow;
    if (showArrow) {
        [self.arrowImageView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView.mas_centerY);
            make.right.equalTo(self.contentView.mas_right).offset(-15);
            make.size.mas_equalTo(CGSizeMake(8, 14));
        }];
    }else{
        [self.arrowImageView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView.mas_centerY);
            make.right.equalTo(self.contentView.mas_right).offset(-5);
            make.size.mas_equalTo(CGSizeMake(0, 0));
        }];
    }
    
}

- (void)showBottomLine:(BOOL)show{
    self.bottomLine.hidden = !show;
}


- (void)setWithDic:(NSDictionary *)dic{
    [self setMainTitle:dic[@"title"] subTitle:nil leftImagePath:dic[@"image"] rightImagePath:nil  showArrow:YES];
}


#pragma mark - getter setter

- (UILabel *)mainLabel
{
    if (!_mainLabel) {
        UILabel* label = [[UILabel alloc]init];
        label.backgroundColor = [UIColor clearColor];
        label.textColor = HEXCOLOR(0x545454);
        label.font = [UIFont systemFontOfSize:15];
        
        
        _mainLabel = label;
    }
    return _mainLabel;
}


- (UILabel *)subLabel
{
    if (!_subLabel) {
        UILabel* label = [[UILabel alloc]init];
        label.backgroundColor = [UIColor clearColor];
        label.textColor = HEXCOLOR(0x545454);
        label.font = [UIFont systemFontOfSize:15];
        
        
        
        _subLabel = label;
    }
    return _subLabel;
}

- (UIImageView *)leftImageView
{
    if (!_leftImageView) {
        UIImageView *imageView = [[UIImageView alloc]init];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        imageView.layer.cornerRadius = 15;
        
        
        _leftImageView = imageView;
    }
    return _leftImageView;
}


- (UIImageView *)rightImageView
{
    if (!_rightImageView) {
        UIImageView *imageView = [[UIImageView alloc]init];
        imageView.contentMode = UIViewContentModeScaleToFill;
        imageView.layer.cornerRadius = 20;
        imageView.layer.masksToBounds = YES;
        
        _rightImageView = imageView;
    }
    return _rightImageView;
}

- (UIImageView *)arrowImageView
{
    if (!_arrowImageView) {
        UIImageView *imageView = [[UIImageView alloc]init];
        imageView.image = [UIImage imageNamed:@"Arrow_right_gary"];
        imageView.contentMode = UIViewContentModeScaleToFill;
        
        
        _arrowImageView = imageView;
    }
    return _arrowImageView;
}


- (UIView *)bottomLine
{
    if (!_bottomLine) {
        _bottomLine = [UIView new];
        _bottomLine.backgroundColor = HEXCOLOR(0xebebeb);
    }
    return _bottomLine;
}


@end
