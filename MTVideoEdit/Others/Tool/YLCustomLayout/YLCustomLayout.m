//
//  YLCustomLayout.m
//  YHCustomLayoutExample
//
//  Created by cy on 2018/6/6.
//  Copyright © 2018年 cmapu. All rights reserved.
//

#import "YLCustomLayout.h"
NSString *const YLCollectionElementKindSectionHeader = @"UICollectionElementKindSectionHeader";
NSString *const YLCollectionElementKindSectionFooter = @"UICollectionElementKindSectionFooter";
@interface  YLCustomLayout ()
@property (nonatomic) YLCustomLayoutType layoutType;
/// 保存头视图的布局
@property (nonatomic, strong) NSMutableDictionary *headersAttribute;
/// 保存尾视图的布局
@property (nonatomic, strong) NSMutableDictionary *footersAttribute;
/// 记录瀑布流每列最下面那个cell的底部y值
@property (strong, nonatomic) NSMutableDictionary *maxYForColumn;
/// 存放每一个itme的属性 包括头部和尾部视图
@property (nonatomic, strong) NSMutableArray *attributesArray;
/// 保存每个column的高度
@property (nonatomic, strong) NSMutableArray *columnHeights;
/// Array of arrays. Each array stores item attributes for each section
@property (nonatomic, strong) NSMutableArray *sectionItemAttributes;
@end
@implementation YLCustomLayout
- (NSMutableDictionary *)headersAttribute {
    if (!_headersAttribute) {
        _headersAttribute = [NSMutableDictionary dictionary];
    }
    return _headersAttribute;
}

- (NSMutableDictionary *)footersAttribute {
    if (!_footersAttribute) {
        _footersAttribute = [NSMutableDictionary dictionary];
    }
    return _footersAttribute;
}
- (NSMutableArray *)columnHeights {
    if (!_columnHeights) {
        _columnHeights = [NSMutableArray array];
    }
    return _columnHeights;
}
- (NSMutableArray *)attributesArray
{
    if (!_attributesArray) {
        _attributesArray = [NSMutableArray new];
    }
    return _attributesArray;
}
- (NSMutableArray *)sectionItemAttributes {
    if (!_sectionItemAttributes) {
        _sectionItemAttributes = [NSMutableArray array];
    }
    return _sectionItemAttributes;
}
- (NSInteger)numberOfColumnsInSection:(NSInteger)section {
    if ([self.collectionView.delegate respondsToSelector:@selector(collectionView:layout:numberOfColumnsInSection:)]) {
        return [(id<YLCustomLayoutDelegate>)self.collectionView.delegate collectionView:self.collectionView layout:self numberOfColumnsInSection:section];
    } else {
        return self.numberOfColumns;
    }
}
- (UIEdgeInsets)insetForSectionAtIndex:(NSInteger)section
{
    if ([self.collectionView.delegate respondsToSelector:@selector(collectionView:layout:insetForSectionAtIndex:)]) {
        return [(id<YLCustomLayoutDelegate>)self.collectionView.delegate collectionView:self.collectionView layout:self insetForSectionAtIndex:section];
    }else{
        return self.sectionInset;
    }
}

- (CGFloat)horizontalSpacingForSectionAtIndex:(NSInteger)section
{
    if ([self.collectionView.delegate respondsToSelector:@selector(collectionView:layout:horizontalSpacingForSectionAtIndex:)]) {
        return [(id<YLCustomLayoutDelegate>)self.collectionView.delegate collectionView:self.collectionView layout:self horizontalSpacingForSectionAtIndex:section];
    }else{
        return self.horizontalSpacing;
    }
}
- (CGFloat)verticalSpacingForSectionAtIndex:(NSInteger)section
{
    if ([self.collectionView.delegate respondsToSelector:@selector(collectionView:layout:verticalSpacingForSectionAtIndex:)]) {
        return [(id<YLCustomLayoutDelegate>)self.collectionView.delegate collectionView:self.collectionView layout:self verticalSpacingForSectionAtIndex:section];
    }else{
        return self.verticalSpacing;
    }
}

- (CGFloat)heightForHeaderInSection:(NSInteger)section
{
    if ([self.collectionView.delegate respondsToSelector:@selector(collectionView:layout:heightForHeaderInSection:)]) {
        return [(id<YLCustomLayoutDelegate>)self.collectionView.delegate collectionView:self.collectionView layout:self heightForHeaderInSection:section];
    }else{
        return self.headerReferenceHeight;
    }
}

