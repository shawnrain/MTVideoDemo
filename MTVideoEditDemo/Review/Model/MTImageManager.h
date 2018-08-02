//
//  MTImageManager.h
//  MTVideoEditDemo
//
//  Created by MTShawn on 2018/8/2.
//  Copyright © 2018年 MT. All rights reserved.
//

#import <Foundation/Foundation.h>
@class MTAssetsModel;
@interface MTImageManager : NSObject
+(instancetype)manager;
- (void)getCameraRollAlbum:(BOOL)allowPickingVideo allowPickingImage:(BOOL)allowPickingImage needFetchAssets:(BOOL)needFetchAssets completion:(void (^)(PHFetchResult *model))completion;
- (void)getAssetFromFetchResult:(PHFetchResult *)result atIndex:(NSInteger)index completion:(void (^)(MTAssetsModel *))completion;
@end
