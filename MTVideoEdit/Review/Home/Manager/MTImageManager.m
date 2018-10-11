//
//  MTImageManager.m
//  wanghong
//
//  Created by MTShawn on 2018/9/11.
//  Copyright © 2018年 MT. All rights reserved.
//

#import "MTImageManager.h"
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
    if (duration < 60) {
        newTime = [NSString stringWithFormat:@"00:%02zd",duration];
    } else {
        NSInteger min = duration / 60;
        NSInteger sec = duration - (min * 60);
        if (sec < 60) {
            newTime = [NSString stringWithFormat:@"%02zd:%02zd",min,sec];
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
- (int32_t)getPhotoWithAsset:(id)asset photoWidth:(CGFloat)photoWidth completion:(void (^)(UIImage *photo,NSDictionary *info,BOOL isDegraded))completion progressHandler:(void (^)(double progress, NSError *error, BOOL *stop, NSDictionary *info))progressHandler networkAccessAllowed:(BOOL)networkAccessAllowed {
    /*
     if ([asset isKindOfClass:[PHAsset class]]) {
     CGSize imageSize;
     PHAsset *phAsset = (PHAsset *)asset;
     CGFloat aspectRatio = phAsset.pixelWidth / (CGFloat)phAsset.pixelHeight;
     CGFloat pixelWidth = photoWidth * TZScreenScale * 1.5;
     // 超宽图片
     if (aspectRatio > 1.8) {
     pixelWidth = pixelWidth * aspectRatio;
     }
     // 超高图片
     if (aspectRatio < 0.2) {
     pixelWidth = pixelWidth * 0.5;
     }
     CGFloat pixelHeight = pixelWidth / aspectRatio;
     imageSize = CGSizeMake(pixelWidth, pixelHeight);
     
     __block UIImage *image;
     // 修复获取图片时出现的瞬间内存过高问题
     // 下面两行代码，来自hsjcom，他的github是：https://github.com/hsjcom 表示感谢
     PHImageRequestOptions *option = [[PHImageRequestOptions alloc] init];
     option.resizeMode = PHImageRequestOptionsResizeModeFast;
     int32_t imageRequestID = [[PHImageManager defaultManager] requestImageForAsset:asset targetSize:imageSize contentMode:PHImageContentModeAspectFill options:option resultHandler:^(UIImage *result, NSDictionary *info) {
     if (result) {
     image = result;
     }
     BOOL downloadFinined = (![[info objectForKey:PHImageCancelledKey] boolValue] && ![info objectForKey:PHImageErrorKey]);
     if (downloadFinined && result) {
     result = [UIImage fixOrientation:result];
     if (completion) completion(result,info,[[info objectForKey:PHImageResultIsDegradedKey] boolValue]);
     }
     // Download image from iCloud / 从iCloud下载图片
     if ([info objectForKey:PHImageResultIsInCloudKey] && !result && networkAccessAllowed) {
     PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
     options.progressHandler = ^(double progress, NSError *error, BOOL *stop, NSDictionary *info) {
     dispatch_async(dispatch_get_main_queue(), ^{
     if (progressHandler) {
     progressHandler(progress, error, stop, info);
     }
     });
     };
     options.networkAccessAllowed = YES;
     options.resizeMode = PHImageRequestOptionsResizeModeFast;
     [[PHImageManager defaultManager] requestImageDataForAsset:asset options:options resultHandler:^(NSData *imageData, NSString *dataUTI, UIImageOrientation orientation, NSDictionary *info) {
     UIImage *resultImage = [UIImage imageWithData:imageData scale:0.1];
     if (![TZImagePickerConfig sharedInstance].notScaleImage) {
     resultImage = [UIImage scaleImage:resultImage toSize:imageSize];
     }
     if (!resultImage) {
     resultImage = image;
     }
     resultImage = [UIImage fixOrientation:resultImage];
     if (completion) completion(resultImage,info,NO);
     }];
     }
     }];
     return imageRequestID;
     }*/
    return 0;
}
@end
