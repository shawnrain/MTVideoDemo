//
//  MTVideoTransBottomView.m
//  MTVideoEdit
//
//  Created by MTShawn on 2018/9/19.
//  Copyright © 2018年 MT. All rights reserved.
//

#import "MTVideoTransBottomView.h"
#import "UIImage+UIImageAddition.h"
@interface MTVideoTransBottomView ()
@property (weak, nonatomic) IBOutlet UIButton *btnNinety;
@property (weak, nonatomic) IBOutlet UIButton *btn180;
@property (weak, nonatomic) IBOutlet UIButton *btn270;
@property (weak, nonatomic) IBOutlet UIButton *sureBtn;
@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;
@property (nonatomic, strong) UIButton  * selectedBtn;
@end



@implementation MTVideoTransBottomView
- (void)awakeFromNib{
    [super awakeFromNib];
    UIImage * selectedImg = [UIImage initWithColor:colorFF687F rect:CGRectMake(0, 0, 2, 2)];
    UIImage * normalImage = [UIImage initWithColor:colorEDEDED rect:CGRectMake(0, 0, 2, 2)];
    [self.sureBtn setBackgroundImage:selectedImg forState:UIControlStateNormal];
    [self.cancelBtn setBackgroundImage:normalImage forState:UIControlStateNormal];
    self.sureBtn.layer.cornerRadius = 6.0;
    self.sureBtn.layer.masksToBounds = YES;
    self.cancelBtn.layer.cornerRadius = 6.0;
    self.cancelBtn.layer.masksToBounds = YES;
    NSArray * btnArray = @[self.btnNinety,self.btn180,self.btn270];
    for (UIButton * button in btnArray) {
        [button setBackgroundImage:selectedImg forState:UIControlStateSelected];
        [button setBackgroundImage:normalImage forState:UIControlStateNormal];
        button.layer.cornerRadius = 6.0;
        button.layer.masksToBounds = YES;
    }
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (IBAction)transFormBtnSelected:(UIButton *)sender {
    self.selectedBtn.selected = false;
    sender.selected = YES;
    self.selectedBtn = sender;
    CGFloat roteAngle = 90;
    if ([sender.titleLabel.text hasPrefix:@"18"]) {
        roteAngle = 180;
    }else if ([sender.titleLabel.text hasPrefix:@"27"]){
        roteAngle = 270;
    }
    if (self.videoTransform) {
        self.videoTransform(roteAngle);
    }
}
- (IBAction)sureBtnSelected:(UIButton *)sender {
    if (!self.selectedBtn) {
        [MHHUD showMessage:@"请选择旋转的幅度"];
        return;
    }
    if (self.videoEditBtn) {
        self.videoEditBtn();
    }
}

@end
