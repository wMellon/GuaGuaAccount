//
//  UIViewController+UI.m
//  GuaGuaAccount
//
//  Created by xxb on 17/1/20.
//  Copyright © 2017年 xxb. All rights reserved.
//

#import "UIViewController+UI.h"
#import "MDSnackbar.h"

@implementation UIViewController (UI)

-(void)showTip:(NSString*)content{
    MDSnackbar *snackbar = [[MDSnackbar alloc] initWithText:content
                                                actionTitle:@"好"];
    snackbar.actionTitleColor = RGB(76, 175, 80);
    snackbar.multiline = 1;
    [snackbar show];
}

-(void)showTipNoBtn:(NSString*)content{
    MDSnackbar *snackbar = [[MDSnackbar alloc] initWithText:content
                                                actionTitle:@""];
    snackbar.actionTitleColor = RGB(76, 175, 80);
    snackbar.multiline = 1;
    [snackbar show];
}

@end
