//
//  UIViewController+videoSave.m
//  MTVideoEditDemo
//
//  Created by MTShawn on 2018/7/31.
//  Copyright © 2018年 MT. All rights reserved.
//

#import "UIViewController+videoSave.h"
#import <objc/runtime.h>
#import "UIViewController+MTVideoHelper.h"

@interface UIViewController ()
@property (nonatomic, copy) void (^completionBlock)(AVAssetExportSessionStatus status,NSURL * videoUrl);
@property (nonatomic, copy) NSString  * lCacheUrl;

@end

@implementation UIViewController (videoSave)

//- (AVAssetExportSession *)exporter{
//    return objc_getAssociatedObject(self, @selector(exporter));
//}
//- (void)setExporter:(AVAssetExportSession *)exporter{
//    objc_setAssociatedObject(self, @selector(exporter), exporter, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
//}
- (NSString *)lCacheUrl{
    return objc_getAssociatedObject(self, @selector(lCacheUrl));
}
- (void)setLCacheUrl:(NSString *)lCacheUrl{
    objc_setAssociatedObject(self, @selector(lCacheUrl), lCacheUrl, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
- (void (^)(AVAssetExportSessionStatus status,NSURL * videoUrl))completionBlock{
    return objc_getAssociatedObject(self, @selector(completionBlock));
}
- (void)setCompletionBlock:(void (^)(AVAssetExportSessionStatus status,NSURL * videoUrl))completionBlock{
    objc_setAssociatedObject(self, @selector(completionBlock), completionBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
/**
 截取视频并添加背景音乐
 
 @param audioAsset 音频数据
 @param videoRange 截取的范围
 @param completionBlock 回调
 */
- (void)videoAddBackGroundMusic:(AVURLAsset *)audioAsset captureVideoWithRange:(NSRange)videoRange completion:(void (^)(AVAssetExportSessionStatus status,NSURL * videoUrl))completionBlock{
    AVMutableComposition* mixComposition = [AVMutableComposition composition];
    self.completionBlock = completionBlock;
    //CMTimeRangeMake(start, duration),start起始时间，duration时长，都是CMTime类型
    //CMTimeMake(int64_t value, int32_t timescale)，返回CMTime，value视频的一个总帧数，timescale是指每秒视频播放的帧数，视频播放速率，（value / timescale）才是视频实际的秒数时长，timescale一般情况下不改变，截取视频长度通过改变value的值
    //CMTimeMakeWithSeconds(Float64 seconds, int32_t preferredTimeScale)，返回CMTime，seconds截取时长（单位秒），preferredTimeScale每秒帧数
    
    [self setVideoAsset:self.videoAssets audioAsset:audioAsset avMutableComposition:mixComposition range:videoRange];
    
    [self exportVideoComposition:nil composition:mixComposition];
    
}
/**
 多个视频合成
 
 @param tArray 数组视频 AVURLAsset
 @param completionBlock 回调地址
 */
-(void)mergeVideoToOneVideo:(NSArray *)tArray completion:(void (^)(AVAssetExportSessionStatus status,NSURL * videoUrl))completionBlock{
    self.completionBlock = completionBlock;
    AVMutableComposition * mixComposition = [self mergeVideostoOnevideo:tArray];
    [self exportVideoComposition:nil composition:mixComposition];
}
/**
 *  多个视频合成为一个
 *
 *  @param array 多个视频的NSURL地址
 *
 *  @return 返回AVMutableComposition
 */
-(AVMutableComposition *)mergeVideostoOnevideo:(NSArray*)array
{
    AVMutableComposition* mixComposition = [AVMutableComposition composition];
    AVMutableCompositionTrack *a_compositionVideoTrack = [mixComposition addMutableTrackWithMediaType:AVMediaTypeVideo preferredTrackID:kCMPersistentTrackID_Invalid];
    Float64 tmpDuration =0.0f;
    for (NSInteger i=0; i<array.count; i++){
        AVURLAsset *videoAsset = array[i];
        CMTimeRange video_timeRange = CMTimeRangeMake(kCMTimeZero,videoAsset.duration);
        NSError *error;
        [a_compositionVideoTrack insertTimeRange:video_timeRange ofTrack:[[videoAsset tracksWithMediaType:AVMediaTypeVideo] objectAtIndex:0] atTime:CMTimeMakeWithSeconds(tmpDuration, 0) error:&error];
        tmpDuration += CMTimeGetSeconds(videoAsset.duration);
    }
    return mixComposition;
}
/**
 给视频添加水印
 
 @param waterImage 水印图片
 @param completionBlock 回调
 */
- (void)videoSaveWithWaterImg:(UIImage*)waterImage completion:(void (^)(AVAssetExportSessionStatus status,NSURL * videoUrl))completionBlock
{
    self.completionBlock = completionBlock;
    //CMTime startTime = CMTimeMakeWithSeconds(0.2, 600);
    CMTime endTime = CMTimeMakeWithSeconds(self.videoAssets.duration.value/self.videoAssets.duration.timescale-0.2, self.videoAssets.duration.timescale);
    //声音采集
    
    //2 创建AVMutableComposition实例. apple developer 里边的解释 【AVMutableComposition is a mutable subclass of AVComposition you use when you want to create a new composition from existing assets. You can add and remove tracks, and you can add, remove, and scale time ranges.】
    AVMutableComposition *mixComposition = [[AVMutableComposition alloc] init];
    NSArray * lArray = [self setVideoAsset:self.videoAssets audioAsset:self.videoAssets avMutableComposition:mixComposition];
    
    
    //3 视频通道  工程文件中的轨道，有音频轨、视频轨等，里面可以插入各种对应的素材
    AVMutableCompositionTrack *videoTrack = lArray.firstObject;
    
    //3.1 AVMutableVideoCompositionInstruction 视频轨道中的一个视频，可以缩放、旋转等
    AVMutableVideoCompositionInstruction *mainInstruction = [AVMutableVideoCompositionInstruction videoCompositionInstruction];
    mainInstruction.timeRange = CMTimeRangeFromTimeToTime(kCMTimeZero, videoTrack.timeRange.duration);
    
    // 3.2 AVMutableVideoCompositionLayerInstruction 一个视频轨道，包含了这个轨道上的所有视频素材
    AVMutableVideoCompositionLayerInstruction *videolayerInstruction = [AVMutableVideoCompositionLayerInstruction videoCompositionLayerInstructionWithAssetTrack:videoTrack];
    AVAssetTrack *videoAssetTrack = [[self.videoAssets tracksWithMediaType:AVMediaTypeVideo] objectAtIndex:0];
    
    
    //    UIImageOrientation videoAssetOrientation_  = UIImageOrientationUp;
    BOOL isVideoAssetPortrait_  = NO;
    CGAffineTransform videoTransform = videoAssetTrack.preferredTransform;
    if (videoTransform.a == 0 && videoTransform.b == 1.0 && videoTransform.c == -1.0 && videoTransform.d == 0) {
        //        videoAssetOrientation_ = UIImageOrientationRight;
        isVideoAssetPortrait_ = YES;
    }
    if (videoTransform.a == 0 && videoTransform.b == -1.0 && videoTransform.c == 1.0 && videoTransform.d == 0) {
        //        videoAssetOrientation_ =  UIImageOrientationLeft;
        isVideoAssetPortrait_ = YES;
    }
    //    if (videoTransform.a == 1.0 && videoTransform.b == 0 && videoTransform.c == 0 && videoTransform.d == 1.0) {
    //        videoAssetOrientation_ =  UIImageOrientationUp;
    //    }
    //    if (videoTransform.a == -1.0 && videoTransform.b == 0 && videoTransform.c == 0 && videoTransform.d == -1.0) {
    //        videoAssetOrientation_ = UIImageOrientationDown;
    //    }
    [videolayerInstruction setTransform:videoAssetTrack.preferredTransform atTime:kCMTimeZero];
    [videolayerInstruction setOpacity:0.0 atTime:endTime];
    // 3.3 - Add instructions
    mainInstruction.layerInstructions = [NSArray arrayWithObjects:videolayerInstruction,nil];
    
    
    //AVMutableVideoComposition：管理所有视频轨道，可以决定最终视频的尺寸，裁剪需要在这里进行
    AVMutableVideoComposition *mainCompositionInst = [AVMutableVideoComposition videoComposition];
    
    CGSize naturalSize;
    if(isVideoAssetPortrait_){
        naturalSize = CGSizeMake(videoAssetTrack.naturalSize.height, videoAssetTrack.naturalSize.width);
    } else {
        naturalSize = videoAssetTrack.naturalSize;
    }
    
    float renderWidth, renderHeight;
    renderWidth = naturalSize.width;
    renderHeight = naturalSize.height;
    mainCompositionInst.renderSize = CGSizeMake(renderWidth, renderHeight);
    mainCompositionInst.renderSize = CGSizeMake(renderWidth, renderHeight);
    mainCompositionInst.instructions = [NSArray arrayWithObject:mainInstruction];
    mainCompositionInst.frameDuration = CMTimeMake(1, 25);
    
    [self applyVideoEffectsToComposition:mainCompositionInst watermark:waterImage size:CGSizeMake(renderWidth, renderHeight)];
    [self exportVideoComposition:mainCompositionInst composition:mixComposition];
    
}

//添加水印
- (void)applyVideoEffectsToComposition:(AVMutableVideoComposition *)composition watermark:(UIImage *)watermark size:(CGSize)size
{
    if (!watermark) {
        //need not add watermark;
        return;
    }
    // 1 - set up the overlay
    CALayer *overlayLayer = [CALayer layer];
    UIImage *overlayImage = watermark;
    
    [overlayLayer setContents:(id)[overlayImage CGImage]];
    overlayLayer.frame = CGRectMake(0, 0, size.width, size.height);
    [overlayLayer setMasksToBounds:YES];
    
    // 2 - set up the parent layer
    CALayer *parentLayer = [CALayer layer];
    CALayer *videoLayer = [CALayer layer];
    parentLayer.frame = CGRectMake(0, 0, size.width, size.height);
    videoLayer.frame = CGRectMake(0, 0, size.width, size.height);
    [parentLayer addSublayer:videoLayer];
    [parentLayer addSublayer:overlayLayer];
    
    // 3 - apply magic
    composition.animationTool = [AVVideoCompositionCoreAnimationTool
                                 videoCompositionCoreAnimationToolWithPostProcessingAsVideoLayer:videoLayer inLayer:parentLayer];
    
}

/**
 文件视频导出

 @param mainCompositionInst mainCompositionInst description
 @param mixComposition mixComposition description
 */
- (void)exportVideoComposition:(AVMutableVideoComposition *)mainCompositionInst composition:(AVMutableComposition *)mixComposition {
    NSURL * videoUrl = [self getExportVideoUrl];
    
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
//存储地址
- (NSURL *)getExportVideoUrl{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString * videoName = [NSString stringWithFormat:@"%.0f",[[NSDate date] timeIntervalSince1970]];
    NSString *myPathDocs =  [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.mp4",videoName]];
    self.lCacheUrl = myPathDocs;
    unlink([myPathDocs UTF8String]);
    NSURL* videoUrl = [NSURL fileURLWithPath:myPathDocs];
    return videoUrl;
}

/**
 视频操作状态反馈

 @param session 视频导出的相关信息
 */
- (void)exportDidFinish:(AVAssetExportSession*)session{
    if (self.completionBlock) {
        self.completionBlock(session.status,session.outputURL);
    }
    if (session.status == AVAssetExportSessionStatusCompleted) {
        NSURL *outputURL = session.outputURL;
        __weak typeof(self)weakSelf = self;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            __block PHObjectPlaceholder *placeholder;
            if (UIVideoAtPathIsCompatibleWithSavedPhotosAlbum(outputURL.path)) {
                NSError *error;
                [[PHPhotoLibrary sharedPhotoLibrary] performChangesAndWait:^{
                    PHAssetChangeRequest* createAssetRequest = [PHAssetChangeRequest creationRequestForAssetFromVideoAtFileURL:outputURL];
                    placeholder = [createAssetRequest placeholderForCreatedAsset];
                } error:&error];
                if (error) {
                    //[SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"%@",error]];
                }
                else{
                    [weakSelf removeCacheData];
                    //[SVProgressHUD showSuccessWithStatus:@"视频已经保存到相册"];
                }
            }else {
                //[SVProgressHUD showErrorWithStatus:NSLocalizedString(@"视频保存相册失败，请设置软件读取相册权限", nil)];
            }
        });
    }
}
- (void)removeCacheData{
    NSFileManager * fileManeger = [NSFileManager defaultManager];
    if ([fileManeger fileExistsAtPath:self.lCacheUrl]) {
        NSError * error = nil;
       BOOL removeStatus = [fileManeger removeItemAtPath:self.lCacheUrl error:&error];
        if (error) {
            
        }
        if (removeStatus) {
            
        }
    }
}

//获取视频时长
+ (CGFloat)getMediaDurationWithMediaUrl:(NSString *)mediaUrlStr {
    
    NSURL *mediaUrl = [NSURL URLWithString:mediaUrlStr];
    AVURLAsset *mediaAsset = [[AVURLAsset alloc] initWithURL:mediaUrl options:nil];
    CMTime duration = mediaAsset.duration;
    //视频总帧数 / 视频的每秒播放的帧数
    return duration.value / duration.timescale;
}
@end
