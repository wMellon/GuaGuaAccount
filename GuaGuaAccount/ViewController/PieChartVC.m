//
//  PieChartVC.m
//  GuaGuaAccount
//
//  Created by xxb on 17/1/20.
//  Copyright © 2017年 xxb. All rights reserved.
//

#import "PieChartVC.h"
#import "RMMapper.h"
#import "PYOption.h"
#import "AccountViewmodel.h"
#import "AccountStatisticsModel.h"
#import "DateSelectView.h"

@interface PieChartVC ()

@property(nonatomic, strong) DateSelectView *dateSelectView;
@property(nonatomic, strong) NSMutableArray *accountList;
@property(nonatomic, copy) NSString *dateString;//当前选中月对应的字符串

@end

@implementation PieChartVC

#pragma mark - Life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupContentView];
}

- (void)setupContentView{
    [self.view addSubview:self.dateSelectView];
    [self.view addSubview:self.kEchartView];
    [self reloadViewData];
}

- (void)reloadViewData{
    NSDate *now = [NSDate date];
    self.dateString = [now formattedTimeWithFormat:DateSelectFormat];
    self.dateSelectView.dateLabel.text = [now formattedTimeWithFormat:DateSelectFormat];
    [self.dateSelectView.nextBtn setTitleColor:RGB(230, 230, 230) forState:UIControlStateNormal];
    self.accountList = [AccountViewmodel getAccountByDate:self.dateString];
    [self showBasicPieDemo];
}


#pragma mark - UITableView delegate

#pragma mark - View delegate

/**
 *  标准饼图
 */
- (void)showBasicPieDemo {
    
    NSMutableArray *dataArray = [[NSMutableArray alloc] initWithCapacity:self.accountList.count];
    NSMutableArray *dataDict = [[NSMutableArray alloc] initWithCapacity:self.accountList.count];
    NSMutableDictionary *dict;
    for(AccountStatisticsModel *model in self.accountList){
        [dataArray addObject:model.categoryName];
        dict = [[NSMutableDictionary alloc] initWithCapacity:2];
        [dict setObject:[[NSDecimalNumber alloc] initWithString:model.priceCount] forKey:@"value"];
        [dict setObject:model.categoryName forKey:@"name"];
        [dataDict addObject:dict];
    }
    NSString *formatter = @"{a} <br/>{b} : {c} ({d}%)";
    NSString *center = @"\"radius\":\"40%\",\"center\":[\"45%\",\"40%\"]";
    NSString *basicPieJson = [NSString stringWithFormat:@"{\"tooltip\":{\"trigger\":\"item\",\"formatter\":\"%@\"},\"legend\":{\"orient\":\"vertical\",\"x\":\"left\",\"data\":%@},\"calculable\":false,\"series\":[{\"name\":\"访问来源\",\"type\":\"pie\",%@,\"data\":%@}]}", formatter, [dataArray yy_modelToJSONString], center, [dataDict yy_modelToJSONString]];
    NSData *jsonData = [basicPieJson dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:nil];
    PYOption *option = [RMMapper objectWithClass:[PYOption class] fromDictionary:jsonDic];
    [self.kEchartView setOption:option];
}

#pragma mark - Other delegate


#pragma mark - Action

-(void)lastMonth{
    GGWeakSelfDefine
    [AccountViewmodel getSelectDateBy:self.dateString monthOffset:-1 block:^(BOOL canNext, NSString *dateString) {
        GGWeakSelf.dateString = dateString;
        GGWeakSelf.dateSelectView.dateLabel.text = dateString;
        GGWeakSelf.accountList = [AccountViewmodel getAccountByDate:GGWeakSelf.dateString];
        [GGWeakSelf showBasicPieDemo];
        [GGWeakSelf.kEchartView loadEcharts];
        [GGWeakSelf.dateSelectView.nextBtn setTitleColor:RGB(153, 153, 153) forState:UIControlStateNormal];
    }];
}

-(void)nextMonth{
    GGWeakSelfDefine
    [AccountViewmodel getSelectDateBy:self.dateString monthOffset:1 block:^(BOOL canNext, NSString *dateString) {
        GGWeakSelf.dateString = dateString;
        GGWeakSelf.dateSelectView.dateLabel.text = dateString;
        GGWeakSelf.accountList = [AccountViewmodel getAccountByDate:GGWeakSelf.dateString];
        [GGWeakSelf showBasicPieDemo];
        [GGWeakSelf.kEchartView loadEcharts];
        if(!canNext){
            [GGWeakSelf.dateSelectView.nextBtn setTitleColor:RGB(230, 230, 230) forState:UIControlStateNormal];
        }else{
            [GGWeakSelf.dateSelectView.nextBtn setTitleColor:RGB(153, 153, 153) forState:UIControlStateNormal];
        }
    }];
}

#pragma mark - Properrtys

-(DateSelectView *)dateSelectView{
    if(!_dateSelectView){
        _dateSelectView = [[DateSelectView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 50)];
        [_dateSelectView.lastBtn addTarget:self action:@selector(lastMonth) forControlEvents:UIControlEventTouchUpInside];
        [_dateSelectView.nextBtn addTarget:self action:@selector(nextMonth) forControlEvents:UIControlEventTouchUpInside];
    }
    return _dateSelectView;
}

-(PYEchartsView *)kEchartView{
    if(!_kEchartView){
        _kEchartView = [[PYEchartsView alloc] initWithFrame:CGRectMake(0, self.dateSelectView.frameHeight, ScreenWidth, self.view.frameHeight - self.dateSelectView.frameHeight)];
    }
    return _kEchartView;
}
@end
