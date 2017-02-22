//
//  AccountStatisticsModel.h
//  GuaGuaAccount
//
//  Created by xxb on 17/1/21.
//  Copyright © 2017年 xxb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AccountStatisticsModel : NSObject

@property(nonatomic, copy) NSString *accountId;
@property(nonatomic, copy) NSString *categoryId;
@property(nonatomic, copy) NSString *categoryName;
@property(nonatomic, copy) NSString *priceCount;
@property(nonatomic, copy) NSString *accountType;//类型：支出0，收入1
@property(nonatomic, copy) NSString *month;

@end
