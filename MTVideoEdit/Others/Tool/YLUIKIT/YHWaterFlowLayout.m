//
//  YHWaterFlowLayout.m
//  111
//
//  Created by cy on 2017/9/16.
//  Copyright © 2017年 cmapu. All rights reserved.
//

#import "YHWaterFlowLayout.h"
NSString *const YH_UICollectionElementKindSectionHeader = @"UICollectionElementKindSectionHeader";
NSString *const YH_UICollectionElementKindSectionFooter = @"UICollectionElementKindSectionFooter";
@interface  YHWaterFlowLayout ()

@property (strong, nonatomic) NSMutableDictionary *cellLayoutInfo;//保存cell的布局
@property (strong, nonatomic) NSMutableDictionary *headLayoutInfo;//保存头视图的布局
@property (strong, nonatomic) NSMutableDictionary *footLayoutInfo;//保存尾视图的布局
@property (assign, nonatomic) CGFloat startY;//记录开始的Y
@property (strong, nonatomic) NSMutableDictionary *maxYForColumn;//记录瀑布流每列最下面那个cell的底部y值


@end
@implementation YHWaterFlowLayout
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.numberOfColumns = 2;
        self.horizontalSpacing = 10;
        self.verticalSpacing = 10;
        self.headerReferenceHeight = 0;
        self.footerReferenceHeight = 0;
        self.startY = 0;
        self.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        self.maxYForColumn = [NSMutableDictionary dictionary];
        self.cellLayoutInfo = [NSMutableDictionary dictionary];
        self.headLayoutInfo = [NSMutableDictionary dictionary];
        self.footLayoutInfo = [NSMutableDictionary dictionary];
    }
    return self;
}
- (void)prepareLayout
{
    [super prepareLayout];
    //重新布局需要清空
    [self.cellLayoutInfo removeAllObjects];
    [self.headLayoutInfo removeAllObjects];
    [self.footLayoutInfo removeAllObjects];
    [self.maxYForColumn removeAllObjects];
    self.startY = 0;
    
    CGFloat viewWidth = self.collectionView.frame.size.width;
    CGFloat itemWidth = (viewWidth - self.horizontalSpacing*(self.numberOfColumns - 1) - self.sectionInset.left - self.sectionInset.right)/self.numberOfColumns;
    //取有多少个section
    NSInteger sectionsCount = [self.collectionView numberOfSections];
    
    for (int section = 0; section < sectionsCount; ++section) {
        NSIndexPath *supplementaryViewIndexPath = [NSIndexPath indexPathForRow:0 inSection:section];
        if ([self cheakHaveHeaderOrFooter:self.headerReferenceHeight selector:@selector(collectionView:layout:heightForHeaderInSection:)]) {
            CGFloat sectionHeight = 0.0f;
            if ([self.collectionView.delegate respondsToSelector:@selector(collectionView:layout:heightForHeaderInSection:)]) {
                sectionHeight = [(id<YHWaterFlowLayoutDelegate>)self.collectionView.delegate collectionView:self.collectionView layout:self heightForHeaderInSection:section];
            }else{
                sectionHeight = self.headerReferenceHeight;
            }
            //设置frame
            [self setLayoutAttributes:YH_UICollectionElementKindSectionHeader indexPath:supplementaryViewIndexPath sectionHeight:sectionHeight];
        }else{
            //没有头视图的时候，也要设置section的第一排cell到顶部的距离
            self.startY += self.sectionInset.top;
            
        }
        
        //将Section第一排cell的frame的Y值进行设置
        for (int i = 0; i < _numberOfColumns; i++) {
            self.maxYForColumn[@(i)] = @(self.startY);
        }
        
        //计算cell的布局
        //取出section有多少个row
        NSInteger rowsCount = [self.collectionView numberOfItemsInSection:section];
        //分别计算设置每个cell的布局对象
        for (NSInteger row = 0; row < rowsCount; row++) {
            NSIndexPath *cellIndexPath =[NSIndexPath indexPathForItem:row inSection:section];
            UICollectionViewLayoutAttributes *attribute = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:cellIndexPath];
            //计算当前的cell加到哪一列（瀑布流是加载到最短的一列）
            CGFloat y = [self.maxYForColumn[@(0)] floatValue];
            NSInteger currentRow = 0;
            for (int i = 1; i < _numberOfColumns; i++) {
                if ([self.maxYForColumn[@(i)] floatValue] < y) {
                    y = [self.maxYForColumn[@(i)] floatValue];
                    currentRow = i;
                }
            }
            
            //计算x值
            CGFloat x = self.sectionInset.left+ (self.horizontalSpacing + itemWidth)*currentRow;
            CGFloat height = 0;
            if ([self.collectionView.delegate respondsToSelector:@selector(collectionView:layout:heightForCellAtIndexPath:itemWidth:)]) {
                //根据代理去当前cell的高度  因为当前是采用通过列数计算的宽度，高度根据图片的原始宽高比进行设置的
                height = [(id<YHWaterFlowLayoutDelegate>)self.collectionView.delegate collectionView:self.collectionView layout:self heightForCellAtIndexPath:cellIndexPath itemWidth:itemWidth];
            }else{
                height = itemWidth;
                NSAssert(height, @"You should implementation method collectionView:layout:heightForCellAtIndexPath:itemWidth:");
                
            }
            //设置当前cell布局对象的frame
            attribute.frame = CGRectMake(x, y, itemWidth, height);
            //重新设置当前列的Y值
            y = y + self.verticalSpacing + height;
            self.maxYForColumn[@(currentRow)] = @(y);
            //保留cell的布局对象
            self.cellLayoutInfo[cellIndexPath] = attribute;
            //当是section的最后一个cell是，取出最后一排cell的底部Y值   设置startY 决定下个视图对象的起始Y值
            if (row == rowsCount -1) {
                CGFloat maxY = [self.maxYForColumn[@(0)] floatValue];
                for (int i = 1; i < _numberOfColumns; i++) {
                    if ([self.maxYForColumn[@(i)] floatValue] > maxY) {
                        maxY = [self.maxYForColumn[@(i)] floatValue];
                    }
                }
                self.startY = maxY + self.sectionInset.bottom - self.verticalSpacing;
                
            }
            
            //存储footView属性
            //尾视图的高度不为0并且根据代理方法能取到对应的尾视图的时候，添加对应尾视图的布局对象
            if ([self cheakHaveHeaderOrFooter:self.footerReferenceHeight selector:@selector(collectionView:layout:heightForFooterInSection:)]) {
                CGFloat sectionHeight = 0.0f;
                if ([self.collectionView.delegate respondsToSelector:@selector(collectionView:layout:heightForFooterInSection:)]) {
                    sectionHeight = [(id<YHWaterFlowLayoutDelegate>)self.collectionView.delegate collectionView:self.collectionView layout:self heightForFooterInSection:section];
                }else{
                    sectionHeight = self.footerReferenceHeight;
                }
                [self setLayoutAttributes:YH_UICollectionElementKindSectionFooter indexPath:supplementaryViewIndexPath sectionHeight:sectionHeight];
            }
        }
    }
}

