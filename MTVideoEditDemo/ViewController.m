//
//  ViewController.m
//  MTVideoEditDemo
//
//  Created by MTShawn on 2018/7/26.
//  Copyright © 2018年 MT. All rights reserved.
//

#import "ViewController.h"
#import "MTVideoAddTextViewController.h"
#import "UIViewController+MTVideoHelper.h"
#import "UIViewController+videoSave.h"
#import "MTImageManager.h"
@interface ViewController ()<TZImagePickerControllerDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    TZImagePickerController *imagePicker = [[TZImagePickerController alloc] initWithMaxImagesCount:2 delegate:self];
    imagePicker.allowTakePicture = NO;
    imagePicker.allowPickingImage = NO;
    imagePicker.statusBarStyle = NO;
    imagePicker.allowPickingMultipleVideo = YES;
    imagePicker.sortAscendingByModificationDate = YES;
    [self presentViewController:imagePicker animated:YES completion:nil];
    
    
//    __weak typeof(self)weakSelf = self;
//    [[MTImageManager manager] getCameraRollAlbum:YES allowPickingImage:NO needFetchAssets:NO completion:^(PHFetchResult *model) {
//        [weakSelf assets:model];
//    }];
}
- (void)assets:(PHFetchResult *)model{
    __block NSMutableArray * lArray = [NSMutableArray arrayWithCapacity:0];
    [model enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [[MTImageManager manager] getAssetFromFetchResult:model atIndex:idx completion:^(MTAssetsModel * asset) {
            [lArray addObject:asset];
        }];
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray<UIImage *> *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto{
    if (assets.count > 1) {
        __weak typeof(self)weakSelf = self;
        [self PHAVAssetArray:assets complemtion:^(NSMutableArray *lAVAssetArray) {
            [weakSelf mergeVideoToOneVideo:lAVAssetArray completion:^(AVAssetExportSessionStatus status, NSURL *videoUrl) {
                
            }];
        }];
        return;
    }
    MTVideoAddTextViewController * textControl = [[MTVideoAddTextViewController alloc] init];
    textControl.lAVsset = assets.firstObject;
    [self.navigationController pushViewController:textControl animated:YES];
}
- (void)mergeArray:(NSArray *)lArray{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString * videoName = [NSString stringWithFormat:@"%.0f",[[NSDate date] timeIntervalSince1970]];
    NSString *myPathDocs =  [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.mp4",videoName]];
    unlink([myPathDocs UTF8String]);
    
}
- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray<UIImage *> *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto infos:(NSArray<NSDictionary *> *)infos{
    
}

- (void)tz_imagePickerControllerDidCancel:(TZImagePickerController *)picker{
    
}

@end
