//
//  MTImageManager.m
//  MTVideoEditDemo
//
//  Created by MTShawn on 2018/8/2.
//  Copyright © 2018年 MT. All rights reserved.
//

#import "MTImageManager.h"
#import "MTAssetsModel.h"
#import <AssetsLibrary/AssetsLibrary.h>
static MTImageManager *manager;
static dispatch_once_t onceToken;
@implementation MTImageManager

+ (instancetype)manager{
    dispatch_once(&onceToken, ^{
        manager = [[MTImageManager alloc] init];
    });
    return manager;
}
- (void)getCameraRollAlbum:(BOOL)allowPickingVideo allowPickingImage:(BOOL)allowPickingImage needFetchAssets:(BOOL)needFetchAssets completion:(void (^)(PHFetchResult *model))completion{
    PHFetchOptions *option = [[PHFetchOptions alloc] init];
    if (!allowPickingVideo) option.predicate = [NSPredicate predicateWithFormat:@"mediaType == %ld", PHAssetMediaTypeImage];
    if (!allowPickingImage) option.predicate = [NSPredicate predicateWithFormat:@"mediaType == %ld",
                                                PHAssetMediaTypeVideo];
    //最新的照片会显示在最前面
    option.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:NO]];
    
    PHFetchResult *smartAlbums = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    for (PHAssetCollection *collection in smartAlbums) {
        // 有可能是PHCollectionList类的的对象，过滤掉
        if (![collection isKindOfClass:[PHAssetCollection class]]) continue;
        // 过滤空相册
        if (collection.estimatedAssetCount <= 0) continue;
        if ([self isCameraRollAlbum:collection]) {
            PHFetchResult *fetchResult = [PHAsset fetchAssetsInAssetCollection:collection options:option];
            if (completion) completion(fetchResult);
            break;
        }
    }
}


- (void)getAssetFromFetchResult:(PHFetchResult *)result atIndex:(NSInteger)index completion:(void (^)(MTAssetsModel *))completion {
    PHAsset *asset;
    @try {
        asset = result[index];
    }
    @catch (NSException* e) {
        if (completion) completion(nil);
        return;
    }
    MTAssetsModel *model = [self assetModelWithAsset:asset];
    if (completion) completion(model);
}


- (MTAssetsModel *)assetModelWithAsset:(PHAsset *)asset{
    if (asset.mediaType == PHAssetMediaTypeVideo) {
        NSString *timeLength = [NSString stringWithFormat:@"%0.0f",asset.duration];
        timeLength = [self getNewTimeFromDurationSecond:timeLength.integerValue];
        MTAssetsModel * model = [MTAssetsModel modelWithAsset:asset type:PHAssetMediaTypeVideo timeLength:timeLength];
        return model;
    }else if (asset.mediaType == PHAssetMediaTypeImage){
        
    }
    return nil;
}

- (NSString *)getNewTimeFromDurationSecond:(NSInteger)duration {
    NSString *newTime;
    if (duration < 10) {
        newTime = [NSString stringWithFormat:@"0:0%zd",duration];
    } else if (duration < 60) {
        newTime = [NSString stringWithFormat:@"0:%zd",duration];
    } else {
        NSInteger min = duration / 60;
        NSInteger sec = duration - (min * 60);
        if (sec < 10) {
            newTime = [NSString stringWithFormat:@"%zd:0%zd",min,sec];
        } else {
            newTime = [NSString stringWithFormat:@"%zd:%zd",min,sec];
        }
    }
    return newTime;
}
- (BOOL)isCameraRollAlbum:(id)metadata {
    if ([metadata isKindOfClass:[PHAssetCollection class]]) {
        NSString *versionStr = [[UIDevice currentDevice].systemVersion stringByReplacingOccurrencesOfString:@"." withString:@""];
        if (versionStr.length <= 1) {
            versionStr = [versionStr stringByAppendingString:@"00"];
        } else if (versionStr.length <= 2) {
            versionStr = [versionStr stringByAppendingString:@"0"];
        }
        CGFloat version = versionStr.floatValue;
        // 目前已知8.0.0 ~ 8.0.2系统，拍照后的图片会保存在最近添加中
        if (version >= 800 && version <= 802) {
            return ((PHAssetCollection *)metadata).assetCollectionSubtype == PHAssetCollectionSubtypeSmartAlbumRecentlyAdded;
        } else {
            return ((PHAssetCollection *)metadata).assetCollectionSubtype == PHAssetCollectionSubtypeSmartAlbumUserLibrary;
        }
    }
    return NO;
}
@end
