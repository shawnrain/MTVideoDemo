//
//  YLKit.m
//  封装基本控件
//
//  Created by couba001 on 2017/6/15.
//  Copyright © 2017年 couba. All rights reserved.
//

#import "YLUI.h"

@implementation YLUI
#pragma mark --------------    UILabel   ------------------
+ (UILabel *)labelTextColor:(UIColor *)textColor
                   fontSize:(CGFloat)size
                       text:(NSString *)text
{
    return [YLUI labelWithBackgroundColor:[UIColor clearColor] textColor:textColor textAlignment:NSTextAlignmentLeft numberOfLines:1 text:text fontSize:size];
}

+ (UILabel *)labelWithText:(NSString *)text
                  fontSize:(CGFloat)size
{
    return [YLUI labelWithBackgroundColor:[UIColor clearColor] textColor:[UIColor blackColor] textAlignment:NSTextAlignmentLeft numberOfLines:1 text:text fontSize:size];
}


+ (UILabel *)labelWithTextColor:(UIColor *)textColor
                  numberOfLines:(NSInteger)numberOfLines
                           text:(NSString *)text
                       fontSize:(CGFloat)size
{
    return [YLUI labelWithBackgroundColor:[UIColor clearColor] textColor:textColor textAlignment:NSTextAlignmentLeft numberOfLines:numberOfLines text:text fontSize:size];
}

+ (UILabel *)labelWithBackgroundColor:(UIColor *)backgroundColor
                            textColor:(UIColor *)textColor
                        textAlignment:(NSTextAlignment)textAlignment
                        numberOfLines:(NSInteger)numberOfLines
                                 text:(NSString *)text
                             fontSize:(CGFloat)size
{
    UILabel *label = [[UILabel alloc] init];
    label.backgroundColor = backgroundColor;
    label.textColor = textColor;
    label.textAlignment = textAlignment;
    label.numberOfLines = numberOfLines;
    label.text = text;
    label.font = [UIFont systemFontOfSize:size];
    return label;
}

#pragma mark --------------    UIButton   ------------------
+ (UIButton *)buttonWithImage:(UIImage *)Image
                       Target:(id)target
                       action:(SEL)action
{
    return [YLUI buttonWithType:UIButtonTypeCustom title:nil titleState:UIControlStateNormal titleColor:nil titleColorState:UIControlStateNormal image:Image imageState:UIControlStateNormal backgroundImage:nil backgroundImageState:UIControlStateNormal fontSize:0 backgroundColor:nil Target:target action:action forControlEvents:UIControlEventTouchUpInside];
}

+ (UIButton *)buttonWithImage:(UIImage *)image
                        title:(NSString *)title
                     fontSize:(CGFloat)size
                       Target:(id)target
                       action:(SEL)action
{
    return [YLUI buttonWithType:UIButtonTypeCustom title:title titleState:UIControlStateNormal titleColor:[UIColor blackColor] titleColorState:UIControlStateNormal image:image imageState:UIControlStateNormal backgroundImage:nil backgroundImageState:UIControlStateNormal fontSize:size backgroundColor:nil Target:target action:action forControlEvents:UIControlEventTouchUpInside];
}
+ (UIButton *)buttonWithTitle:(NSString *)title
                   titleColor:(UIColor *)titleColor
                     fontSize:(CGFloat)size
              backgroundImage:(UIImage *)backgroundImage
                       Target:(id)target
                       action:(SEL)action
{
    return [YLUI buttonWithType:UIButtonTypeCustom title:title titleState:UIControlStateNormal titleColor:titleColor titleColorState:UIControlStateNormal image:nil imageState:UIControlStateNormal backgroundImage:backgroundImage backgroundImageState:UIControlStateNormal fontSize:size backgroundColor:nil Target:target action:action forControlEvents:UIControlEventTouchUpInside];
}

+ (UIButton *)buttonWithTitle:(NSString *)title
                   titleColor:(UIColor *)titleColor
                     fontSize:(CGFloat)size
              backgroundColor:(UIColor *)backgroundColor
                       Target:(id)target
                       action:(SEL)action
{
    return [YLUI buttonWithType:UIButtonTypeCustom title:title titleState:UIControlStateNormal titleColor:titleColor titleColorState:UIControlStateNormal image:nil imageState:UIControlStateNormal backgroundImage:nil backgroundImageState:UIControlStateNormal fontSize:size backgroundColor:backgroundColor Target:target action:action forControlEvents:UIControlEventTouchUpInside];
}
+ (UIButton *)buttonWithType:(UIButtonType)buttonType
                        title:(NSString *)title
                  titleState:(UIControlState)titleState
                  titleColor:(UIColor *)titleColor
             titleColorState:(UIControlState)titleColorState
                       image:(UIImage *)image
                  imageState:(UIControlState)imageState
             backgroundImage:(UIImage *)backgroundImage
        backgroundImageState:(UIControlState)backgroundImageState
                    fontSize:(CGFloat)size
             backgroundColor:(UIColor *)backgroundColor
                      Target:(id)target
                      action:(SEL)action
            forControlEvents:(UIControlEvents)controlEvents;

