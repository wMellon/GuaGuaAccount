//
//  AddAccountView.h
//  GuaGuaAccount
//
//  Created by xxb on 17/1/11.
//  Copyright © 2017年 xxb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "POPButton.h"
#import "MGFashionMenuView.h"

#define SaveBtnMinBottomSpace 216  //保存按钮距离底部最小要216

@interface AddAccountView : UIView

@property (strong, nonatomic) MGFashionMenuView *menuView;
@property (strong, nonatomic) UILabel *menuLabel;
@property (weak, nonatomic) IBOutlet UICollectionView *categoryCollectionView;
@property (weak, nonatomic) IBOutlet UITextField *moneyTextField;
@property (weak, nonatomic) IBOutlet POPButton *typeBtn;
@property (weak, nonatomic) IBOutlet POPButton *saveBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *saveBtnBottomSpace;


@end
