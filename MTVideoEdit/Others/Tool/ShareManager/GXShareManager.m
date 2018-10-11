//
//  GXShare.m
//  RedEnvelopes
//
//  Created by fuguangxin on 16/8/24.
//  Copyright © 2016年 wazrx. All rights reserved.
//

#import "GXShareManager.h"

#define k_NotFirstWeiXinShare @"k_NotFirstWeiXinShare"

@implementation GXShareManager


+ (instancetype)defaultManager{
    static GXShareManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [GXShareManager new];
    });
    return manager;
}

+ (void)shareInController:(UIViewController *)controller canSystemShare:(BOOL)canSystemShare type:(UMSocialPlatformType )type title:(NSString *)title shareText:(NSString *)shareText shareImage:(UIImage *)shareImage url:(NSString *)url configuration:(GXConfiguration)configuration complete:(GXShareComplete)complete{
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    [[UMSocialManager defaultManager] openLog:YES];
    //创建网页内容对象
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:title descr:shareText thumImage:shareImage];
    //设置网页地址
    shareObject.webpageUrl = url;
    
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    messageObject.title = title;
    messageObject.text = shareText;
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:type messageObject:messageObject currentViewController:controller completion:^(id result, NSError *error) {
        
    }];
    
}

#pragma mark - private method
+ (BOOL)canShareBySystemWithType:(UMSocialPlatformType )type canSystemShare:(BOOL)canSystemShare{
    if (canSystemShare && [[UIDevice currentDevice].systemVersion floatValue] >= 8) {
        if ((type == UMSocialPlatformType_WechatSession) ||
            (type == UMSocialPlatformType_WechatTimeLine) ||
            (type == UMSocialPlatformType_WechatFavorite))
        {
            return YES;
        }
        
    }
    return NO;
}

@end


@interface GXShareHelpViewController()<UIScrollViewDelegate>


@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) NSArray *imageViewArr;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) UIButton *closeButton;
@end

@implementation GXShareHelpViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor = HEXCOLOR(0xFFFFFF);
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 7) {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    [self loadSubView];
}


- (void)loadSubView{
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    _scrollView.contentSize = CGSizeMake(_scrollView.frame.size.width * 3, _scrollView.frame.size.height);
    _scrollView.pagingEnabled = YES;
    _scrollView.delegate = self;
    [self.view addSubview:_scrollView];
    
    _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 50, self.view.frame.size.width, 30)];
    _pageControl.numberOfPages = 3;
    _pageControl.pageIndicatorTintColor = HEXCOLOR(0xAAAAAA);
    _pageControl.currentPageIndicatorTintColor = HEXCOLOR(0x000000);
    [self.view addSubview:_pageControl];
    
    _closeButton = [UIButton buttonWithType:UIButtonTypeSystem];
    _closeButton.frame = CGRectMake(self.view.frame.size.width - 60, 20, 44, 44);
    [_closeButton setTitle:@"关闭" forState:UIControlStateNormal];
    _closeButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [_closeButton addTarget:self action:@selector(closeAction) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_closeButton];
    
    NSMutableArray *imageViewArr = [NSMutableArray array];
    for (int i = 0; i < 3; i ++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake((_scrollView.frame.size.width - 283)/2 + _scrollView.frame.size.width * i, 0, 283, _scrollView.frame.size.height)];
        imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"分享引导%d",i + 1]];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        [_scrollView addSubview:imageView];
        [imageViewArr addObject:imageView];
    }
}

- (void)closeAction{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSInteger index = scrollView.contentOffset.x/scrollView.frame.size.width;
    _pageControl.currentPage = index;
}


@end




