//
//  MTAssetsModel.m
//  MTVideoEditDemo
//
//  Created by MTShawn on 2018/8/2.
//  Copyright © 2018年 MT. All rights reserved.
//

#import "MTAssetsModel.h"

@implementation MTAssetsModel
+ (instancetype)modelWithAsset:(id)asset type:(PHAssetMediaType)type{
    MTAssetsModel *model = [[MTAssetsModel alloc] init];
    model.asset = asset;
    model.isSelected = NO;
    model.type = type;
    return model;
}

+ (instancetype)modelWithAsset:(id)asset type:(PHAssetMediaType)type timeLength:(NSString *)timeLength {
    MTAssetsModel *model = [self modelWithAsset:asset type:type];
    model.timeLength = timeLength;
    return model;
}
@end
