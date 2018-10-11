//
//  MTVideoEditToImgsManager.m
//  MTVideoEdit
//
//  Created by MTShawn on 2018/9/18.
//  Copyright © 2018年 MT. All rights reserved.
//

#import "MTVideoEditToImgsManager.h"
#import <AssetsLibrary/AssetsLibrary.h>
@implementation MTVideoEditToImgsManager

/**
 视频转图片

 @param assets 视频数据源
 @param callback 回调 
 */
+ (void)videoToImgs:(AVURLAsset *)assets calllBack:(void(^)(BOOL success))callback{
    dispatch_group_t group = dispatch_group_create();
    dispatch_queue_t queue = dispatch_queue_create("createImages", DISPATCH_QUEUE_SERIAL);

    AVAssetImageGenerator *imageGenerator = [[AVAssetImageGenerator alloc] initWithAsset:assets];
    imageGenerator.appliesPreferredTrackTransform = YES;//图片旋转
    imageGenerator.maximumSize = CGSizeMake(KSCREENWIDTH, KSCREENHEIGHT);
    imageGenerator.apertureMode = AVAssetImageGeneratorApertureModeEncodedPixels;
    NSInteger seconds = CMTimeGetSeconds(assets.duration);
    CMTime time = kCMTimeZero;
    NSMutableArray *times = [NSMutableArray array];
    __block NSMutableArray * images = [[NSMutableArray alloc]initWithCapacity:0];
    for (NSUInteger i = 0; i < seconds; i++) {
        [times addObject:[NSValue valueWithCMTime:time]];
        time = CMTimeMake(i, 1);
        dispatch_group_enter(group);
    }
    [imageGenerator generateCGImagesAsynchronouslyForTimes:times
                                          completionHandler:^(CMTime requestedTime,                                                                                      CGImageRef cgImage,CMTime actualTime,AVAssetImageGeneratorResult result,NSError *error) {
        if (cgImage) {
            UIImage *image = [UIImage imageWithCGImage:cgImage];
            dispatch_group_leave(group);
            if (image) {
                [images addObject:image];
            }
        }
    }];
    dispatch_group_notify(group, queue, ^{
        [self saveImagesToLib:images calllBack:callback];
    });
}
+ (void)saveImagesToLib:(NSArray *)images calllBack:(void(^)(BOOL success))callback{
    dispatch_group_t group = dispatch_group_create();
    dispatch_queue_t queue = dispatch_get_main_queue();
    for (UIImage * image in images) {
        dispatch_group_enter(group);
        [self saveImgsToLibrary:image saveCallBack:^(BOOL saveImgSuccess) {
            if (!saveImgSuccess) {
                if (callback) {
                    callback(false);
                }
            }
            dispatch_group_leave(group);
        }];
    }
    dispatch_group_notify(group, queue, ^{
        if (callback) {
            callback(true);
        }
    });
}

+ (void)saveImgsToLibrary:(UIImage *)image saveCallBack:(void(^)(BOOL saveImgSuccess))saveCallBack{
    PHAuthorizationStatus authorizationStatus = [PHPhotoLibrary authorizationStatus];
    NSLog(@"=======image.imageOrientation==%ld",image.imageOrientation);
    NSLog(@"======= image.size  wdith = %.2f height = %.2f",image.size.width,image.size.height);
    NSString *collectionName = @"视频截图";
    if (authorizationStatus == PHAuthorizationStatusAuthorized) {
        PHPhotoLibrary *library = [PHPhotoLibrary sharedPhotoLibrary];
        [library performChanges:^{
            PHAssetCollectionChangeRequest *collectionRequest;
            PHAssetCollection *assetCollection = [self getCurrentPhotoCollectionWithTitle:collectionName];
            if (assetCollection) {
                collectionRequest = [PHAssetCollectionChangeRequest changeRequestForAssetCollection:assetCollection];
            } else {
                collectionRequest = [PHAssetCollectionChangeRequest creationRequestForAssetCollectionWithTitle:collectionName];
            }
            PHAssetChangeRequest *assetRequest = [PHAssetChangeRequest creationRequestForAssetFromImage:image];
            PHObjectPlaceholder *placeholder = [assetRequest placeholderForCreatedAsset];
            [collectionRequest addAssets:@[placeholder]];
        } completionHandler:^(BOOL success, NSError * _Nullable error) {
            if (saveCallBack) {
                saveCallBack(success);
            }
        }];
    }else{
        if (saveCallBack) {
            saveCallBack(false);
        }
    }
}
+ (PHAssetCollection *)getCurrentPhotoCollectionWithTitle:(NSString *)collectionName {
    // 1. 创建搜索集合
    PHFetchResult *result = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    
    for (PHAssetCollection *assetCollection in result) {
        if ([assetCollection.localizedTitle containsString:collectionName]) {
            return assetCollection;
        }
    }
    return nil;
}

@end
