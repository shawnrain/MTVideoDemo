//
//  SPMyMessageViewController.m
//  shipingdiandian
//
//  Created by MTShawn on 2018/7/20.
//  Copyright © 2018年 MT. All rights reserved.
//

#import "SPMyMessageViewController.h"
#import "SPUserInfo.h"
static NSString * const messageCellIdentifier = @"SPMyMessageTableViewCell";
@interface SPMyMessageViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView  * tableView;
@end

@implementation SPMyMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureUI];
    self.view.backgroundColor = colorEDEDED;
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@20);
        make.leading.equalTo(@15);
        make.trailing.equalTo(@-15);
        make.bottom.equalTo(@-15);
    }];
}
- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    CGFloat topBottom = CGRectGetMaxY(self.navigationController.navigationBar.frame);
    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(topBottom + 20));
    }];
}
- (void)configureUI{
    self.title = @"消息中心";
    self.view.backgroundColor = [UIColor whiteColor];
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableFooterView = [UIView new];
    _tableView.layer.cornerRadius = 6.0;
    _tableView.layer.masksToBounds = YES;
    _tableView.showsVerticalScrollIndicator = false;
    _tableView.showsHorizontalScrollIndicator = false;
    [_tableView registerClass:[SPMyMessageTableViewCell class] forCellReuseIdentifier:messageCellIdentifier];
    [self.view addSubview:self.tableView];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"return_backimg"] style:UIBarButtonItemStyleDone target:self action:@selector(backAction)];
}
- (void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark -- UITableViewDelegate,UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [SPUserInfo shareInstance].messageArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SPMyMessageTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:messageCellIdentifier forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSArray *lArray = [[SPUserInfo shareInstance].messageArray[indexPath.row] componentsSeparatedByString:@"=="];
    cell.timeLabel.text = lArray.lastObject;
    cell.messageLabel.text = lArray.firstObject;
    return cell;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

@implementation SPMyMessageTableViewCell
- (UILabel *)timeLabel{
    if (!_timeLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.font = [UIFont fontWithName:@"PingFangSC-Regular" size:12];
        label.textColor = color999999;
        label.textAlignment = NSTextAlignmentRight;
        _timeLabel = label;
        [self.contentView addSubview:_timeLabel];
        [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.trailing.equalTo(@-16);
            make.width.equalTo(@100);
            make.centerY.equalTo(self);
        }];
    }
    return _timeLabel;
}
- (UILabel *)messageLabel{
    if (!_messageLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14];
        label.textColor = color555555;
        _messageLabel = label;
        [self.contentView addSubview:_messageLabel];
        [_messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(@16);
            make.centerY.equalTo(self);
        }];
    }
    return _messageLabel;
}
@end
