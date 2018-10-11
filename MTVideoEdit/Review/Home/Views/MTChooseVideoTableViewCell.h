//
//  MTChooseVideoTableViewCell.h
//  wanghong
//
//  Created by MTShawn on 2018/9/11.
//  Copyright © 2018年 MT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MTAssetsModel.h"
@interface MTChooseVideoTableViewCell : UITableViewCell
@property (nonatomic, strong) MTAssetsModel  * model;
@property (nonatomic, strong) NSIndexPath  * indexPath;
@property (nonatomic, assign) BOOL  videoIsSelected;
@end
