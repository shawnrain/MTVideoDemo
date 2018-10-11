//
//  LoadView.h
//  QzoneUp
//
//  Created by fuguangxin on 16/8/30.
//  Copyright © 2016年 fuguangxin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LoadView;
@protocol LoadViewDelegate <NSObject>

- (void)loadViewRequestButtonBeClicked:(LoadView *)loadView;

@end

@interface LoadView : UIView

@property (nonatomic, weak) id<LoadViewDelegate> delegate;

- (void)showLoading;
- (void)showFailed;
- (void)dismiss;

@end
