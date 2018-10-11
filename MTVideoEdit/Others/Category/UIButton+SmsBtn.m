//
//  UIButton+SmsBtn.m
//  weicou
//
//  Created by couba001 on 2017/4/13.
//  Copyright © 2017年 couba. All rights reserved.
//

#import "UIButton+SmsBtn.h"

@implementation UIButton (SmsBtn)

- (void)cc_startTimer:(NSInteger)timeLine mTitle:(NSString *)mTitle countDownTitle:(NSString *)countDownTitle mColor:(UIColor *)mColor countDownColor:(UIColor *)countDownColor
{
    __block NSInteger time = timeLine; //倒计时时间
    __weak typeof(self) weakSelf = self;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(time <= 0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置按钮的样式
                [weakSelf setTitle:countDownTitle forState:UIControlStateNormal];
                [weakSelf setTitleColor:countDownColor forState:UIControlStateNormal];
                weakSelf.userInteractionEnabled = YES;
            });
            
        }else{
            int allTime = (int)timeLine + 1;
            int seconds = time % allTime;
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置按钮显示读秒效果
                [weakSelf setTitle:[NSString stringWithFormat:@"%d%@",seconds,mTitle] forState:UIControlStateNormal];
                [weakSelf setTitleColor:mColor forState:UIControlStateNormal];
                weakSelf.userInteractionEnabled = NO;
            });
            time--;
        }
    });
    dispatch_resume(_timer);
}
@end
