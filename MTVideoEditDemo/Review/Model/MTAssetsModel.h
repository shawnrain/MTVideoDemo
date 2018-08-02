//
//  MTAssetsModel.h
//  MTVideoEditDemo
//
//  Created by MTShawn on 2018/8/2.
//  Copyright © 2018年 MT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MTAssetsModel : NSObject
@property (nonatomic, strong) PHAsset * asset;
@property (nonatomic, assign) BOOL isSelected;      ///< The select status of a photo, default is No
@property (nonatomic, assign) PHAssetMediaType type;
@property (assign, nonatomic) BOOL needOscillatoryAnimation;
@property (nonatomic, copy) NSString *timeLength;
@property (strong, nonatomic) UIImage *cachedImage;

/// Init a photo dataModel With a asset
/// 用一个PHAsset/ALAsset实例，初始化一个照片模型
+ (instancetype)modelWithAsset:(PHAsset *)asset type:(PHAssetMediaType)type;
+ (instancetype)modelWithAsset:(PHAsset *)asset type:(PHAssetMediaType)type timeLength:(NSString *)timeLength;
@end
