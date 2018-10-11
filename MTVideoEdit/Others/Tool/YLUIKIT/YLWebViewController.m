//
//  YLWebViewController.m
//  weicou
//
//  Created by couba001 on 2017/6/16.
//  Copyright © 2017年 couba. All rights reserved.
//

#import "YLWebViewController.h"
#import <WebKit/WebKit.h>
#import <WebViewJavascriptBridge/WKWebViewJavascriptBridge.h>
#import "PayTool.h"
@interface YLWebViewController ()<WKNavigationDelegate,WKUIDelegate>
@property (nonatomic, strong) WKWebView *webView;
@property (nonatomic, strong) UIProgressView *progress;
@property WKWebViewJavascriptBridge *webViewBridge;
@end

@implementation YLWebViewController

- (WKWebView *)webView
{
    if (!_webView) {
        WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
        configuration.userContentController = [WKUserContentController new];
        WKPreferences *preferences = [WKPreferences new];
        preferences.javaScriptCanOpenWindowsAutomatically = YES;
        //    preferences.minimumFontSize = 30.0;
        configuration.preferences = preferences;
        _webView = [[WKWebView alloc] initWithFrame:CGRectZero configuration:configuration];
        _webView.UIDelegate = self;
        _webView.navigationDelegate = self;
        // 这行代码可以是侧滑返回webView的上一级，而不是跟控制器（*指针对侧滑有效）
        [_webView setAllowsBackForwardNavigationGestures:YES];
        [_webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
//        [_webView addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:NULL];
        [self.view addSubview:_webView];
    }
    return _webView;
}

- (UIProgressView *)progress
{
    if (!_progress) {
        _progress = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleBar];
        _progress.progressTintColor = [UIColor orangeColor];
        [self.view insertSubview:_progress aboveSubview:_webView];
    }
    return _progress;
    
}
- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    self.webView.frame = self.view.bounds;
    //状态栏
    CGRect rectStatus = [[UIApplication sharedApplication] statusBarFrame];
    //导航栏
    CGRect rectNav = self.navigationController.navigationBar.frame;
    CGFloat y = rectStatus.size.height + rectNav.size.height;
    self.progress.frame = CGRectMake(0, y, [UIScreen mainScreen].bounds.size.width, 0);
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _webViewBridge = [WKWebViewJavascriptBridge bridgeForWebView:self.webView];
    [_webViewBridge setWebViewDelegate:self.webView];
    [self registerNativeFunctions];
}

#pragma mark - private method
- (void)registerNativeFunctions
{
    [self registTestOneFunction];
}

-(void)registTestOneFunction
{
    kWeakSelf
    [_webViewBridge registerHandler:@"getBlogNameFromObjC" handler:^(id data, WVJBResponseCallback responseCallback) {
        NSDictionary *jsData = (NSDictionary *)data;
        [weakSelf goPayWithData:jsData];
//        if (responseCallback) {
//            // 反馈给JS
//            responseCallback(@{@"": @""});
//        }
    }];
}
#pragma mark -
#pragma mark - Setter
- (void)setUrl:(NSString *)url
{
    _url = url;
    [self showLoading];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
}

- (void)setNavTitle:(NSString *)navTitle
{
    _navTitle = navTitle;
    self.navigationItem.title = self.navTitle;
}
- (void)setHtmlStr:(NSString *)htmlStr
{
    _htmlStr = htmlStr;
    [self showLoading];
    [self.webView loadHTMLString:htmlStr baseURL:nil];
}

- (void)setLocalFile:(NSString *)localFile
{
    _localFile = localFile;
    [self showLoading];
    NSString *path = [[NSBundle mainBundle] bundlePath];
    NSURL *baseURL = [NSURL fileURLWithPath:path];
    NSString * htmlPath = [[NSBundle mainBundle] pathForResource:localFile
                                                          ofType:nil];
    NSString * htmlCont = [NSString stringWithContentsOfFile:htmlPath
                                                    encoding:NSUTF8StringEncoding
                                                       error:nil];
    [self.webView loadHTMLString:htmlCont baseURL:baseURL];
    
}
- (void)skipThisState
{
    if ([self.webView canGoBack]) {
        [self.webView goBack];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if (object == self.webView && [keyPath isEqualToString:@"estimatedProgress"]) {
        CGFloat newprogress = [[change objectForKey:NSKeyValueChangeNewKey] doubleValue];
        if (newprogress == 1) {
            [self.progress setProgress:1.0 animated:YES];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.7 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                self.progress.hidden = YES;
                [self.progress setProgress:0 animated:NO];
                [self dismissLoadView];
            });
        }else {
            self.progress.hidden = NO;
            [self.progress setProgress:newprogress animated:YES];
        }
    }
//    else if ([keyPath isEqualToString:@"title"]){
//        if (object == self.webView) {
//            self.title = self.webView.title;
//            [self.progress setProgress:self.webView.estimatedProgress animated:YES];
//            self.progress.hidden = self.progress.progress >= 1;
//        }else{
//            [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
//        }
//    }
    else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}



#pragma mark -
#pragma mark - Pay
- (void)goPayWithData:(NSDictionary *)data
{
    NSUInteger good_id = [[data objectForKey:@"goodid"] integerValue];
    NSString *price = [data objectForKey:@"price"];
    [PayTool payCampaignWithViewController:self good_id:good_id price:price campaign_category:self.campaign_category label:self.navTitle campaign_id:self.campaign_id finish:^(PayFinishType type) {
        if (type == PayFinishTypeSuccess) {
            [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];
        }else if (type == PayFinishTypeNone){
            
        }else{
        }
    }];
}
#pragma mark -
#pragma mark - WKNavigationDelegate
- (void)dealloc
{
    [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
//    [self.webView removeObserver:self forKeyPath:@"title"];
    DLog(@"%@:Dealloc",NSStringFromClass([self class]));
}
@end
