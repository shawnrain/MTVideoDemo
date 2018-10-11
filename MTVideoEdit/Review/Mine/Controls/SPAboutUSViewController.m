//
//  SPAboutUSViewController.m
//  shipingdiandian
//
//  Created by MTShawn on 2018/7/19.
//  Copyright © 2018年 MT. All rights reserved.
//

#import "SPAboutUSViewController.h"
@interface SPAboutUSViewController ()

@end

@implementation SPAboutUSViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"关于我们";
    self.view.backgroundColor = [UIColor whiteColor];
    [self wr_setNavBarShadowImageHidden:false];
    [self configureUI];
}
- (void)configureUI{
    UIImageView * iconImage = [[UIImageView alloc]initWithFrame:CGRectZero];
    iconImage.image = [UIImage imageNamed:@"AppIcon"];
    [self.view addSubview:iconImage];
    UILabel * appName = [self createLabel:@"网络人气助手"];
    appName.font = [UIFont fontWithName:@"PingFangSC-Regular" size:16];
    UILabel * version = [self createLabel:@"V2.0.2"];
    version.font =  [UIFont fontWithName:@"PingFangSC-Light" size:12];
    version.layer.cornerRadius = 10.0;
    version.clipsToBounds = YES;
    version.layer.borderWidth = 1.0;
    version.layer.borderColor = color888888.CGColor;
    UILabel * descLabel = [self createLabel:@"视频编辑工具"];
    descLabel.font =[UIFont fontWithName:@"PingFangSC-Regular" size:18];
    [self.view addSubview:iconImage];
    [self.view addSubview:appName];
    [self.view addSubview:version];
    [self.view addSubview:descLabel];
    [appName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.centerY.mas_equalTo(self.view).offset(-40);
        make.height.equalTo(@22);
        make.width.equalTo(@150);
    }];
    [version mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@60);make.height.equalTo(@20);
        make.centerX.mas_equalTo(appName.mas_centerX).offset(0);
        make.top.mas_equalTo(appName.mas_bottom).offset(3);
    }];
    [descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(version.mas_bottom).offset(22);
        make.centerX.mas_equalTo(appName.mas_centerX).offset(0);
    }];
    [iconImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(appName.mas_top).offset(-12);
        make.width.and.height.equalTo(@72);
        make.centerX.mas_equalTo(appName.mas_centerX).offset(0);
    }];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"return_backimg"] style:UIBarButtonItemStyleDone target:self action:@selector(backAction)];
}
- (void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}
- (UILabel *)createLabel:(NSString *)textName{
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(116,361,144,25);
    label.text = textName;
    label.textColor = color555555;
    label.textAlignment = NSTextAlignmentCenter;
    return label;
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
