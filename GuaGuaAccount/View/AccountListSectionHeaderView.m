//
//  AccountListSectionHeaderView.m
//  GuaGuaAccount
//
//  Created by xxb on 17/1/22.
//  Copyright © 2017年 xxb. All rights reserved.
//

#import "AccountListSectionHeaderView.h"

@implementation AccountListSectionHeaderView

-(id)init{
    self = [[[NSBundle mainBundle] loadNibNamed:@"AccountListSectionHeaderView" owner:nil options:nil] firstObject];
    self.frameWidth = ScreenWidth;
    return self;
}

@end
