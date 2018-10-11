//
//  MTVideoEditViewController.h
//  MTVideoEdit
//
//  Created by MTShawn on 2018/9/17.
//  Copyright © 2018年 MT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MTAssetsModel.h"
@interface MTVideoEditViewController : UIViewController
@property (nonatomic, strong) MTAssetsModel  * asset;
@property (nonatomic, assign) MTVideoOperateType  type;
@end
