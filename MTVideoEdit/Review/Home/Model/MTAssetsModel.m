//
//  MTAssetsModel.m
//  wanghong
//
//  Created by MTShawn on 2018/9/11.
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
    [model changePHAssetToAVAsset:model.asset];
    model.timeLength = timeLength;
    return model;
}

- (void)changePHAssetToAVAsset:(PHAsset *)assets{
    kWeakSelf
    PHVideoRequestOptions *options = [[PHVideoRequestOptions alloc] init];
    options.version = PHImageRequestOptionsVersionCurrent;
    options.deliveryMode = PHVideoRequestOptionsDeliveryModeAutomatic;
    PHImageManager *manager = [PHImageManager defaultManager];
    [manager requestAVAssetForVideo:assets options:options resultHandler:^(AVAsset * _Nullable asset, AVAudioMix * _Nullable audioMix, NSDictionary * _Nullable info) {
        weakSelf.AVAsset = (AVURLAsset *)asset;
    }];
}
@end
