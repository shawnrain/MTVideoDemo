//
//  PayTool.m
//  KwaiUp
//
//  Created by melon on 2018/1/4.
//  Copyright © 2018年 melon. All rights reserved.
//

#import "PayTool.h"
#import <WebKit/WebKit.h>
#import "NetWorkAPI.h"
#import "PaymentModel.h"
#import "PayOrderModel.h"
#import "PayStyleView.h"
@interface  PayTool ()<WKNavigationDelegate>
@property (nonatomic, strong) WKWebView *webView;
@property (nonatomic, strong) UIViewController *vc;
@property (nonatomic, copy) NSString *label;
@property (nonatomic, copy) NSString *price;
@property (nonatomic, assign) NSInteger good_id;
@property (nonatomic, assign) NSInteger campaign_category;
@property (nonatomic, assign) NSInteger campaign_id;

@property (nonatomic) PayStyle payType;
@property (nonatomic, copy) PayFinishBlock finish;
@property (nonatomic, copy) NSString *payUrl;
@property (nonatomic, copy) NSString *code;
@property (nonatomic, assign) BOOL isH5Pay;
@property (nonatomic, copy) NSString *payment_id;
@property (nonatomic) PAYMENT_LIST payCategory;

@property (nonatomic, assign) BOOL needEncode;
@end
@implementation PayTool
- (WKWebView *)webView
{
    if (!_webView) {
        _webView = [[WKWebView alloc] initWithFrame:self.view.bounds];
        _webView.backgroundColor = [UIColor clearColor];
        _webView.navigationDelegate = self;
        [self.view addSubview:_webView];
    }
    return _webView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(yh_enterForeGround) name:UIApplicationWillEnterForegroundNotification object:nil];
    [self getPayment_id];
}
+ (void)payWithViewController:(UIViewController *)vc good_id:(NSInteger)good_id price:(NSString *)price label:(NSString *)label finish:(PayFinishBlock)finish;
{
    PayTool *tool = [PayTool new];
    tool.vc = vc;
    tool.good_id = good_id;
    tool.price = price;
    tool.label = label;
    tool.finish = finish;
    tool.definesPresentationContext = YES;
    UIColor *color = [UIColor blackColor];
    tool.view.backgroundColor = [color colorWithAlphaComponent:0.0];
    tool.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    [vc presentViewController:tool animated:NO completion:nil];
}
+ (void)payCampaignWithViewController:(UIViewController *)vc good_id:(NSInteger)good_id price:(NSString *)price campaign_category:(NSInteger)campaign_category label:(NSString *)label campaign_id:(NSInteger)campaign_id finish:(PayFinishBlock)finish
{
    PayTool *tool = [PayTool new];
    tool.vc = vc;
    tool.good_id = good_id;
    tool.price = price;
    tool.label = label;
    tool.finish = finish;
    tool.campaign_id = campaign_id;
    tool.campaign_category = campaign_category;
    tool.definesPresentationContext = YES;
    UIColor *color = [UIColor blackColor];
    tool.view.backgroundColor = [color colorWithAlphaComponent:0.0];
    tool.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    [vc presentViewController:tool animated:NO completion:nil];
}
- (BOOL)isEmpty:(NSString *)string
{
    if (string == nil || string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    return NO;
}
- (void)addorderWithModel:(PaymentModel *)model
{
    NSString *pay_type = nil;
    self.payment_id = nil;
    self.isH5Pay = NO;
    self.needEncode = NO;
    if (self.payType == PayStyleQQ) {
        pay_type = @"qq";
        self.payment_id = model.qq.payment_id;
        self.isH5Pay = model.qq.is_h5;
        self.payCategory = model.qq.category;
        [[SensorsAnalyticsSDK sharedInstance] track:PayQQ];
        if (model.qq.category == PAYMENT_LIST_HFT){
            self.needEncode = YES;
        }
    }else if (self.payType == PayStyleAliPay){
        pay_type = @"ali";
        self.payment_id = model.ali.payment_id;
        self.isH5Pay = model.ali.is_h5;
        self.payCategory = model.ali.category;
        [[SensorsAnalyticsSDK sharedInstance] track:PayALI];
        if (model.ali.category == PAYMENT_LIST_HFT){
            self.needEncode = YES;
        }
    }else if (self.payType == PayStyleWeiXin){
        pay_type = @"wx";
        self.payment_id = model.wx.payment_id;
        self.isH5Pay = model.wx.is_h5;
        self.payCategory = model.wx.category;
        [[SensorsAnalyticsSDK sharedInstance] track:PayWX];
        if (model.wx.category == PAYMENT_LIST_HFT){
            self.needEncode = YES;
        }
    }
    [self addOrder:self.payment_id pay_type:pay_type model:model];
}
- (void)yh_enterForeGround
{
    if ([self isEmpty:self.code]) {
        return;
    }
    [YLHUDManager showMessage:@"正在查询支付...."];
    NSMutableDictionary *parameters = [NSMutableDictionary new];
    parameters[@"uaid"] = @(UAID);
    parameters[@"code"] = self.code;
    [NetWorkTool POST:@"latest_orders" parameters:parameters result:^(NSURLSessionDataTask * _Nullable dataTask, NSError * _Nullable error, id  _Nullable responseObject) {
        if (error) {
            [self dismissVCWithPayFinishType:PayFinishTypeFailure];
        }else{
            NSArray *array = (NSArray *)responseObject;
            if (array.count) {
                [self dismissVCWithPayFinishType:PayFinishTypeSuccess];
            }else{
                [self dismissVCWithPayFinishType:PayFinishTypeFailure];
            }
        }
    }];
    
}

- (void)addPayStyleView:(PaymentModel *)model
{
    NSMutableArray *array = [NSMutableArray new];
    if (![self isEmpty:model.ali.payment_id]) {
        [array addObject:@{@"title" : @"支付宝支付",@"image" : @"AliPay"}];
    }
    if (![self isEmpty:model.wx.payment_id]){
        [array addObject:@{@"title" : @"微信支付",@"image" : @"WeChatPay"}];
    }
    if (![self isEmpty:model.qq.payment_id]){
        [array addObject:@{@"title" : @"QQ支付",@"image" : @"QQ"}];
    }
    if (!array.count) {
        [self dismissVCWithPayFinishType:PayFinishTypeClose];
        return;
    }
    [PayStyleView showInVC:[UIApplication sharedApplication].keyWindow.rootViewController withArray:[array copy] selectedBlock:^(PayStyle style) {
        if (style != PayStyleNone) {
            [YLHUDManager showIndicatorWithMessage:@"正在进行支付中..."];
            self.payType = style;
            [self addorderWithModel:model];
        }else{
            [self dismissVCWithPayFinishType:PayFinishTypeNone];
        }
    }];
}
#pragma mark -
#pragma mark - Requset
- (void)getPayment_id
{
    NSMutableDictionary *parameters = [NSMutableDictionary new];
    parameters[@"uaid"] = @(UAID);
    [NetWorkTool POST:@"get_payments" parameters:parameters result:^(NSURLSessionDataTask * _Nullable dataTask, NSError * _Nullable error, id  _Nullable responseObject) {
        if (error) {
            [self dismissVCWithPayFinishType:PayFinishTypeError];
            return ;
        }
        PaymentModel *model = [PaymentModel mj_objectWithKeyValues:responseObject];
        [self addPayStyleView:model];
        
    }];
}

- (void)addOrder:(NSString *)payment_id pay_type:(NSString *)pay_type model:(PaymentModel *)model
{
    NSDictionary *appInfo = [[NSBundle mainBundle] infoDictionary];
    NSString *mchAppName = appInfo[@"CFBundleDisplayName"];
    NSString *appId = appInfo[@"CFBundleIdentifier"];
    NSString *version = appInfo[@"CFBundleShortVersionString"];
    NSMutableDictionary *parameters = [NSMutableDictionary new];
    parameters[@"uaid"] = @(UAID);
    parameters[@"price"] = self.price;
    parameters[@"payment_id"] = payment_id;
    parameters[@"user_id"] = @(UserInfo.id);
    parameters[@"good_id"] = @(self.good_id);
    parameters[@"pay_type"] = pay_type;
    parameters[@"mchAppName"] = mchAppName;
    parameters[@"mchAppId"] = appId;
    parameters[@"app_version"] = version;
    parameters[@"market_position"] = marketPosition;
    if (self.campaign_category != 0 || self.campaign_id != 0) {
        parameters[@"campaign_id"] = @(self.campaign_id);
        parameters[@"campaign_category"] = @(self.campaign_category);
    }
    [NetWorkTool POST:@"add_order" parameters:parameters result:^(NSURLSessionDataTask * _Nullable dataTask, NSError * _Nullable error, id  _Nullable responseObject) {
        if (error) {
            [self dismissVCWithPayFinishType:PayFinishTypeError];
            return;
        }
        PayOrderModel *order = [PayOrderModel mj_objectWithKeyValues:responseObject];
        if (self.isH5Pay) {
            [self goPayWithH5:order model:model];
        }else{
            [self dismissVCWithPayFinishType:PayFinishTypeError];
        }
    }];
}

- (void)goPayWithH5:(PayOrderModel *)order model:(PaymentModel *)model
{
    if ([order.status isEqualToString:@"ok"]) {
        self.code = order.code;
        self.payUrl = order.pay_url;
        if (order.pay_flow == PAY_FLOW_LIST_ContinueRequest) {
            [self getQuest];
        }else{
            [self goPay];
        }
    }else{
        [self dismissVCWithPayFinishType:PayFinishTypeError];
    }
}

- (void)getQuest
{
    NSString *url = [self.payUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [NetWorkAPI GET:url parameters:nil result:^(NSURLSessionDataTask * _Nullable dataTask, NSError * _Nullable error, id  _Nullable responseObject) {
        if (error){
//            DLog(@"%@",error);
            [self dismissVCWithPayFinishType:PayFinishTypeError];
            return;
        };
        NSDictionary *dict = (NSDictionary *)responseObject;
        NSError *eerror;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&eerror];
        NSString *jsonStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        [self parsePay:jsonStr];
    }];
}

- (void)parsePay:(NSString *)json
{
    NSMutableDictionary *parameters = [NSMutableDictionary new];
    parameters[@"pay_json"] = json;
    parameters[@"platform"] = @(Platform);
    parameters[@"uaid"] = @(UAID);
    [NetWorkTool POST:@"parse_pay" parameters:parameters result:^(NSURLSessionDataTask * _Nullable dataTask, NSError * _Nullable error, id  _Nullable responseObject) {
        if (error){
            //            DLog(@"%@",error);
            [self dismissVCWithPayFinishType:PayFinishTypeError];
            return;
        };
        if ([responseObject[@"status"] isEqualToString:@"ok"]) {
            self.payUrl = responseObject[@"url"];
            [self goPay];
        }else{
            [self dismissVCWithPayFinishType:PayFinishTypeError];
        }
    }];
}
- (void)goPay
{
    NSString *encodingUrl = [self.payUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *url = self.needEncode ? encodingUrl : self.payUrl;
    self.webView.alpha = 0;
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
}

- (void)dismissVCWithPayFinishType:(PayFinishType)type
{
    kWeakSelf
    if (type == PayFinishTypeNone) {
        [self dismissViewControllerAnimated:NO completion:^{
            if (weakSelf.finish) {
                weakSelf.finish(type);
            }
        }];
    }else{
        NSString *showString = nil;
        if (type == PayFinishTypeSuccess) {
            showString = @"支付成功";
        }else if (type == PayFinishTypeFailure){
            showString = @"支付失败";
        }else if (type == PayFinishTypeError){
            showString = @"支付失败";
        }else if (type == PayFinishTypeClose){
            showString = @"支付维护中";
        }
        
        [YLHUDManager showMessage:showString duration:kShowErrorMessageTime complection:^{
            weakSelf.code = nil;
            [weakSelf dismissViewControllerAnimated:NO completion:^{
                if (weakSelf.finish) {
                    weakSelf.finish(type);
                }
            }];
        }];
    }
    
}

#pragma mark -
#pragma mark - WKNavigationDelegate
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler
{
    decisionHandler(WKNavigationActionPolicyAllow);
}
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler
{
    decisionHandler(WKNavigationResponsePolicyAllow);
}
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(null_unspecified WKNavigation *)navigation
{
    NSURL *url= webView.URL;
    if ([url.scheme hasPrefix:@"weixin"]) {
        [[UIApplication sharedApplication] openURL:url];
    }else if ([url.scheme hasPrefix:@"mqqapi"]){
        [[UIApplication sharedApplication] openURL:url];
    }else if ([url.absoluteString containsString:@"alipay"]){
        [[UIApplication sharedApplication] openURL:url];
    }
    
}
//- (void)webView:(WKWebView *)webView didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential * _Nullable credential))completionHandler{
//    if ([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust]) {
//        NSURLCredential *card = [[NSURLCredential alloc]initWithTrust:challenge.protectionSpace.serverTrust];
//        completionHandler(NSURLSessionAuthChallengeUseCredential,card);
//
//    }
//}
- (void)webView:(WKWebView *)webView didFailNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error
{
    if([error code] == NSURLErrorCancelled){
        return;
    }else{
        [self dismissVCWithPayFinishType:PayFinishTypeError];
    }
}

- (void)dealloc
{
    DLog(@"--------------dealloc---------------");
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
