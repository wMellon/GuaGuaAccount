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
    self.frameHeight = ScreenHeight - 48;
    self.frameWidth = ScreenWidth;
    return self;
}

@end
