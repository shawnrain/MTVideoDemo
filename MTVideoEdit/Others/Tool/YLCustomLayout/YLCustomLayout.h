//
//  YLCustomLayout.h
//  YHCustomLayoutExample
//
//  Created by cy on 2018/6/6.
//  Copyright © 2018年 cmapu. All rights reserved.
//

#import <UIKit/UIKit.h>
UIKIT_EXTERN NSString *const YLCollectionElementKindSectionHeader;
UIKIT_EXTERN NSString *const YLCollectionElementKindSectionFooter;
@class YLCustomLayout;
typedef NS_ENUM(NSInteger,YLCustomLayoutType) {
    /// 流水布局
    YLCustomLayoutTypeWaterFlow,
};
typedef NS_ENUM(NSInteger, YLCustomLayoutScrollDirection) {
    /// 垂直
    YLCustomLayoutScrollDirectionVertical,
    /// 水平
    YLCustomLayoutScrollDirectionHorizontal
};
@protocol YLCustomLayoutDelegate<UICollectionViewDelegate>

- (NSInteger)collectionView:(UICollectionView *)collectionView layout:(YLCustomLayout *)collectionViewLayout numberOfColumnsInSection:(NSInteger)section;

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(YLCustomLayout *)layout insetForSectionAtIndex:(NSInteger)section;

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(YLCustomLayout *)layout horizontalSpacingForSectionAtIndex:(NSInteger)section;

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(YLCustomLayout *)collectionViewLayout verticalSpacingForSectionAtIndex:(NSInteger)section;

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(YLCustomLayout *)layout heightForHeaderInSection:(NSInteger)section;

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(YLCustomLayout *)layout heightForFooterInSection:(NSInteger)section;

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(YLCustomLayout *)layout sizeForItemAtIndexPath:(NSIndexPath *)indexPath itemWidth:(CGFloat)itemWidth;
@end
@interface YLCustomLayout : UICollectionViewLayout
/// 列数 默认2
@property (assign, nonatomic) NSInteger numberOfColumns;
/// item 水平间距 默认10
@property (assign, nonatomic) CGFloat horizontalSpacing;
/// item 垂直间距 默认10
@property (assign, nonatomic) CGFloat verticalSpacing;
/// 头视图的高度 初始值为0
@property (assign, nonatomic) CGFloat headerReferenceHeight;
/// 尾视图的高度 初始值为0
@property (assign, nonatomic) CGFloat footerReferenceHeight;
/// section 偏移 默认偏移为UIEdgeInsetsZero
@property (nonatomic) UIEdgeInsets sectionInset;
/// item尺寸
@property (nonatomic) CGSize itemSize;
/// 滚动方向 默认垂直
@property (nonatomic) YLCustomLayoutScrollDirection scrollDirection;

- (instancetype)initWithType:(YLCustomLayoutType)type;
@end
