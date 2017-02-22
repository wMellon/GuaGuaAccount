//
//  WaveChartVC.m
//  GuaGuaAccount
//
//  Created by xxb on 17/1/20.
//  Copyright © 2017年 xxb. All rights reserved.
//

#import "WaveChartVC.h"
#import "DateSelectView.h"
#import "AccountViewmodel.h"
#import "PYOption.h"
#import "RMMapper.h"
#import "AccountStatisticsModel.h"
#import "PYEchartsView.h"
#import "PYJsonUtil.h"

@interface WaveChartVC ()

@property (nonatomic, strong) DateSelectView *dateSelectView;
@property (nonatomic, strong) NSMutableArray *accountList;
@property (nonatomic, copy) NSString *dateString;
@property (nonatomic, strong) PYEchartsView *kEchartView;

@end

@implementation WaveChartVC

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
    NSString *to = [now formattedTimeWithFormat:timeFormat];
    NSInteger fromMonth = [now getMonthByOffset:-6];
    NSString *fromMonthStr;
    if(fromMonth < 10){
        fromMonthStr = [NSString stringWithFormat:@"0%ld", fromMonth];
    }else{
        fromMonthStr = [NSString stringWithFormat:@"%ld", fromMonth];
    }
    NSString *from = [NSString stringWithFormat:@"%ld-%@-01 00:00:00", [now getYearByOffset:-6], fromMonthStr];
    
    //获取数据
    self.accountList = [AccountViewmodel getAccountListGBMonthCategoryFrom:from to:to];
    
    self.dateString = [now formattedTimeWithFormat:DateSelectFormat];
    self.dateSelectView.dateLabel.text = [now formattedTimeWithFormat:DateSelectFormat];
    [self.dateSelectView.nextBtn setTitleColor:RGB(230, 230, 230) forState:UIControlStateNormal];
    
    
    [self showBasicPieDemo];
    [self.kEchartView loadEcharts];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Action

- (void)showBasicPieDemo {
    NSMutableArray *dateArray = [[NSMutableArray alloc] init];
    NSMutableArray *categoryNameArray = [[NSMutableArray alloc] init];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    for(AccountStatisticsModel *model in self.accountList){
        if(![[dict allKeys] containsObject:model.categoryName]){
            //不存在的情况
            NSMutableDictionary *monthDict = [[NSMutableDictionary alloc] init];
            [dict setObject:monthDict forKey:model.categoryName];
        }
        //往字典赛数据
        NSMutableDictionary *monthDict = [dict objectForKey:model.categoryName];
        [monthDict setObject:model.priceCount forKey:model.month];
        
        if(![dateArray containsObject:model.month]){
            [dateArray addObject:model.month];
        }
        if(![categoryNameArray containsObject:model.categoryName]){
            [categoryNameArray addObject:model.categoryName];
        }
    }
    //sql排序好了，无需排序
    
    NSMutableArray *seriesArray = [[NSMutableArray alloc] init];
    NSMutableDictionary *seriesDict;
    NSMutableArray *countArray;
    for(NSString *categoryName in categoryNameArray){
        NSDictionary *monthDict = [dict objectForKey:categoryName];
        seriesDict = [[NSMutableDictionary alloc] init];
        [seriesDict setObject:categoryName forKey:@"name"];
        [seriesDict setObject:@"line" forKey:@"type"];
        [seriesDict setObject:@"总量" forKey:@"stack"];
        [seriesDict setObject:@{@"normal":@{}} forKey:@"areaStyle"];
        countArray = [[NSMutableArray alloc] init];
        for(NSString *month in dateArray){
            [countArray addObject:monthDict[month]];
        }
        [seriesDict setObject:countArray forKey:@"data"];
        [seriesArray addObject:seriesDict];
    }
    
    
    
    NSString *basicPieJson = @"{\"title\": {\
    \"text\": \"\"\
    },\
    \"tooltip\" : {\
    \"trigger\": \"axis\"\
    },\
    \"legend\": {\
    \"data\":%@\
    },\
    \"toolbox\": {\
    \"feature\": {\
    \"saveAsImage\": {}\
    }\
    },\
    \"grid\": {\
    \"left\": \"3%\",\
    \"right\": \"4%\",\
    \"bottom\": \"3%\",\
    \"containLabel\": true\
    },\
    \"xAxis\" : [\
    {\
    \"type\" : \"category\",\
    \"boundaryGap\" : false,\
    \"data\" : %@\
    }\
    ],\
    \"yAxis\" : [\
    {\
    \"type\" : \"value\"\
    }\
    ],\
    \"series\" : %@}";
    basicPieJson = [NSString stringWithFormat:basicPieJson ,[categoryNameArray yy_modelToJSONString] ,[dateArray yy_modelToJSONString], [seriesArray yy_modelToJSONString]];
    basicPieJson = @"{\"title\": {    \"text\": \"\"    },    \"tooltip\" : {    \"trigger\": \"axis\"    },    \"legend\": {    \"data\":[\"零食\",\"护肤品\",\"衣服\",\"饮食\"]    },    \"toolbox\": {    \"feature\": {    \"saveAsImage\": {}    }    },    \"grid\": {    \"left\": \"3\",    \"right\": \"4\",    \"bottom\": \"3\",    \"containLabel\": true    },    \"xAxis\" : [    {    \"type\" : \"category\",    \"boundaryGap\" : false,    \"data\" : [\"2017-01\",\"2017-02\"]    }    ],    \"yAxis\" : [    {    \"type\" : \"value\"    }    ],    \"series\" : [{\"areaStyle\":{\"normal\":{}},\"data\":[\"642\",\"60\"],\"name\":\"零食\",\"type\":\"line\",\"stack\":\"总量\"},{\"areaStyle\":{\"normal\":{}},\"data\":[\"130\",\"30\"],\"name\":\"护肤品\",\"type\":\"line\",\"stack\":\"总量\"},{\"areaStyle\":{\"normal\":{}},\"data\":[\"23\",\"20\"],\"name\":\"衣服\",\"type\":\"line\",\"stack\":\"总量\"},{\"areaStyle\":{\"normal\":{}},\"data\":[\"34\",\"100\"],\"name\":\"饮食\",\"type\":\"line\",\"stack\":\"总量\"}]}";
    NSData *jsonData = [basicPieJson dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:nil];
    PYOption *option = [RMMapper objectWithClass:[PYOption class] fromDictionary:jsonDic];
    NSString *s = [PYJsonUtil getJSONString:option];
    [_kEchartView setOption:option];
}

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
        [_dateSelectView.lastBtn setTitle:@"前7月" forState:UIControlStateNormal];
        [_dateSelectView.nextBtn setTitle:@"后7月" forState:UIControlStateNormal];
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
