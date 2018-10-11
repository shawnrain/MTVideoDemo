//
//  MTPopView.m
//  MTVideoEdit
//
//  Created by MTShawn on 2018/9/19.
//  Copyright © 2018年 MT. All rights reserved.
//

#import "MTPopView.h"

@interface MTPopView()
@property (nonatomic, copy) NSString  * lStr;
@property (nonatomic, strong) CABasicAnimation  * animation;
@end

@implementation MTPopView
+(MTPopView *)MTPopViewShowLoading{
   return [self MTPopViewShowType:MTPopViewTypeLoading withStr:@"正在加载..." withImage:@"review_loading"];
}
+(MTPopView *)MTPopViewShowWithStr:(NSString *)str{
   return [self MTPopViewShowType:MTPopViewTypeNormal withStr:str withImage:@"video_edit_done"];
}
+(MTPopView *)MTPopViewShowType:(MTPopViewType)type withStr:(NSString *)str withImage:(NSString *)imageName{
    MTPopView * popView = [[MTPopView alloc] initWithFrame:CGRectMake(0, 0, 255, 114)];
    popView.backgroundColor = colorFFFFFF;
    popView.layer.cornerRadius = 6.0;
    popView.layer.masksToBounds = YES;
    UIImageView *lImage = [YLUI imageViewWithName:imageName];
    [popView addSubview:lImage];
    [lImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@20);
        make.width.and.height.equalTo(@35);
        make.centerX.equalTo(popView);
    }];
    if (type == MTPopViewTypeLoading) {
        [lImage.layer addAnimation:popView.animation forKey:@"animation"];
        [lImage mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.and.height.equalTo(@45);
        }];
    }
    UILabel * label = [YLUI labelTextColor:color353535 fontSize:16 text:str];
    [popView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(@-20);
        make.centerX.equalTo(popView);
    }];
    [popView configureUI];
    return popView;
}

- (CABasicAnimation *)animation{
    if (!_animation) {
        _animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
        _animation.toValue = [NSNumber numberWithFloat: M_PI * 2.0 ];
        _animation.duration = 2;
        _animation.cumulative = YES;
        _animation.repeatCount = MAXFLOAT;
    }
    return _animation;
}
- (void)configureUI{
    
}
@end
