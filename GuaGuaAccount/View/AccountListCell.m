//
//  AccountListCell.m
//  GuaGuaAccount
//
//  Created by xxb on 17/1/22.
//  Copyright © 2017年 xxb. All rights reserved.
//

#import "AccountListCell.h"

@implementation AccountListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+(CGFloat)getCellHeight{
    return 70;
}

@end
