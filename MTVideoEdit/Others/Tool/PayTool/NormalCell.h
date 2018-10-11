//
//  NormalCell.h
//  New_QzoneUp
//
//  Created by 张有为 on 2017/5/8.
//  Copyright © 2017年 zyw113. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kMyCellMainTitle  @"kMyCellMainTitle"
#define kMyCellSubTitle  @"kMyCellSubTitle"
#define kMyCellLeftImagePath @"kMyCellLeftImagePath"
#define kMyCellRightImagePath  @"kMyCellRightImagePath"
#define kMyCellShowArrow  @"kMyCellShowArrow"
#define kMyCellShowBottomLine  @"kMyCellShowBottomLine"


@interface NormalCell : UITableViewCell

- (void)setMainTitle:(NSString *)mainTitle subTitle:(NSString *)subTitle leftImagePath:(NSString *)leftImagePath rightImagePath:(NSString *)rightImagePath showArrow:(BOOL)showArrow;
- (void)showBottomLine:(BOOL)show;
- (void)setWithDic:(NSDictionary *)dic;

@property (nonatomic, strong) UILabel *subLabel;
@property (nonatomic, strong) UILabel *mainLabel;
@property (nonatomic, strong) UIImageView *leftImageView;
@property (nonatomic, strong) UIImageView *rightImageView;
@property (nonatomic, strong) UIImageView *arrowImageView;
@property (nonatomic, strong) UIView *bottomLine;

@end
