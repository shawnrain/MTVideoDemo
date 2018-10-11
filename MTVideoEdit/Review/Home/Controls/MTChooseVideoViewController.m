//
//  MTChooseVideoViewController.m
//  wanghong
//
//  Created by MTShawn on 2018/9/11.
//  Copyright © 2018年 MT. All rights reserved.
//

#import "MTChooseVideoViewController.h"
#import "MTChooseVideoTableViewCell.h"
#import <UIScrollView+EmptyDataSet.h>
#import "MTVideoEditViewController.h"
#import "MTImageManager.h"
#import "MHHUD.h"
static NSString * const videoChooseCellIdentifier = @"MTChooseVideoTableViewCell";
@interface MTChooseVideoViewController ()<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>
@property (nonatomic, strong) UITableView     * tableView;
@property (nonatomic, strong) NSMutableArray  * videosArray;
@property (nonatomic, strong) NSMutableArray  * selectedVideoArray;

@end

@implementation MTChooseVideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self configureVideoData];
    [self configureUI];
    [self wr_setNavBarShadowImageHidden:false];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"return_backimg"] style:UIBarButtonItemStyleDone target:self action:@selector(backAction)];
}
- (void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self configureVideoData];
    [_selectedVideoArray removeAllObjects];
}
- (void)configureUI{
    self.title = @"选择视频";
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];
}
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.emptyDataSetSource= self;
        _tableView.emptyDataSetDelegate = self;
        _tableView.tableFooterView = [UIView new];
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.showsHorizontalScrollIndicator = NO;
        [_tableView registerClass:[MTChooseVideoTableViewCell class] forCellReuseIdentifier:videoChooseCellIdentifier];
    }
    return _tableView;
}
- (void)configureVideoData{
    kWeakSelf
    [[MTImageManager manager] getCameraRollAlbum:YES allowPickingImage:NO needFetchAssets:NO completion:^(PHFetchResult *model) {
        [weakSelf getVideoAssetFromPH:model];
    }];
}
- (void)getVideoAssetFromPH:(PHFetchResult *)result{
    __block NSMutableArray * lArray = [NSMutableArray arrayWithCapacity:0];
    [result enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [[MTImageManager manager] getAssetFromFetchResult:result atIndex:idx completion:^(MTAssetsModel * asset) {
            [lArray addObject:asset];
        }];
    }];
    self.videosArray = lArray;
    [self.tableView reloadData];
}
#pragma mark -- UITableViewDelegate,UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.videosArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 140;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MTChooseVideoTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:videoChooseCellIdentifier forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    MTAssetsModel * model = self.videosArray[indexPath.row];
    cell.model = model;
    cell.indexPath = indexPath;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    MTAssetsModel * model = self.videosArray[indexPath.row];
    MTVideoEditViewController * edit = [[MTVideoEditViewController alloc] init];
    edit.type = self.operateType; edit.asset = model;
    [self.navigationController pushViewController:edit animated:YES];
}
#pragma mark --
- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView
{
    NSString *text = @"暂未获取到相关视频资源～";
    NSMutableDictionary *attributes = [NSMutableDictionary new];
    [attributes setObject:[UIFont systemFontOfSize:14] forKey:NSFontAttributeName];
    [attributes setObject:HEXCOLOR(0xDDDDDD) forKey:NSForegroundColorAttributeName];
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}
- (NSMutableArray *)selectedVideoArray{
    if (!_selectedVideoArray) {
        _selectedVideoArray = [NSMutableArray arrayWithCapacity:0];
    }
    return _selectedVideoArray;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
