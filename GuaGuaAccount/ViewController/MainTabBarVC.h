//
//  MainTabBarVC.h
//  GuaGuaAccount
//
//  Created by xxb on 17/1/11.
//  Copyright © 2017年 xxb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddAccountVC.h"
#import "AccountHistoryVC.h"

@interface MainTabBarVC : UITabBarController

@property(nonatomic, strong) AddAccountVC *addVC;
@property(nonatomic, strong) AccountHistoryVC *historyVC;

@end
