//
//  AccountListCell.h
//  GuaGuaAccount
//
//  Created by xxb on 17/1/22.
//  Copyright © 2017年 xxb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AccountListCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *remarkLabel;

+(CGFloat)getCellHeight;

@end
