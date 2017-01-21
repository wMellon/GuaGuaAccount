//
//  AccountHistoryVC.m
//  GuaGuaAccount
//
//  Created by xxb on 17/1/11.
//  Copyright © 2017年 xxb. All rights reserved.
//

#import "AccountHistoryVC.h"
#import "YSLContainerViewController.h"
#import "AccountListVC.h"
#import "PieChartVC.h"
#import "WaveChartVC.h"

@interface AccountHistoryVC ()<YSLContainerViewControllerDelegate>

@property(nonatomic, strong) AccountListVC *listVC;
@property(nonatomic, strong) PieChartVC *pieVC;
@property(nonatomic, strong) WaveChartVC *waveVC;

@end

@implementation AccountHistoryVC

#pragma mark - Life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupContentView];
}

- (void)setupContentView{
    YSLContainerViewController *containerVC = [[YSLContainerViewController alloc]initWithControllers:@[self.listVC,self.pieVC,self.waveVC] topBarHeight:20 parentViewController:self];
    containerVC.delegate = self;
    containerVC.menuItemFont = [UIFont fontWithName:@"Futura-Medium" size:16];
    [self.view addSubview:containerVC.view];
}

#pragma mark - View delegate

- (void)containerViewItemIndex:(NSInteger)index currentController:(UIViewController *)controller{
    
}


#pragma mark - Other delegate


#pragma mark - Action


#pragma mark - Properrtys

-(AccountListVC*)listVC{
    if(!_listVC){
        _listVC = [[AccountListVC alloc] init];
        _listVC.title = @"账单";
    }
    return _listVC;
}

-(PieChartVC*)pieVC{
    if(!_pieVC){
        _pieVC = [[PieChartVC alloc] init];
        _pieVC.title = @"饼图";
    }
    return _pieVC;
}

-(WaveChartVC*)waveVC{
    if(!_waveVC){
        _waveVC = [[WaveChartVC alloc] init];
        _waveVC.title = @"波浪图";
    }
    return _waveVC;
}
@end