- (CGFloat)heightForFooterInSection:(NSInteger)section
{
    if ([self.collectionView.delegate respondsToSelector:@selector(collectionView:layout:heightForFooterInSection:)]) {
        return [(id<YLCustomLayoutDelegate>)self.collectionView.delegate collectionView:self.collectionView layout:self heightForFooterInSection:section];
    }else{
        return self.footerReferenceHeight;
    }
}
- (CGSize)sizeForItemAtIndexPath:(NSIndexPath *)indexPath itemWidth:(CGFloat)itemWidth
{
    if ([self.collectionView.delegate respondsToSelector:@selector(collectionView:layout:sizeForItemAtIndexPath:itemWidth:)]) {
        CGSize size = [(id<YLCustomLayoutDelegate>)self.collectionView.delegate collectionView:self.collectionView layout:self sizeForItemAtIndexPath:indexPath itemWidth:itemWidth];
        if (self.layoutType == YLCustomLayoutTypeWaterFlow) {
            return CGSizeMake(itemWidth, size.height);
        }else{
            return size;
        }
    }else{
        if (self.layoutType == YLCustomLayoutTypeWaterFlow) {
            return CGSizeMake(itemWidth, self.itemSize.height);
        }else{
            return self.itemSize;
        }
    }
}
- (instancetype)initWithType:(YLCustomLayoutType)type
{
    self = [super init];
    if (self) {
        self.verticalSpacing = 10;
        self.horizontalSpacing = 10;
        self.footerReferenceHeight = 0;
        self.headerReferenceHeight = 0;
        self.numberOfColumns = 2;
        self.sectionInset = UIEdgeInsetsZero;
        self.layoutType = type;
        self.itemSize = CGSizeMake(90,100);
        self.scrollDirection = YLCustomLayoutScrollDirectionVertical;
    }
    return self;
}
- (void)prepareLayout
{
    [super prepareLayout];
    [self.headersAttribute removeAllObjects];
    [self.footersAttribute removeAllObjects];
    [self.columnHeights removeAllObjects];
    [self.sectionItemAttributes removeAllObjects];
    [self.attributesArray removeAllObjects];
    
    CGFloat top = 0;
    NSUInteger sectionsCount = [self.collectionView numberOfSections];
    for (NSInteger section = 0; section < sectionsCount; section++) {
        NSInteger columnCount = [self numberOfColumnsInSection:section];
        NSMutableArray *sectionColumnHeights = [NSMutableArray arrayWithCapacity:columnCount];
        for (int i = 0; i < columnCount; ++i) {
            [sectionColumnHeights addObject:@(0)];
        }
        [self.columnHeights addObject:sectionColumnHeights];
    }
    
    for (NSInteger section = 0; section < sectionsCount; ++section) {
        NSInteger numberOfColumns = [self numberOfColumnsInSection:section];
        UIEdgeInsets sectionInset = [self insetForSectionAtIndex:section];
        CGFloat headerHeight = [self heightForHeaderInSection:section];
        CGFloat footerHeight = [self heightForFooterInSection:section];
        CGFloat horizontalSpacing = [self horizontalSpacingForSectionAtIndex:section];
        CGFloat verticalSpacing = [self verticalSpacingForSectionAtIndex:section];
        
        //section header
        if (headerHeight > 0 && [self.collectionView.dataSource respondsToSelector:@selector(collectionView: viewForSupplementaryElementOfKind: atIndexPath:)]) {
            UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForSupplementaryViewOfKind:YLCollectionElementKindSectionHeader withIndexPath:[NSIndexPath indexPathForRow:0 inSection:section]];
            
            CGRect rect = self.scrollDirection == YLCustomLayoutScrollDirectionVertical ? CGRectMake(0, top, self.collectionView.frame.size.width, [self heightForHeaderInSection:section]) : CGRectMake(top, 0, [self heightForHeaderInSection:section],self.collectionView.bounds.size.height);
            attributes.frame = rect;
            [self.attributesArray addObject:attributes];
        }
        top += self.scrollDirection == YLCustomLayoutScrollDirectionVertical ? (sectionInset.top + headerHeight) : (sectionInset.left + headerHeight);
        for (int i = 0; i < numberOfColumns; ++i) {
            self.columnHeights[section][i] = @(top);
        }
        
        //section Items
        NSInteger rowCount = [self.collectionView numberOfItemsInSection:section];
        NSMutableArray *itemAttributes = [NSMutableArray new];
        for (NSInteger row = 0; row < rowCount; ++row) {
            UICollectionViewLayoutAttributes *attribute = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:[NSIndexPath indexPathForItem:row inSection:section]];
            NSUInteger columnIndex = [self shortestColumnIndexInSection:section];
            CGFloat itemWidth = self.scrollDirection == YLCustomLayoutScrollDirectionVertical ? ((self.collectionView.bounds.size.width -sectionInset.left - sectionInset.right - (numberOfColumns -1) *horizontalSpacing)/numberOfColumns) :((self.collectionView.bounds.size.height - sectionInset.top - sectionInset.bottom - (numberOfColumns - 1) * verticalSpacing)/numberOfColumns);
            
            
            CGSize itemSize = [self sizeForItemAtIndexPath:[NSIndexPath indexPathForRow:row inSection:section] itemWidth:itemWidth];
            CGFloat x = self.scrollDirection == YLCustomLayoutScrollDirectionVertical ?   (sectionInset.left+ (horizontalSpacing + itemWidth)*columnIndex) : [self.columnHeights[section][columnIndex] floatValue];
            CGFloat y = self.scrollDirection == YLCustomLayoutScrollDirectionVertical ?   [self.columnHeights[section][columnIndex] floatValue] : (sectionInset.top+ (horizontalSpacing + itemWidth)*columnIndex);
            CGRect rect = self.scrollDirection == YLCustomLayoutScrollDirectionVertical ?  CGRectMake(x, y, itemWidth, itemSize.height) :CGRectMake(x, y, itemSize.height,itemWidth);
            [self.attributesArray addObject:attribute];
            attribute.frame = rect;
            self.columnHeights[section][columnIndex] = self.scrollDirection == YLCustomLayoutScrollDirectionVertical ? @(CGRectGetMaxY(attribute.frame) + verticalSpacing) : @(CGRectGetMaxX(attribute.frame) + horizontalSpacing);
            [itemAttributes addObject:attribute];
        }
        [self.sectionItemAttributes addObject:itemAttributes];
        
        //section fotter
        NSUInteger columnIndex = [self longestColumnIndexInSection:section];
        top = self.scrollDirection == YLCustomLayoutScrollDirectionVertical ? ([self.columnHeights[section][columnIndex] floatValue] - verticalSpacing + sectionInset.bottom) : ([self.columnHeights[section][columnIndex] floatValue] - horizontalSpacing + sectionInset.right);
        if (footerHeight > 0 && [self.collectionView.dataSource respondsToSelector:@selector(collectionView: viewForSupplementaryElementOfKind: atIndexPath:)]) {
            UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForSupplementaryViewOfKind:YLCollectionElementKindSectionFooter withIndexPath:[NSIndexPath indexPathForRow:0 inSection:section]];
            CGRect rect = self.scrollDirection == YLCustomLayoutScrollDirectionVertical ? (CGRectMake(0, top, self.collectionView.frame.size.width, footerHeight)) : (CGRectMake(top, 0, footerHeight,self.collectionView.frame.size.height));
            attributes.frame = rect;
            [self.attributesArray addObject:attributes];
            top =  self.scrollDirection == YLCustomLayoutScrollDirectionVertical ? (CGRectGetMaxY(attributes.frame)) : (CGRectGetMaxX(attributes.frame));
        }
        for (int i = 0; i < numberOfColumns; ++i) {
            self.columnHeights[section][i] = @(top);
        }
    }
}
- (CGSize)collectionViewContentSize {
    NSInteger numberOfSections = [self.collectionView numberOfSections];
    if (numberOfSections == 0) {
        return CGSizeZero;
    }
    CGSize contentSize = self.collectionView.bounds.size;
    if (self.scrollDirection == YLCustomLayoutScrollDirectionVertical) {
        contentSize.height = [[[self.columnHeights lastObject] firstObject] floatValue];
    }else{
        contentSize.width = [[[self.columnHeights lastObject] firstObject] floatValue];
    }
    
    return contentSize;
}
- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    if (!_attributesArray) {
        return [super layoutAttributesForElementsInRect:rect];
    } else {
        return _attributesArray;
    }
}
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section >= [self.sectionItemAttributes count]) {
        return nil;
    }
    if (indexPath.item >= [self.sectionItemAttributes[indexPath.section] count]) {
        return nil;
    }
    return (self.sectionItemAttributes[indexPath.section])[indexPath.item];
}
- (NSUInteger)shortestColumnIndexInSection:(NSInteger)section {
    __block NSUInteger index = 0;
    __block CGFloat shortestHeight = MAXFLOAT;
    [self.columnHeights[section] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        CGFloat height = [obj floatValue];
        if (height < shortestHeight) {
            shortestHeight = height;
            index = idx;
        }
    }];
    return index;
}
- (NSUInteger)longestColumnIndexInSection:(NSInteger)section {
    __block NSUInteger index = 0;
    __block CGFloat longestHeight = 0;
    [self.columnHeights[section] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        CGFloat height = [obj floatValue];
        if (height > longestHeight) {
            longestHeight = height;
            index = idx;
        }
    }];
    return index;
}
@end
