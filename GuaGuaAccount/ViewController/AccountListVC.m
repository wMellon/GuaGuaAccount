//
//  AccountListVC.m
//  GuaGuaAccount
//
//  Created by xxb on 17/1/20.
//  Copyright © 2017年 xxb. All rights reserved.
//

#import "AccountListVC.h"
#import "AccountListCell.h"
#import "AccountViewmodel.h"
#import "AccountModel.h"
#import "AccountListSectionHeaderView.h"

@interface AccountListVC ()<UITableViewDelegate,UITableViewDelegate>

@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation AccountListVC

#pragma mark - Life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupContentView];
    [self reloadViewData];
}

- (void)setupContentView{
    [self.view addSubview:self.tableView];
    [self.tableView registerNib:[UINib nibWithNibName:@"AccountListCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"AccountListCell"];
    self.tableView.tableFooterView = [[UIView alloc] init];
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    self.tableView.showsVerticalScrollIndicator = NO;
}

- (void)reloadViewData{
    self.dataSource = [AccountViewmodel getAccountList];
    [self.tableView reloadData];
}

#pragma mark - UITableView delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [AccountListCell getCellHeight];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [self.dataSource count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.dataSource[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AccountListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AccountListCell"];
    AccountModel *model = self.dataSource[indexPath.section][indexPath.row];
    cell.dateLabel.text = model.timeText;
    cell.priceLabel.text = [NSString stringWithFormat:@"%.2f", [model.price doubleValue]];
    cell.remarkLabel.text = model.categoryName;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    AccountModel *model = self.dataSource[section][0];
    AccountListSectionHeaderView *view = [[AccountListSectionHeaderView alloc] init];
    NSDate *date = [NSDate convertDateFromString:model.time andFormat:timeFormat];
    view.monthLabel.text = [NSString stringWithFormat:@"%ld年%ld月", (long)date.year, (long)date.month];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

#pragma mark - Action

#pragma mark - Property

-(UITableView *)tableView{
    if(!_tableView){
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, self.view.frameHeight) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

@end
