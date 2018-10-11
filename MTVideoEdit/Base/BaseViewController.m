//
//  BaseViewController.m
//  QzoneUp
//
//  Created by melon on 2017/12/22.
//  Copyright © 2017年 melon. All rights reserved.
//

#import "BaseViewController.h"
#import <QIYU_iOS_SDK/QYSDK.h>
//#import "LoginVC.h"
//#import "NewLogin.h"
#import "YLHUDManager.h"
#import "YHNetWork.h"
#import "YLWebViewController.h"
@interface BaseViewController ()<LoadViewDelegate>

@end

@implementation BaseViewController
#pragma mark - getter setter
- (LoadView *)loadingView
{
    if (!_loadingView) {
        _loadingView = [[LoadView alloc] init];
        _loadingView.delegate = self;
    }
    return _loadingView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = HEXCOLOR(0xf6f6f6);
    
}

#pragma mark - public method
- (void)showLoading
{
    [self addLoadView];
    self.loadingView.frame = self.view.bounds;
    [self.loadingView showLoading];
}
- (void)showLoadFailed
{
    [self addLoadView];
    self.loadingView.frame = self.view.bounds;
    [self.loadingView showFailed];
}
- (void)dismissLoadView
{
    if(self.loadingView.superview){
        [self.loadingView removeFromSuperview];
    }
}
- (void)goChatService
{
    if (![UserInfo isLogin]) {
        [self pushLoginVCAndLoginFinish:nil];
        return;
    }
    BOOL haveOrder = [[NSUserDefaults standardUserDefaults] boolForKey:kHaveOrderKey];
    if (haveOrder) {
        [[SensorsAnalyticsSDK sharedInstance] track:QiYu];
        QYSource *source = [[QYSource alloc] init];
        source.title =  @"在线客服";
        QYSessionViewController *sessionViewController = [[QYSDK sharedSDK] sessionViewController];
        sessionViewController.sessionTitle = @"在线客服";
        //    sessionViewController.source = source;
        sessionViewController.hidesBottomBarWhenPushed = YES;
        sessionViewController.navigationItem.leftBarButtonItem =
        [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain
                                        target:self action:@selector(onBack)];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:sessionViewController];
        [self presentViewController:nav animated:YES completion:nil];
    }else{
        YLWebViewController *web = [YLWebViewController new];
        web.url = @"http://activity.galeblock.com/#/fqa";
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:web];
        web.navigationItem.leftBarButtonItem =
        [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain
                                        target:self action:@selector(onBack)];
        [self presentViewController:nav animated:YES completion:nil];
    }
}
- (BOOL)cheackIsLogin
{
    return UserInfo.isLogin;
}

- (void)pushLoginVCAndLoginFinish:(finishBlock)finish;
{
//    LoginVC *login = [LoginVC new];
//    login.finish = ^{
//        [QOnlineConfigTool updateIsOrder];
//        if (finish) {
//            finish();
//        }
//    };
//    [self presentViewController:login animated:YES completion:nil];
//    NewLogin *login = [NewLogin new];
//    login.finish = ^{
//        if (finish) {
//            finish();
//        }
//    };
//    //    [self presentViewController:login animated:YES completion:nil];
//    [self.navigationController pushViewController:login animated:YES];
}
- (void)requestBuyUserList:(void(^)(NSArray *array))complete
{
    NSMutableDictionary *parameters = [NSMutableDictionary new];
    parameters[@"uaid"] = @(UAID);
    parameters[@"category"] = @(GOOD_LIST_BuyPoint);
    [NetWorkTool POST:@"latest_orders" parameters:parameters result:^(NSURLSessionDataTask * _Nullable dataTask, NSError * _Nullable error, id  _Nullable responseObject) {
        if (error) {
            complete(nil);
        }else{
            NSMutableArray *infoArr = [NSMutableArray array];
            for (NSDictionary *dic in responseObject) {
                NSMutableString *qq = [NSMutableString stringWithFormat:@"%@",[dic objectForKey:@"nickname"]];
                NSString *title = [dic objectForKey:@"good_label"];
                NSString *info = [NSString stringWithFormat:@"用户%@购买  %@",qq,title];
                NSString *ss =  [NSString stringWithFormat:@"用户%@购买",qq];
                NSMutableAttributedString *attributed = [[NSMutableAttributedString alloc] initWithString:info];
                [attributed addAttribute:NSForegroundColorAttributeName value:HEXCOLOR(0xFF7751) range:NSMakeRange(2, qq.length)];
                [attributed addAttribute:NSForegroundColorAttributeName value:HEXCOLOR(0xFF7751) range:NSMakeRange(ss.length, info.length - ss.length)];
                [infoArr addObject:attributed];
            }
            complete(infoArr.copy);
        }
    }];
}
- (void)getUserInfo:(void (^)(void))callBack
{
    if ([UserInfo isLogin]) {
        NSString *openid = UserInfo.openid;
        NSMutableDictionary *parameter = [NSMutableDictionary new];
        parameter[@"user_id"] = @(UserInfo.id);
        parameter[@"uaid"] = @(UAID);
        parameter[@"market_position"] = marketPosition;
        [NetWorkTool POST:@"user_info" parameters:parameter result:^(NSURLSessionDataTask * _Nullable dataTask, NSError * _Nullable error, id  _Nullable responseObject) {
            if (!error) {
                UserModel *model = [UserModel mj_objectWithKeyValues:responseObject[@"user"]];
                UserInfo.channel = model.channel;
                UserInfo.uaid = model.uaid;
                UserInfo.nickname = model.nickname;
                UserInfo.status = model.status;
                UserInfo.vip_type = model.vip_type;
                UserInfo.first_recharge = model.first_recharge;
                UserInfo.score = model.score;
                UserInfo.platform = model.platform;
                UserInfo.discount = model.discount;
                UserInfo.avatar = model.avatar;
                UserInfo.federated = model.federated;
                UserInfo.vip_end = model.vip_end;
                UserInfo.id = model.id;
                UserInfo.vip_end = model.vip_end;
                UserInfo.is_refund = model.is_refund;
                UserInfo.show_red = model.show_red;
                UserInfo.phone = model.phone;
                UserInfo.openid = openid;
                [UserInfo save];
            }
            if (callBack) {
                callBack();
            }
        }];
    }
}
#pragma mark - delegate
- (void)loadViewRequestButtonBeClicked:(LoadView *)loadView{
    BOOL isNet = [[YHNetWork sharedInstanse] isNetworkEnable];
    if (!isNet) {
        [self showLoadFailed];
    }
}
#pragma mark - private method
- (void)onBack
{
   [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)addLoadView
{
    if (self.loadingView.superview) {
        if (self.loadingView.superview == self.view) {
            return;
        }
        [self.loadingView removeFromSuperview];
    }
    
    [self.view addSubview:self.loadingView];
}
- (BOOL)cheakNetWork
{
    BOOL isNet = [[YHNetWork sharedInstanse] isNetworkEnable];
    return isNet;
}
- (void)dealloc
{
    [YLHUDManager hide];
    DLog(@"%@:Dealloc",NSStringFromClass([self class]));
}
@end
