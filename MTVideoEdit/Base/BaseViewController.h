//
//  BaseViewController.h
//  QzoneUp
//
//  Created by melon on 2017/12/22.
//  Copyright © 2017年 melon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoadView.h"
typedef void (^finishBlock) (void);
@interface BaseViewController : UIViewController

@property (nonatomic, strong) LoadView *loadingView;

- (void)showLoading;
- (void)showLoadFailed;
- (void)dismissLoadView;
- (void)loadViewRequestButtonBeClicked:(LoadView *)loadView;

- (void)goChatService;
- (BOOL)cheackIsLogin;
- (void)pushLoginVCAndLoginFinish:(finishBlock)finish;



/**
 跑马灯数据

 @param complete 返回富文本数组
 */
- (void)requestBuyUserList:(void(^)(NSArray *array))complete;
/**
 获取用户信息
 
 @param callBack 回调
 */
- (void)getUserInfo:(void(^)(void))callBack;
@end
