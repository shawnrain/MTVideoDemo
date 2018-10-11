//
//  YLKit.h
//  封装基本控件
//
//  Created by couba001 on 2017/6/15.
//  Copyright © 2017年 couba. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface YLUIKit : NSObject
#pragma mark --------------    UILabel   ------------------

/**
 @param textColor 字色
 @param size 字号
 @param text 文字
 @return UILabel
 */
+ (UILabel *)labelTextColor:(UIColor *)textColor
                   fontSize:(CGFloat)size
                       text:(NSString *)text;

/**
 @param text 文字
 @param size 字号
 @return UILabel
 */
+ (UILabel *)labelWithText:(NSString *)text
                   fontSize:(CGFloat)size;

/**
 @param textColor 字色
 @param numberOfLines 行数
 @param text 文字
 @param size 字号
 @return UILabel
 */
+ (UILabel *)labelWithTextColor:(UIColor *)textColor
                  numberOfLines:(NSInteger)numberOfLines
                           text:(NSString *)text
                       fontSize:(CGFloat)size;

/**
 @param backgroundColor 背景色
 @param textColor 字色
 @param textAlignment 对齐方式
 @param numberOfLines 行数
 @param text 文字
 @param size 字号
 @return UILabel
 */
+ (UILabel *)labelWithBackgroundColor:(UIColor *)backgroundColor
                            textColor:(UIColor *)textColor
                        textAlignment:(NSTextAlignment)textAlignment
                        numberOfLines:(NSInteger)numberOfLines
                                 text:(NSString *)text
                             fontSize:(CGFloat)size;


#pragma mark --------------    UIButton   ------------------

/**
 @param Image 图片
 @param target tagert
 @param action action
 @return UIButton
 */
+ (UIButton *)buttonWithImage:(UIImage *)Image
                       Target:(id)target
                       action:(SEL)action;

/**
 @param image 图片
 @param title 文字
 @param size 文字大小
 @param target tagert
 @param action action
 @return UIButton
 */
+ (UIButton *)buttonWithImage:(UIImage *)image
                        title:(NSString *)title
                    fontSize:(CGFloat)size
                       Target:(id)target
                       action:(SEL)action;

/**
 @param title 文字
 @param titleColor 字色
 @param size 字号
 @param backgroundImage 背景图片
 @param target target
 @param action action
 @return UIButton
 */
+ (UIButton *)buttonWithTitle:(NSString *)title
                   titleColor:(UIColor *)titleColor
                     fontSize:(CGFloat)size
              backgroundImage:(UIImage *)backgroundImage
                       Target:(id)target
                       action:(SEL)action;

/**
 @param title 文字
 @param titleColor 字色
 @param size 字号
 @param backgroundColor 背景颜色
 @param target target
 @param action action
 @return UIButton
 */
+ (UIButton *)buttonWithTitle:(NSString *)title
                   titleColor:(UIColor *)titleColor
                     fontSize:(CGFloat)size
              backgroundColor:(UIColor *)backgroundColor
                       Target:(id)target
                       action:(SEL)action;


/**
 @param buttonType button类型
 @param title 文字
 @param titleState 文字状态
 @param titleColor 字色
 @param titleColorState 字色状态
 @param image 图片
 @param imageState 图片状态
 @param backgroundImage 背景图片
 @param backgroundImageState 背景图片状态
 @param size 字号
 @param backgroundColor 背景颜色
 @param target target
 @param action action
 @param controlEvents controlEvents
 @return UIButton
 */
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


#pragma mark --------------    UIView   ------------------

/**
 @param backgroundColor 背景颜色
 @return UIView
 */
+ (UIView *)viewWithBackgroundColor:(UIColor *)backgroundColor;

#pragma mark --------------    UIImageView   ------------------

/**
 类方法创建UIImageView

 @return UIImageView
 */
+ (UIImageView *)imageView;

/**
 类方法创建UIImageView

 @param imageName UIImageView
 @return UIImageView
 */
+ (UIImageView *)imageViewWithName:(NSString *)imageName;

/**
 类方法创建UIImageView

 @param imageName 图片名字
 @param contentMode 填充方式
 @return UIImageView
 */
+ (UIImageView *)imageViewWithImageName:(NSString *)imageName
                            contentMode:(UIViewContentMode)contentMode;

#pragma mark --------------    UITableView   ------------------

/**
 类方法创建UITableView

 @param identifier 重用标示符
 @return UITableView
 */
+ (UITableView *)tableViewWithIdentifier:(NSString *)identifier;

/**
  类方法创建UITableView 从Xib加载cell

 @param style tableview类型
 @param backgroundColor 背景颜色
 @param xibCell xibCell
 @param identifier 重用标示符
 @return UITableView
 */
+ (UITableView *)tableViewWithStyle:(UITableViewStyle)style
                    backgroundColor:(UIColor *)backgroundColor
                    registerXibCell:(Class)xibCell
                         identifier:(NSString *)identifier;

/**
  类方法创建UITableView 从Class加载cell

 @param style tableview类型
 @param backgroundColor 背景颜色
 @param classCell classCell
 @param identifier 重用标示符
 @return UITableView
 */
+ (UITableView *)tableViewWithStyle:(UITableViewStyle)style
                    backgroundColor:(UIColor *)backgroundColor
                  registerClassCell:(Class)classCell
                         identifier:(NSString *)identifier;

/**
  类方法创建UITableView

 @param style tableview类型
 @param backgroundColor 背景颜色
 @param IsXIb 是否从Xib加载Cell
 @param cellClass cellClass
 @param identifier 重用标示符
 @return UITableView
 */
+ (UITableView *)tableViewWithStyle:(UITableViewStyle)style
                    backgroundColor:(UIColor *)backgroundColor
                              isXib:(BOOL)IsXIb
                       registerCell:(Class)cellClass
                         identifier:(NSString *)identifier;


#pragma mark --------------    UICollectionView   ------------------

/**
  类方法创建UICollectionView 从Xib加载cell

 @param layout 布局
 @param backgroundColor 背景颜色
 @param xibCell xibCell
 @param identifier identifier
 @return UICollectionView
 */
+ (UICollectionView *)collectionViewWithLayout:(UICollectionViewLayout *)layout
                               backgroundColor:(UIColor *)backgroundColor
                               registerXibCell:(Class)xibCell
/**
类方法创建UICollectionView 从Class加载cell

@param layout 布局
@param backgroundColor 背景颜色
@param classCell classCell
@param identifier identifier
@return UICollectionView
*/                                    identifier:(NSString *)identifier;
+ (UICollectionView *)collectionViewWithLayout:(UICollectionViewLayout *)layout
                               backgroundColor:(UIColor *)backgroundColor
                             registerClassCell:(Class)classCell
                                    identifier:(NSString *)identifier;

/**
 类方法创建UICollectionView
 
 @param layout 布局
 @param backgroundColor 背景颜色
 @param IsXIb 是否从Xib加载Cell
 @param cellClass cellClass
 @param identifier 重用标示符
 @return UICollectionView
 */
+ (UICollectionView *)collectionViewWithLayout:(UICollectionViewLayout *)layout
                               backgroundColor:(UIColor *)backgroundColor
                                         isXib:(BOOL)IsXIb
                                  registerCell:(Class)cellClass
                                    identifier:(NSString *)identifier;
@end
