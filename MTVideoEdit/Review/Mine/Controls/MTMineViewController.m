//
//  MTMineViewController.m
//  MTVideoEdit
//
//  Created by MTShawn on 2018/9/19.
//  Copyright © 2018年 MT. All rights reserved.
//

#import "MTMineViewController.h"
#import "MTMineTableHeaderView.h"
#import "SPAboutUSViewController.h"
#import "MTFeebackViewController.h"
#import "MTVideoSetViewController.h"
#import "SPMyMessageViewController.h"
#import "MTVideoEditManager.h"
#import "MTPopView.h"
@interface MTMineViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView  * tableView;
@property (nonatomic, strong) NSArray  * dataSource;
@end

@implementation MTMineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    kWeakSelf
    MTMineTableHeaderView * header = [[MTMineTableHeaderView alloc] init];
    [header setMessageBtnSelected:^{
        SPMyMessageViewController * message = [[SPMyMessageViewController alloc] init];
        [weakSelf.navigationController pushViewController:message animated:YES];
    }];
    [header setVideoSetBtnSelected:^{
        MTVideoSetViewController * lControl = [[MTVideoSetViewController alloc] init];
        [weakSelf.navigationController pushViewController:lControl animated:YES];
        
    }];
    [self.view addSubview:header];
    [header mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@0);
        make.leading.equalTo(@0);
        make.trailing.equalTo(@0);
        make.height.equalTo(@244);
    }];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(header.mas_bottom).offset(0);
        make.bottom.equalTo(@0);make.leading.equalTo(@0);
        make.trailing.equalTo(@0);
    }];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self wr_setNavBarBackgroundAlpha:0];
}
#pragma mark -- UITableViewDelegate,UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    NSDictionary *dic = self.dataSource[indexPath.row];
    cell.imageView.image = [UIImage imageNamed:[dic objectForKey:@"imageName"]];
    cell.textLabel.text = [dic objectForKey:@"title"];//@"关于我们";
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    cell.textLabel.textColor = color353535;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        [self.navigationController pushViewController:[SPAboutUSViewController new] animated:YES];
    }
    if (indexPath.row == 1) {
        MTFeebackViewController * feeBack = [[MTFeebackViewController alloc] initWithNibName:@"MTFeebackViewController" bundle:nil];
        [self.navigationController pushViewController:feeBack animated:YES];
    }
    if (indexPath.row == 2) {
        [self clearCache];
    }
}



- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [UIView new];
}
- (void)clearCache{
    dispatch_group_t group = dispatch_group_create();
    dispatch_queue_t queue = dispatch_get_main_queue();
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"videos"];
    NSFileManager * fileManager = [NSFileManager defaultManager];
    NSArray * fileList = [fileManager contentsOfDirectoryAtPath:documentsDirectory error:nil];
    for (NSString * file in fileList) {
        if ([file hasSuffix:@"mp4"]) {
            dispatch_group_enter(group);
            NSString * fullPath = [documentsDirectory stringByAppendingPathComponent:file];
            [MTVideoEditManager removeCacheData:fullPath];
            dispatch_group_leave(group);
        }
    }
    kWeakSelf
    dispatch_group_notify(group, queue, ^{
        MTPopView * popView = [MTPopView MTPopViewShowWithStr:@"清理成功"];
        [weakSelf lew_presentPopupView:popView animation:[LewPopupViewAnimationSpring new]];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakSelf lew_dismissPopupView];
        });
    });
}
#pragma mark -- getter
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
        _tableView.backgroundColor = colorEDEDED;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
        _tableView.scrollEnabled = false;
        if (@available(iOS 11, *)) {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }else{
            self.automaticallyAdjustsScrollViewInsets = false;
        }
        [self.view addSubview:_tableView];
    }
    return _tableView;
}
- (NSArray *)dataSource{
    if (!_dataSource) {
        _dataSource = @[@{@"title":@"关于我们",@"imageName":@"关于我们"},
                        @{@"title":@"意见反馈",@"imageName":@"意见反馈"},
                        @{@"title":@"清除缓存",@"imageName":@"清除缓存"}];
    }
    return _dataSource;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
