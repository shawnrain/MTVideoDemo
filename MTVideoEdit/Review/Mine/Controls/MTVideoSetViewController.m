//
//  MTVideoSetViewController.m
//  MTVideoEdit
//
//  Created by MTShawn on 2018/9/19.
//  Copyright © 2018年 MT. All rights reserved.
//

#import "MTVideoSetViewController.h"
#import "SPUserInfo.h"
@interface MTVideoSetViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView  * tableView;
@property (nonatomic, strong) NSArray  * dataSource;
@end

@implementation MTVideoSetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"画质设置";
    self.view.backgroundColor = colorEDEDED;
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@25);
        make.leading.equalTo(@15);
        make.trailing.equalTo(@-15);
        make.height.equalTo(@185);
    }];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"return_backimg"] style:UIBarButtonItemStyleDone target:self action:@selector(backAction)];
}
- (void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    CGFloat topBottom = CGRectGetMaxY(self.navigationController.navigationBar.frame);
    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(topBottom + 25));
    }];
}
#pragma mark -- UITableViewDelegate,UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    UIImageView * indicator = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"review_选择"]];
    if ([SPUserInfo shareInstance].videoSelected == indexPath.row) {
        cell.accessoryView = indicator;
    }else{
        cell.accessoryView = [UIView new];
    }
    cell.textLabel.text = self.dataSource[indexPath.row];//@"关于我们";
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    cell.textLabel.textColor = color353535;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [SPUserInfo shareInstance].videoSelected = indexPath.row;
    [SPUserInfo archiveUserInstance];
    [self.tableView reloadData];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 46;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [UIView new];
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
        _tableView.layer.cornerRadius = 6.0;
        _tableView.layer.masksToBounds = YES;
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
        _dataSource = @[@"1800px (流畅)",@"2448px (普通)",@"3264px (高清)",@"4032px (全高清)"];
    }
    return _dataSource;
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
