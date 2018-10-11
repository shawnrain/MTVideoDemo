//
//  MTVideoEditManager.h
//  MTVideoEdit
//
//  Created by MTShawn on 2018/9/17.
//  Copyright © 2018年 MT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIView+MTScreenHot.h"
typedef void(^completion)(AVAssetExportSession *exporter);
@interface MTVideoEditManager : NSObject
@property (nonatomic, copy) completion   completionBlock;
@property (nonatomic, strong) AVURLAsset  * asset;
@property (nonatomic, strong) AVMutableVideoComposition  * videoComposition;
//存储地址
- (NSURL *)getExportVideoUrl;
//删除制作的视频
+ (void)removeCacheData:(NSString *)cachePath;

/**
 根据传入的transform得到视频成型的size

 @param videoTransform transform
 @return size
 */
- (CGSize)getVideoNaturalSizeWithTransform:(CGAffineTransform)videoTransform;
/**
 文件视频导出到缓存
 
 @param mainCompositionInst mainCompositionInst description
 @param mixComposition mixComposition description
 */
- (void)exportVideoComposition:(AVMutableVideoComposition *)mainCompositionInst composition:(AVMutableComposition *)mixComposition;
/**
 修正保存视频方向更改
 
 @param videoTrack 视频轨道
 @return 返回视频操作的类
 */
- (AVMutableVideoCompositionInstruction *)correctVideoTransformWithvideoTrack:(AVMutableCompositionTrack *)videoTrack;
/**
 保存作品到相册
 
 @param exporter 导出的信息
 @param callBack 回调
 */
+ (void)saveVideoToPhotosWithExpoerSession:(AVAssetExportSession *)exporter callBack:(completion)callBack;

@end
