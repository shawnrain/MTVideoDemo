//
//  MTMineTableHeaderView.m
//  MTVideoEdit
//
//  Created by MTShawn on 2018/9/19.
//  Copyright © 2018年 MT. All rights reserved.
//

#import "MTMineTableHeaderView.h"

@interface MTMineTableHeaderView ()

@end

@implementation MTMineTableHeaderView
- (void)awakeFromNib{
    [super awakeFromNib];
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self configureUI];
    }
    return self;
}
- (void)configureUI{
    UIImageView * bgImage = [YLUI imageViewWithName:@"个人中心背景"];
    [self addSubview:bgImage];
    [bgImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.and.trailing.and.top.equalTo(@0);
        make.height.equalTo(@160);
    }];
    UIImageView * userImg = [YLUI imageViewWithName:@"review_user"];
    [self addSubview:userImg];
    [userImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.width.and.height.equalTo(@56);
        make.top.equalTo(@37);
    }];
    
    UILabel * userNickLabel = [YLUI labelTextColor:colorFFFFFF fontSize:16 text:@"仙人掌刺刺"];
    UILabel * IDLabel = [YLUI labelTextColor:colorFFFFFF fontSize:11 text:@"ID：924827"];
    [self addSubview:userNickLabel];
    [self addSubview:IDLabel];
    [userNickLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(userImg.mas_bottom).offset(11);
        make.height.equalTo(@22);
        make.centerX.equalTo(self);
    }];
    [IDLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(userNickLabel.mas_bottom).offset(3);
        make.height.equalTo(@22);
        make.centerX.equalTo(self);
    }];
    
    UIView * videSetView = [self configureBtnUI:@"画质设置" image:@"设置"];
    UIView * messageView = [self configureBtnUI:@"消息通知" image:@"消息"];
    [videSetView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(@15);
        make.height.equalTo(@50);
        make.bottom.mas_equalTo(@-15);
        make.width.equalTo(@150);
    }];
    [messageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(@-15);
        make.height.equalTo(@50);
        make.trailing.equalTo(@-15);
        make.leading.mas_equalTo(videSetView.mas_trailing).offset(45);
        make.width.mas_equalTo(videSetView.mas_width);
    }];
}
- (UIView *)configureBtnUI:(NSString *)title image:(NSString *)imageName{
    UIView * lcontaintView = [[UIView alloc] init];
    lcontaintView.backgroundColor = colorFFF5EF;
    lcontaintView.layer.cornerRadius = 3.0;
    lcontaintView.layer.masksToBounds = YES;
    UILabel * label = [YLUI labelTextColor:colorFF687F fontSize:16 text:title];
    UIImageView * imageView = [YLUI imageViewWithName:imageName];
    
    UIButton *lBtn;
    if ([title isEqualToString:@"画质设置"]) {
        lBtn = [YLUI buttonWithTitle:@"" titleColor:colorFF687F fontSize:14 backgroundImage:nil Target:self action:@selector(videoSetBtn:)];
    }else{
        lBtn = [YLUI buttonWithTitle:@"" titleColor:colorFF687F fontSize:14 backgroundImage:nil Target:self action:@selector(messageBtnSelected:)];
    }
    [lcontaintView addSubview:label];
    [lcontaintView addSubview:imageView];
    [lcontaintView addSubview:lBtn];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(@15);
        make.centerY.equalTo(lcontaintView);
    }];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.and.height.equalTo(@30);
        make.centerY.equalTo(lcontaintView);
        make.trailing.equalTo(@-25);
    }];
    [lBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];
    [self addSubview:lcontaintView];
    return lcontaintView;
}


- (void)videoSetBtn:(UIButton *)sender {
    if (self.videoSetBtnSelected) {
        self.videoSetBtnSelected();
    }
}
- (void)messageBtnSelected:(UIButton *)sender {
    if (self.messageBtnSelected) {
        self.messageBtnSelected();
    }
}

@end
