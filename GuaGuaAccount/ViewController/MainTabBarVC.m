//
//  MainTabBarVC.m
//  GuaGuaAccount
//
//  Created by xxb on 17/1/11.
//  Copyright © 2017年 xxb. All rights reserved.
//

#import "MainTabBarVC.h"
#import "AddAccountVC.h"
#import "AccountHistoryVC.h"
#import "LKDBUtils.h"

@interface MainTabBarVC ()

@property(nonatomic, strong) AddAccountVC *addVC;
@property(nonatomic, strong) AccountHistoryVC *historyVC;

@end

@implementation MainTabBarVC

#pragma mark - Life cycle

-(id)init{
    self = [super init];
    if(self){
        _addVC = [[AddAccountVC alloc] init];
        _addVC.tabBarItem.title = @"记一笔";
        _historyVC = [[AccountHistoryVC alloc] init];
        _historyVC.tabBarItem.title = @"看一眼";
        self.viewControllers = @[_addVC, _historyVC];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"db: %@", [LKDBUtils getDocumentPath]);
}

- (void)setupContentView{}

- (void)reloadViewData{}


#pragma mark - UITableView delegate


#pragma mark - View delegate


#pragma mark - Other delegate


#pragma mark - Action


#pragma mark - Properrtys
@end
