//
//  MTFeebackViewController.m
//  MTVideoEdit
//
//  Created by MTShawn on 2018/9/19.
//  Copyright © 2018年 MT. All rights reserved.
//

#import "MTFeebackViewController.h"
#import "UITextView+JKPlaceHolder.h"
#import "SPTextField.h"
#import "MTPopView.h"
@interface MTFeebackViewController ()
@property (weak, nonatomic) IBOutlet UITextView *lTextView;
@property (weak, nonatomic) IBOutlet SPTextField *ltextField;
@property (weak, nonatomic) IBOutlet UIButton *subMitBtn;
@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;
@property (weak, nonatomic) IBOutlet UIView *containtView;

@end

@implementation MTFeebackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"意见反馈";
    self.subMitBtn.backgroundColor = colorFF687F;
    [self.subMitBtn setTitleColor:colorFFFFFF forState:UIControlStateNormal];
    [self.cancelBtn setTitleColor:color353535 forState:UIControlStateNormal];
    self.cancelBtn.backgroundColor = colorDDDDDD;
    self.subMitBtn.layer.cornerRadius = 6.0;
    self.subMitBtn.layer.masksToBounds = YES;
    self.cancelBtn.layer.cornerRadius = 6.0;
    self.cancelBtn.layer.masksToBounds = YES;
    self.lTextView.backgroundColor = colorFFF5EF;
    self.ltextField.backgroundColor = colorFFF5EF;
    [self.lTextView jk_addPlaceHolder:@"  请输入反馈的内容"];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"return_backimg"] style:UIBarButtonItemStyleDone target:self action:@selector(backAction)];
}
- (void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)subMitBtnSelected:(UIButton *)sender {
    if (self.lTextView.text.length == 0) {
        [MHHUD showMessage:@"请输入反馈内容"];
        return;
    }
    if (self.ltextField.text.length == 0) {
        [MHHUD showMessage:@"请输入联系方式"];
        return;
    }
    [MHHUD show];
    kWeakSelf
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [MHHUD dissmiss];
        MTPopView * popView = [MTPopView MTPopViewShowWithStr:@"提交成功"];
        [weakSelf lew_presentPopupView:popView animation:[LewPopupViewAnimationSpring new]];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self lew_dismissPopupView];
            [self.navigationController popViewControllerAnimated:YES];
        });
    });
}
- (IBAction)cancelBtnSelected:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
