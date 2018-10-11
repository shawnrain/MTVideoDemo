//
//  YHWaterFlowLayout.h
//  111
//
//  Created by cy on 2017/9/16.
//  Copyright © 2017年 cmapu. All rights reserved.
//

#import <UIKit/UIKit.h>
UIKIT_EXTERN NSString *const YH_UICollectionElementKindSectionHeader;
UIKIT_EXTERN NSString *const YH_UICollectionElementKindSectionFooter;
@class YHWaterFlowLayout;
@protocol YHWaterFlowLayoutDelegate <UICollectionViewDelegate>
//返回每个高度
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(YHWaterFlowLayout *)layout heightForCellAtIndexPath:(NSIndexPath *)indexPath itemWidth:(CGFloat)itemWidth;
//返回头部视图高度
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(YHWaterFlowLayout*)layout heightForHeaderInSection:(NSInteger)section;
//返回尾部视图高度
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(YHWaterFlowLayout*)layout heightForFooterInSection:(NSInteger)section;
@end
@interface YHWaterFlowLayout : UICollectionViewLayout
@property (assign, nonatomic) NSInteger numberOfColumns;//瀑布流列数
@property (assign, nonatomic) CGFloat horizontalSpacing;//cell 水平间距
@property (assign, nonatomic) CGFloat verticalSpacing;//cell 纵向间距
@property (assign, nonatomic) CGFloat headerReferenceHeight;//头视图的高度
@property (assign, nonatomic) CGFloat footerReferenceHeight;//尾视图的高度
@property (nonatomic) UIEdgeInsets sectionInset;//section 偏移

@end
