//
//  WaveChartVC.m
//  GuaGuaAccount
//
//  Created by xxb on 17/1/20.
//  Copyright © 2017年 xxb. All rights reserved.
//

#import "WaveChartVC.h"
#import "WaveDateSelectView.h"
#import "AccountViewmodel.h"
#import "PYOption.h"
#import "RMMapper.h"
#import "AccountStatisticsModel.h"
#import "PYEchartsView.h"
#import "PYJsonUtil.h"

@interface WaveChartVC ()

@property (nonatomic, strong) WaveDateSelectView *dateSelectView;
@property (nonatomic, strong) NSMutableArray *accountList;
@property (nonatomic, strong) PYEchartsView *kEchartView;

@property (nonatomic, strong) NSDate *getDataFromDate;//获取日期的开始时间
@property (nonatomic, strong) NSDate *getDataToDate;//获取日期的结束时间

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
    NSDate *startDateOfDay = [now getFirstDateForThisMonth];
    self.getDataToDate = startDateOfDay;
    self.getDataFromDate = [startDateOfDay distanceByOffsetMonthes:-6];
    
    //获取数据
    self.accountList = [AccountViewmodel getAccountListGBMonthCategoryFrom:[self.getDataFromDate formattedTimeWithFormat:DateSelectFormat] to:[self.getDataToDate formattedTimeWithFormat:DateSelectFormat]];
    
    self.dateSelectView.dateLabel.text = [NSString stringWithFormat:@"%@~%@", DateSelectShort([self.getDataFromDate formattedTimeWithFormat:DateSelectFormat]), DateSelectShort([self.getDataToDate formattedTimeWithFormat:DateSelectFormat])];
    self.dateSelectView.nextBtn.enabled = NO;
    
    [self showBasicPieDemo];
    [self.kEchartView loadEcharts];
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
            NSString *temp = monthDict[month];
            if(temp.length <= 0){
                temp = @"0";
            }
            [countArray addObject:temp];
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
    NSData *jsonData = [basicPieJson dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:nil];
    PYOption *option = [RMMapper objectWithClass:[PYOption class] fromDictionary:jsonDic];
    [_kEchartView setOption:option];
}

-(void)lastSexMonth{
    GGWeakSelfDefine
    [AccountViewmodel getSelectDateBy:self.getDataFromDate monthOffset:-6 block:^(BOOL canNext, NSDate *date) {
        GGWeakSelf.getDataToDate = GGWeakSelf.getDataFromDate;
        GGWeakSelf.getDataFromDate = date;
        GGWeakSelf.dateSelectView.dateLabel.text = [NSString stringWithFormat:@"%@~%@", DateSelectShort([self.getDataFromDate formattedTimeWithFormat:DateSelectFormat]), DateSelectShort([self.getDataToDate formattedTimeWithFormat:DateSelectFormat])];
        GGWeakSelf.accountList = [AccountViewmodel getAccountListGBMonthCategoryFrom:[GGWeakSelf.getDataFromDate formattedTimeWithFormat:DateSelectFormat] to:[GGWeakSelf.getDataToDate formattedTimeWithFormat:DateSelectFormat]];
        [GGWeakSelf showBasicPieDemo];
        [GGWeakSelf.kEchartView loadEcharts];
        GGWeakSelf.dateSelectView.nextBtn.enabled = canNext;
    }];
}

-(void)nextSexMonth{
    GGWeakSelfDefine
    [AccountViewmodel getSelectDateBy:self.getDataToDate monthOffset:6 block:^(BOOL canNext, NSDate *date) {
        GGWeakSelf.getDataFromDate = GGWeakSelf.getDataToDate;
        GGWeakSelf.getDataToDate = date;
        GGWeakSelf.dateSelectView.dateLabel.text = [NSString stringWithFormat:@"%@~%@", DateSelectShort([self.getDataFromDate formattedTimeWithFormat:DateSelectFormat]), DateSelectShort([self.getDataToDate formattedTimeWithFormat:DateSelectFormat])];
        GGWeakSelf.accountList = [AccountViewmodel getAccountListGBMonthCategoryFrom:[GGWeakSelf.getDataFromDate formattedTimeWithFormat:DateSelectFormat] to:[GGWeakSelf.getDataToDate formattedTimeWithFormat:DateSelectFormat]];
        [GGWeakSelf showBasicPieDemo];
        [GGWeakSelf.kEchartView loadEcharts];
        GGWeakSelf.dateSelectView.nextBtn.enabled = canNext;
    }];
}

#pragma mark - Properrtys

-(WaveDateSelectView *)dateSelectView{
    if(!_dateSelectView){
        _dateSelectView = [[WaveDateSelectView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 50)];
        [_dateSelectView.lastBtn addTarget:self action:@selector(lastSexMonth) forControlEvents:UIControlEventTouchUpInside];
        [_dateSelectView.nextBtn addTarget:self action:@selector(nextSexMonth) forControlEvents:UIControlEventTouchUpInside];
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
