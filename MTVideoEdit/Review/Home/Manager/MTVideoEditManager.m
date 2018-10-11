//
//  MTVideoEditManager.m
//  MTVideoEdit
//
//  Created by MTShawn on 2018/9/17.
//  Copyright © 2018年 MT. All rights reserved.
//

#import "MTVideoEditManager.h"
#import "SPUserInfo.h"
@implementation MTVideoEditManager
/**
 根据传入的transform得到视频成型的size
 
 @param videoTransform transform
 @return size
 */
- (CGSize)getVideoNaturalSizeWithTransform:(CGAffineTransform)videoTransform{
    AVAssetTrack * videoTrack = [self.asset tracksWithMediaType:AVMediaTypeVideo].firstObject;
    BOOL isVideoAssetPortrait_  = NO;
    if (videoTransform.a == 0 && videoTransform.b == 1.0 && videoTransform.c == -1.0 && videoTransform.d == 0) {
        isVideoAssetPortrait_ = YES;
    }
    if (videoTransform.a == 0 && videoTransform.b == -1.0 && videoTransform.c == 1.0 && videoTransform.d == 0) {
        isVideoAssetPortrait_ = YES;
    }
    CGSize naturalSize;
    if(isVideoAssetPortrait_){
        naturalSize = CGSizeMake(videoTrack.naturalSize.height, videoTrack.naturalSize.width);
    } else {
        naturalSize = videoTrack.naturalSize;
    }
    return naturalSize;
}
/**
 文件视频导出
 
 @param mainCompositionInst mainCompositionInst description
 @param mixComposition mixComposition description
 */
- (void)exportVideoComposition:(AVMutableVideoComposition *)mainCompositionInst composition:(AVMutableComposition *)mixComposition {
    NSURL * videoUrl = [self getExportVideoUrl];
    NSLog(@"outputUrl==== %@",videoUrl);
    // 5 - 视频文件输出
    AVAssetExportSession *exporter = [[AVAssetExportSession alloc] initWithAsset:mixComposition
                                                                      presetName:AVAssetExportPresetHighestQuality];
    exporter.outputURL=videoUrl;
    exporter.outputFileType = AVFileTypeQuickTimeMovie;
    exporter.shouldOptimizeForNetworkUse = YES;
    if (mainCompositionInst) {
        exporter.videoComposition = mainCompositionInst;
    }
    [exporter exportAsynchronouslyWithCompletionHandler:^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [self exportDidFinish:exporter];
        });
    }];
}
/**
 视频操作状态反馈
 
 @param session 视频导出的相关信息
 */
- (void)exportDidFinish:(AVAssetExportSession*)session{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [MTVideoEditManager saveVideoToPhotosWithExpoerSession:session callBack:self.completionBlock];
    });
    
//    if (self.completionBlock) {
//        self.completionBlock(session);
//    }
}
/**
 修正保存视频方向更改
 
 @param videoTrack 视频轨道
 @return 返回视频操作的类
 */
- (AVMutableVideoCompositionInstruction *)correctVideoTransformWithvideoTrack:(AVMutableCompositionTrack *)videoTrack{
    AVMutableVideoCompositionInstruction *instruction = [AVMutableVideoCompositionInstruction videoCompositionInstruction];
    //视频素材
    AVMutableVideoCompositionLayerInstruction *layerInstruction = [AVMutableVideoCompositionLayerInstruction videoCompositionLayerInstructionWithAssetTrack:videoTrack];
    
    AVAssetTrack *sourceVideoTrack = [[self.asset tracksWithMediaType:AVMediaTypeVideo] objectAtIndex:0];
    
    CGAffineTransform rotationTransform = CGAffineTransformMakeRotation(M_PI/2);
    CGAffineTransform rotateTranslate = CGAffineTransformTranslate(rotationTransform,320,0);
    
    [videoTrack setPreferredTransform:sourceVideoTrack.preferredTransform];
    [layerInstruction setTransform:rotateTranslate atTime:kCMTimeZero];
    
    instruction.layerInstructions = [NSArray arrayWithObject: layerInstruction];
    return instruction;
}
//存储地址
- (NSURL *)getExportVideoUrl{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"videos"];
    NSString * videoName = [NSString stringWithFormat:@"%.0f",[[NSDate date] timeIntervalSince1970]];
    NSFileManager * fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:documentsDirectory]) {
        [fileManager createDirectoryAtPath:documentsDirectory withIntermediateDirectories:YES attributes:nil error:nil];
    }
    NSString *myPathDocs =  [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.mp4",videoName]];
    unlink([myPathDocs UTF8String]);
    NSURL* videoUrl = [NSURL fileURLWithPath:myPathDocs];
    return videoUrl;
}
//删除制作的视频
+ (void)removeCacheData:(NSString *)cachePath{
    NSFileManager * fileManeger = [NSFileManager defaultManager];
    if ([fileManeger fileExistsAtPath:cachePath]) {
        NSError * error = nil;
        BOOL removeStatus = [fileManeger removeItemAtPath:cachePath error:&error];
        if (error) {
            
        }
        if (removeStatus) {
            
        }
    }
}
/**
 保存作品到相册
 
 @param exporter 导出的信息
 @param callBack 回调
 */
+ (void)saveVideoToPhotosWithExpoerSession:(AVAssetExportSession *)exporter callBack:(completion)callBack{
    if (exporter.status == AVAssetExportSessionStatusCompleted) {
        NSURL *outputURL = exporter.outputURL;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            __block PHObjectPlaceholder *placeholder;
            if (UIVideoAtPathIsCompatibleWithSavedPhotosAlbum(outputURL.path)) {
                NSError *error;
                [[PHPhotoLibrary sharedPhotoLibrary] performChangesAndWait:^{
                    PHAssetChangeRequest* createAssetRequest = [PHAssetChangeRequest creationRequestForAssetFromVideoAtFileURL:outputURL];
                    placeholder = [createAssetRequest placeholderForCreatedAsset];
                } error:&error];
                if (callBack) {
                    callBack(exporter);
                }
                NSString * messageStr = [NSString stringWithFormat:@"您的视频已保存到本地==%@",[[NSDate date]yl_stringWithFormat:@"HH:mm"]];
                [[SPUserInfo shareInstance].messageArray insertObject:messageStr atIndex:0];
                [SPUserInfo archiveUserInstance];
            }else {
                if (callBack) {
                    callBack(exporter);
                }
            }
        });
    }else{
        if (callBack) {
            callBack(exporter);
        }
    }
}
@end