{
    UIButton *button = [UIButton buttonWithType:buttonType];
    button.titleLabel.font = [UIFont systemFontOfSize:size];
    [button setImage:image forState:imageState];
    [button setBackgroundImage:backgroundImage forState:backgroundImageState];
    [button setTitle:title forState:titleState];
    [button setBackgroundColor:backgroundColor];
    [button setTitleColor:titleColor forState:titleColorState];
    [button addTarget:target action:action forControlEvents:controlEvents];
    return button;
}

#pragma mark --------------    UIView   ------------------
+ (UIView *)viewWithBackgroundColor:(UIColor *)backgroundColor
{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = backgroundColor;
    return view;
}

#pragma mark --------------    UIImageView   ------------------
+ (UIImageView *)imageView
{
    return [YLUI imageViewWithImageName:nil contentMode:UIViewContentModeScaleToFill];
}

+ (UIImageView *)imageViewWithName:(NSString *)imageName
{
    return [YLUI imageViewWithImageName:imageName contentMode:UIViewContentModeScaleToFill];
}
+ (UIImageView *)imageViewWithImageName:(NSString *)imageName
                            contentMode:(UIViewContentMode)contentMode
{
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.image = [UIImage imageNamed:imageName];
    imageView.contentMode = contentMode;
    return imageView;
}

#pragma mark --------------    UITableView   ------------------
+ (UITableView *)tableViewWithIdentifier:(NSString *)identifier
{
    return [YLUI tableViewWithStyle:UITableViewStylePlain backgroundColor:nil registerClassCell:[UITableViewCell class] identifier:identifier];
}
+ (UITableView *)tableViewWithStyle:(UITableViewStyle)style
                    backgroundColor:(UIColor *)backgroundColor
                  registerXibCell:(Class)xibCell
                         identifier:(NSString *)identifier
{
    return [YLUI tableViewWithStyle:style backgroundColor:backgroundColor isXib:YES registerCell:xibCell identifier:identifier];
}
+ (UITableView *)tableViewWithStyle:(UITableViewStyle)style
                    backgroundColor:(UIColor *)backgroundColor
                  registerClassCell:(Class)classCell
                         identifier:(NSString *)identifier
{
    return [YLUI tableViewWithStyle:style backgroundColor:backgroundColor isXib:NO registerCell:classCell identifier:identifier];
}
+ (UITableView *)tableViewWithStyle:(UITableViewStyle)style
                    backgroundColor:(UIColor *)backgroundColor
                              isXib:(BOOL)IsXIb
                       registerCell:(Class)cellClass
                         identifier:(NSString *)identifier
{
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:style];
    tableView.backgroundColor = backgroundColor;
    if (IsXIb) {
        [tableView registerNib:[UINib nibWithNibName:NSStringFromClass(cellClass) bundle:nil] forCellReuseIdentifier:identifier];
    }else{
        [tableView registerClass:cellClass forCellReuseIdentifier:identifier];
    }
    
    return tableView;
}
#pragma mark --------------    UICollectionView   ------------------
+ (UICollectionView *)collectionViewWithLayout:(UICollectionViewLayout *)layout
                               backgroundColor:(UIColor *)backgroundColor
                               registerXibCell:(Class)xibCell
                                    identifier:(NSString *)identifier
{
    return [YLUI collectionViewWithLayout:layout backgroundColor:backgroundColor isXib:YES registerCell:xibCell identifier:identifier];
}
+ (UICollectionView *)collectionViewWithLayout:(UICollectionViewLayout *)layout
                               backgroundColor:(UIColor *)backgroundColor
                                  registerClassCell:(Class)classCell
                                    identifier:(NSString *)identifier
{
    return [YLUI collectionViewWithLayout:layout backgroundColor:backgroundColor isXib:NO registerCell:classCell identifier:identifier];
}


+ (UICollectionView *)collectionViewWithLayout:(UICollectionViewLayout *)layout
                               backgroundColor:(UIColor *)backgroundColor
                                         isXib:(BOOL)IsXIb
                                  registerCell:(Class)cellClass
                                    identifier:(NSString *)identifier
{
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    collectionView.backgroundColor = backgroundColor;
    collectionView.showsVerticalScrollIndicator = NO;
    collectionView.showsHorizontalScrollIndicator = NO;
    if (IsXIb) {
        [collectionView registerNib:[UINib nibWithNibName:NSStringFromClass(cellClass) bundle:nil] forCellWithReuseIdentifier:identifier];
    }else{
        [collectionView registerClass:cellClass forCellWithReuseIdentifier:identifier];
    }
    return collectionView;
}
@end
