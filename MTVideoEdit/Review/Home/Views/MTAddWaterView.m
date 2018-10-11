//
//  MTAddWaterView.m
//  MTVideoEdit
//
//  Created by MTShawn on 2018/9/19.
//  Copyright © 2018年 MT. All rights reserved.
//

#import "MTAddWaterView.h"
#import "UITextView+JKPlaceHolder.h"
@interface MTAddWaterView()
@property (nonatomic, strong) UITextView   * textView;
@end

@implementation MTAddWaterView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.bounds = CGRectMake(0, 0, 255, 200);
        self.layer.cornerRadius = 6.0;
        self.layer.masksToBounds = YES;
        self.backgroundColor = colorFFFFFF;
        [self configureUI];
    }
    return self;
}
- (void)configureUI{
    UIButton * sureButton = [YLUI buttonWithTitle:@"添加" titleColor:colorFFFFFF fontSize:16 backgroundColor:colorFF687F Target:self action:@selector(buttonSelected:)];
    sureButton.tag = 8546;
    UIButton * cancelBtn = [YLUI buttonWithTitle:@"取消" titleColor:color353535 fontSize:16 backgroundColor:colorDDDDDD Target:self action:@selector(buttonSelected:)];
    sureButton.layer.cornerRadius = 6.0;
    sureButton.layer.masksToBounds = YES;
    cancelBtn.layer.cornerRadius = 6.0;
    cancelBtn.layer.masksToBounds = YES;
    [self addSubview:sureButton];
    [self addSubview:cancelBtn];
    [sureButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(@15);make.bottom.equalTo(@-15);
        make.height.equalTo(@38);
    }];
    [cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(sureButton.mas_trailing).offset(25);
        make.bottom.equalTo(@-15);make.height.equalTo(@38);
        make.width.mas_equalTo(sureButton.mas_width);
        make.trailing.equalTo(@-15);
    }];
    UITextView * textView = [[UITextView alloc] initWithFrame:CGRectZero];
    _textView = textView;
    [textView jk_addPlaceHolder:@"请输入内容"];
    [self addSubview:textView];
    [textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@12);
        make.leading.equalTo(@15);make.trailing.equalTo(@-15);
        make.height.equalTo(@112);
    }];
}
- (void)setContent:(NSString *)content{
    _content = content;
    if (content.length != 0) {
        self.textView.text = content;
        self.textView.jk_placeHolderTextView.hidden = YES;
    }
}
- (void)buttonSelected:(UIButton *)lBtn{
    if (lBtn.tag == 8546 && self.textView.text.length == 0) {
        [MHHUD showMessage:@"请输入文字"];
        return;
    }
    BOOL save = lBtn.tag == 8546;
    if (self.btnSelected) {
        self.btnSelected(save,self.textView.text);
    }
    
}
@end
@interface MTVideoMaskView ()
@property (nonatomic, strong) UILabel  * contentLabel;
@end
@implementation MTVideoMaskView
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.centerY.equalTo(self);
            make.width.equalTo(@(kScreenWidth - 150));
        }];
    }
    return self;
}
- (UILabel *)contentLabel{
    if (!_contentLabel) {
        _contentLabel = [YLUI labelWithTextColor:colorFFFFFF numberOfLines:0 text:@"点击输入水印文字" fontSize:16];
        [self addSubview:_contentLabel];
        _contentLabel.userInteractionEnabled = YES;
        _contentLabel.textAlignment = NSTextAlignmentCenter;
        [_contentLabel sizeToFit];
        [_contentLabel addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(contentLabelTapOn)]];
    }
    return _contentLabel;
}
- (void)setContent:(NSString *)content{
    _content = content;
    self.contentLabel.text = content;
}
- (void)contentLabelTapOn{
    NSString *lStr = self.contentLabel.text;
    if ([lStr isEqualToString:@"点击输入水印文字"]) {
        lStr = @"";
    }
    if (self.labelTapOn) {
        self.labelTapOn(lStr);
    }
}
@end
