//
//  ViewController.m
//  MTVideoEdit
//
//  Created by MTShawn on 2018/9/17.
//  Copyright © 2018年 MT. All rights reserved.
//

#import "ViewController.h"
#import "MTChooseVideoViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    MTChooseVideoViewController * lView = [[MTChooseVideoViewController alloc] init];
    lView.operateType = MTVideoOperateTypeClip;
    [self.navigationController pushViewController:lView animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
