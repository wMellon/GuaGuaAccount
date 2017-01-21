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
#import "PYEchartsView.h"

@interface PieChartVC ()

@property(nonatomic, strong) PYEchartsView *kEchartView;
@property(nonatomic, strong) NSMutableArray *accountList;

@end

@implementation PieChartVC

#pragma mark - Life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupContentView];
}

- (void)setupContentView{
    [self.view addSubview:self.kEchartView];
    [self reloadViewData];
    [self showBasicPieDemo];
    [self.kEchartView loadEcharts];
}

- (void)reloadViewData{
    self.accountList = [AccountViewmodel getAccountByCategory];
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


#pragma mark - Properrtys

-(PYEchartsView *)kEchartView{
    if(!_kEchartView){
        _kEchartView = [[PYEchartsView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, self.view.frameHeight)];
    }
    return _kEchartView;
}
@end
