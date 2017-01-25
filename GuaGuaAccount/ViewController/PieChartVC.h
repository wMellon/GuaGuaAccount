//
//  PieChartVC.h
//  GuaGuaAccount
//
//  Created by xxb on 17/1/20.
//  Copyright © 2017年 xxb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PYEchartsView.h"

@interface PieChartVC : UIViewController

@property(nonatomic, strong) PYEchartsView *kEchartView;

- (void)reloadViewData;
@end
