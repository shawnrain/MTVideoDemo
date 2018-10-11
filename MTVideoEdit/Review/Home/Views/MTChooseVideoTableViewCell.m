//
//  MTChooseVideoTableViewCell.m
//  wanghong
//
//  Created by MTShawn on 2018/9/11.
//  Copyright © 2018年 MT. All rights reserved.
//

#import "MTChooseVideoTableViewCell.h"
#import <TZImagePickerController/TZImageManager.h>
@interface MTChooseVideoTableViewCell()
@property (nonatomic, strong) UIImageView  * assetImageView;
@property (nonatomic, strong) UILabel      * videoNameLabel;
@property (nonatomic, strong) UILabel      * videoDuringTimeLabel;
@property (nonatomic, strong) UIImageView  * accessoryImageView;
@end

@implementation MTChooseVideoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setModel:(MTAssetsModel *)model{
    _model = model;
    if (model.cachedImage) {
        self.assetImageView.image = model.cachedImage;
    }else{
        [[TZImageManager manager] getPhotoWithAsset:model.asset photoWidth:100 completion:^(UIImage *photo, NSDictionary *info, BOOL isDegraded){
            self->_model.cachedImage = photo;
            self->_assetImageView.image = photo;
        }];
    }
    self.videoNameLabel.text = @"视频一";
    self.videoDuringTimeLabel.text = model.timeLength;
}
- (void)setVideoIsSelected:(BOOL)videoIsSelected{
    _videoIsSelected = videoIsSelected;
    if (videoIsSelected) {
        self.accessoryImageView.image = [UIImage imageNamed:@"选择视频"];
    }else{
        self.accessoryImageView.image = [UIImage imageNamed:@""];
    }
}
- (void)setIndexPath:(NSIndexPath *)indexPath{
    _indexPath = indexPath;
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    formatter.numberStyle = kCFNumberFormatterRoundHalfDown;
    NSString *string = [formatter stringFromNumber:[NSNumber numberWithInteger:indexPath.row + 1]];
    self.videoNameLabel.text = [@"视频" stringByAppendingString:string];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
- (UILabel *)videoNameLabel{
    if (!_videoNameLabel) {
        UILabel * label = [[UILabel alloc] init];
        label.textColor = color353535;
        label.font = [UIFont fontWithName:@"PingFangSC-Medium" size:16];
        label.text = @"视频一";
        _videoNameLabel = label;
        [self.contentView addSubview:_videoNameLabel];
        [_videoNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.mas_equalTo(self.assetImageView.mas_trailing).offset(20);
            make.height.equalTo(@22);make.top.equalTo(@42);
        }];
    }
    return _videoNameLabel;
}
- (UILabel *)videoDuringTimeLabel{
    if (!_videoDuringTimeLabel) {
        UILabel * label = [[UILabel alloc] init];
        label.textColor = color353535;
        label.font = [UIFont fontWithName:@"PingFangSC-Medium" size:14];
        label.text = @"00:16";
        _videoDuringTimeLabel = label;
        [self.contentView addSubview:_videoDuringTimeLabel];
        [_videoDuringTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.videoNameLabel.mas_bottom).offset(8);
            make.leading.mas_equalTo(self.assetImageView.mas_trailing).offset(20);
            make.height.equalTo(@20);
        }];
    }
    return _videoDuringTimeLabel;
}
- (UIImageView *)assetImageView{
    if (!_assetImageView) {
        _assetImageView = [[UIImageView alloc] init];
        _assetImageView.contentMode = UIViewContentModeScaleToFill;
        
        _assetImageView.layer.masksToBounds = YES;
        [self.contentView addSubview:_assetImageView];
        [_assetImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@17);make.leading.equalTo(@15);
            make.width.and.height.equalTo(@100);
        }];
    }
    return _assetImageView;
}
- (UIImageView *)accessoryImageView{
    if (!_accessoryImageView) {
        _accessoryImageView = [[UIImageView alloc] init];
        _accessoryImageView.contentMode = UIViewContentModeScaleToFill;
        _accessoryImageView.layer.masksToBounds = YES;
        _accessoryImageView.layer.borderWidth = 2.0;
        _accessoryImageView.layer.borderColor = color353535.CGColor;
        [self.contentView addSubview:_accessoryImageView];
        [_accessoryImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(@0);
            make.width.equalTo(@24);
            make.height.equalTo(@24);
            make.trailing.equalTo(@-15);
        }];
    }
    return _accessoryImageView;
}

@end
