//
//  AddAccountView.h
//  GuaGuaAccount
//
//  Created by xxb on 17/1/11.
//  Copyright © 2017年 xxb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "POPButton.h"

@interface AddAccountView : UIView

@property (weak, nonatomic) IBOutlet UILabel *tipLabel;
@property (weak, nonatomic) IBOutlet UICollectionView *categoryCollectionView;
@property (weak, nonatomic) IBOutlet UITextField *moneyTextField;
@property (weak, nonatomic) IBOutlet POPButton *typeBtn;
@property (weak, nonatomic) IBOutlet POPButton *saveBtn;


@end
