//
//  AccountModel.h
//  GuaGuaAccount
//
//  Created by xxb on 17/1/17.
//  Copyright © 2017年 xxb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AccountModel : NSObject

@property(nonatomic, copy) NSString *accountId;
@property(nonatomic, copy) NSString *time;
@property(nonatomic, copy) NSString *categoryId;
@property(nonatomic, copy) NSString *categoryName;
@property(nonatomic, copy) NSString *price;
@property(nonatomic, copy) NSString *remark;
@property(nonatomic, copy) NSString *accountType;//类型：支出0，收入1

@end
