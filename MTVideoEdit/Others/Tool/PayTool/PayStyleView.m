//
//  PayStyleView.m
//  KwaiUp
//
//  Created by melon on 2018/1/18.
//  Copyright © 2018年 melon. All rights reserved.
//

#import "PayStyleView.h"
#import "NormalCell.h"
@interface  PayStyleView ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UIView *halfAlphaView;
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, weak) UIViewController *showVC;

@property (nonatomic, copy) PayStyleSelectedBlock selectedBlock;

@property (nonatomic, strong) NSArray *payStyleItemArr;
@end
@implementation PayStyleView
+ (instancetype)share{
    static PayStyleView *payStyleView;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        payStyleView = [[PayStyleView alloc] init];
    });
    return payStyleView;
}
+ (void)showInVC:(UIViewController *)vc withArray:(NSArray *)dataSource selectedBlock:(PayStyleSelectedBlock)selectedBlock
{
    PayStyleView *payStyleView = [self share];
    payStyleView.showVC = vc;
    payStyleView.payStyleItemArr = dataSource;
    if (payStyleView.superview) {
        [payStyleView removeFromSuperview];
    }
    payStyleView.selectedBlock = selectedBlock;
    payStyleView.backgroundColor = [UIColor clearColor];
    payStyleView.frame = vc.view.bounds;
    
    payStyleView.tableView.frame = CGRectMake(0, payStyleView.height, payStyleView.width, 60 * payStyleView.payStyleItemArr.count);
    [payStyleView.tableView reloadData];
    [vc.view addSubview:payStyleView];
    
    [UIView animateWithDuration:0.3 animations:^{
        payStyleView.halfAlphaView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.69];
        payStyleView.tableView.frame = CGRectMake(0, payStyleView.height - payStyleView.tableView.height, payStyleView.width, payStyleView.tableView.height);
    }];
}
- (instancetype)init{
    self = [super init];
    if (self) {
        [self loadSubView];
        [self layoutSubView];
    }
    return self;
}

- (void)loadSubView{
    [self addSubview:self.halfAlphaView];
    [self addSubview:self.tableView];
}

- (void)layoutSubView{
    [self.halfAlphaView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
}
+ (void)dismiss{
    [[self share] dismiss];
}

- (void)dismiss{
    if([self superview]){
        [UIView animateWithDuration:0.3 animations:^{
            self.alpha = 0;
        }completion:^(BOOL finished) {
            [self removeFromSuperview];
            self.alpha = 1;
        }];
    }
}

#pragma mark - delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.payStyleItemArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dic;
    dic = self.payStyleItemArr[indexPath.row];
    
    
    NormalCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    if (indexPath.section == 0 && indexPath.row == 1){
        cell.subLabel.textColor = HEXCOLOR(0xf22d45);
        cell.subLabel.font = [UIFont systemFontOfSize:20];
    }else{
        cell.subLabel.textColor = HEXCOLOR(0x545454);
        cell.subLabel.font = [UIFont systemFontOfSize:15];
    }
    
    if (cell.bottomLine.left != 0) {
        [cell.bottomLine mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(cell.contentView.mas_left);
        }];
    }
    [cell setWithDic:dic];
    
    return cell;
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSDictionary *payStyleDic = self.payStyleItemArr[indexPath.row];
    NSString *name = payStyleDic[@"title"];
    PayStyle payStyle;
    if ([name isEqualToString:@"支付宝支付"]) {
        payStyle = PayStyleAliPay;
    }else if([name isEqualToString:@"微信支付"]){
        payStyle = PayStyleWeiXin;
    }else{
        payStyle = PayStyleQQ;
    }
    if (self.selectedBlock) {
        self.selectedBlock(payStyle);
    }
    [self dismiss];
}

- (void)dismissOtherType
{
    if (self.selectedBlock) {
        self.selectedBlock(PayStyleNone);
    }
    [self dismiss];
}
- (UITableView *)tableView
{
    if (!_tableView) {
        UITableView *tableView = [[UITableView alloc]init];
        tableView.delegate = self;
        tableView.dataSource = self;
        [tableView registerClass:[NormalCell class] forCellReuseIdentifier:@"cell"];
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView = tableView;
    }
    return _tableView;
}
- (UIView *)halfAlphaView
{
    if (!_halfAlphaView) {
        _halfAlphaView = [UIView new];
        [_halfAlphaView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissOtherType)]];
    }
    return _halfAlphaView;
}
@end
