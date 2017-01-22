//
//  AddAccountView.m
//  GuaGuaAccount
//
//  Created by xxb on 17/1/11.
//  Copyright © 2017年 xxb. All rights reserved.
//

#import "AddAccountView.h"

@implementation AddAccountView

-(id)init{
    self = [[[NSBundle mainBundle] loadNibNamed:@"AddAccountView" owner:nil options:nil] firstObject];
    [self addSubview:self.menuView];
    self.frameHeight = ScreenHeight - 48;
    self.frameWidth = ScreenWidth;
    return self;
}

-(MGFashionMenuView *)menuView{
    if(!_menuView){
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 60)];
        [view setBackgroundColor:[UIColor colorWithRed:0 green:0.722 blue:1 alpha:1]];
        _menuLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 30, view.frameWidth, 30)];
        _menuLabel.textColor = [UIColor whiteColor];
        _menuLabel.textAlignment = NSTextAlignmentCenter;
        [view addSubview:_menuLabel];
        _menuView = [[MGFashionMenuView alloc] initWithMenuView:view];
    }
    return _menuView;
}

@end
