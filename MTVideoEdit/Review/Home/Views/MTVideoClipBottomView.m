//
//  MTVideoClipBottomView.m
//  MTVideoEdit
//
//  Created by MTShawn on 2018/9/18.
//  Copyright © 2018年 MT. All rights reserved.
//

#import "MTVideoClipBottomView.h"
#import "MHHUD.h"
@interface MTVideoClipBottomView ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *startTextField;
@property (weak, nonatomic) IBOutlet UITextField *endTextField;
@property (weak, nonatomic) IBOutlet UIButton *clipBtn;
@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;
@property (nonatomic, assign) NSInteger  startClip;
@property (nonatomic, assign) NSInteger  endClip;
@end

@implementation MTVideoClipBottomView
- (void)awakeFromNib{
    [super awakeFromNib];
    self.startTextField.textColor = colorFF657C;
    self.startTextField.delegate = self;
    self.endTextField.textColor = colorFF657C;
    self.endTextField.delegate = self;
    [self.clipBtn setTitleColor:colorFFFFFF forState:UIControlStateNormal];
    self.clipBtn.backgroundColor = colorFF687F;
    self.clipBtn.layer.cornerRadius = 6.0;
    self.clipBtn.layer.masksToBounds = YES;
    
    [self.cancelBtn setTitleColor:color353535 forState:UIControlStateNormal];
    self.cancelBtn.backgroundColor = colorDDDDDD;
    self.cancelBtn.layer.cornerRadius = 6.0;
    self.cancelBtn.layer.masksToBounds = YES;
    self.startClip = 0;
    self.endClip = 0;
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    if ([textField isEqual:self.startTextField]) {
        self.startClip = [textField.text integerValue];
        self.startTextField.text = [self getTime:self.startClip];
    }
    if ([textField isEqual:self.endTextField]) {
        self.endClip = [textField.text integerValue];
        self.endTextField.text = [self getTime:self.endClip];
    }
}
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    if ([textField isEqual:self.startTextField]) {
        self.startTextField.text = [NSString stringWithFormat:@"%ld",self.startClip];
    }
    if ([textField isEqual:self.endTextField]) {
        self.endTextField.text = [NSString stringWithFormat:@"%ld",self.endClip];
    }
}

//将秒数换算成具体时长
- (NSString *)getTime:(NSInteger)second
{
    NSString *time;
    if (second < 3600) {
        time = [NSString stringWithFormat:@"%02ld:%02ld",(long)second/60,(long)second%60];
    }else {
        time = [NSString stringWithFormat:@"%02ld:%02ld:%02ld",(long)second/3600,(long)(second-second/3600*3600)/60,(long)second%60];
    }
    return time;
}

- (IBAction)clipBtnSelected:(id)sender {
    if (self.endClip == 0) {
        [MHHUD showMessage:@"请选择结束时间"];
        return;
    }
    if (self.startClip >= self.endClip) {
        [MHHUD showMessage:@"剪辑的起始时间应大于结束时间"];
        return;
    }
    NSInteger seconds = self.asset.duration.value / self.asset.duration.timescale;
    if (self.startClip > seconds || self.endClip > seconds) {
        [MHHUD showMessage:@"剪辑时间应小于视频时长"];
        return;
    }
    if (self.clipBtnCallBack) {
        self.clipBtnCallBack(self.startClip,self.endClip);
    }
}
@end