- (void)setLayoutAttributes:(NSString *)kind indexPath:(NSIndexPath *)indexPath sectionHeight:(CGFloat)sectionHeight
{
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForSupplementaryViewOfKind:kind withIndexPath:indexPath];
    attributes.frame = CGRectMake(0, self.startY, self.collectionView.frame.size.width, sectionHeight);
    if (kind == YH_UICollectionElementKindSectionHeader) {
        //保存布局对象
        self.headLayoutInfo[indexPath] = attributes;
        //设置下个布局对象的开始Y值
        self.startY = self.startY + sectionHeight+self.sectionInset.top;
    }else{
        self.footLayoutInfo[indexPath] = attributes;
        self.startY = self.startY + sectionHeight;
    }
    
}

- (BOOL)cheakHaveHeaderOrFooter:(CGFloat)sectionHeight selector:(SEL)selector
{
    return (sectionHeight >0 && [self.collectionView.dataSource respondsToSelector:@selector(collectionView: viewForSupplementaryElementOfKind: atIndexPath:)]) || ([self.collectionView.delegate respondsToSelector:selector]&&[self.collectionView.dataSource respondsToSelector:@selector(collectionView: viewForSupplementaryElementOfKind: atIndexPath:)]);
}
- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSMutableArray *allAttributes = [NSMutableArray array];
    
    //添加当前屏幕可见的cell的布局
    [self.cellLayoutInfo enumerateKeysAndObjectsUsingBlock:^(NSIndexPath *indexPath, UICollectionViewLayoutAttributes *attribute, BOOL *stop) {
        if (CGRectIntersectsRect(rect, attribute.frame)) {
            [allAttributes addObject:attribute];
        }
    }];
    
    //添加当前屏幕可见的头视图的布局
    [self.headLayoutInfo enumerateKeysAndObjectsUsingBlock:^(NSIndexPath *indexPath, UICollectionViewLayoutAttributes *attribute, BOOL *stop) {
        if (CGRectIntersectsRect(rect, attribute.frame)) {
            [allAttributes addObject:attribute];
        }
    }];
    
    //添加当前屏幕可见的尾部的布局
    [self.footLayoutInfo enumerateKeysAndObjectsUsingBlock:^(NSIndexPath *indexPath, UICollectionViewLayoutAttributes *attribute, BOOL *stop) {
        if (CGRectIntersectsRect(rect, attribute.frame)) {
            [allAttributes addObject:attribute];
        }
    }];
    
    return allAttributes;
}
- (CGSize)collectionViewContentSize
{
    return CGSizeMake(self.collectionView.frame.size.width, MAX(self.startY, self.collectionView.frame.size.height));
}
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    
    CGRect oldBounds = self.collectionView.bounds;
    if (!CGSizeEqualToSize(oldBounds.size, newBounds.size)) {
        return YES;
    }
    return NO;
}

@end
