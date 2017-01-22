//
//  AccountViewmodel.h
//  GuaGuaAccount
//
//  Created by xxb on 17/1/15.
//  Copyright © 2017年 xxb. All rights reserved.
//

#import <Foundation/Foundation.h>

enum{
    TypePayOut = 0,  //支出
    TypeIncome = 1   //收入
};

#define timeFormat @"yyyy-MM-dd HH:mm:ss"

@interface AccountViewmodel : NSObject

+(NSMutableArray*)getPayOutCategorys;
+(NSMutableArray*)getInComeCategorys;

/**
 获取剩下money
 获取最新一次薪资以来，收入-支出剩下的钱
 */
+(void)getLastLeftMoneyWithBlock:(void(^)(NSString*leftCount,NSString*consumeCount))block;

/**
 获取收入几条，按类别统计

 @return array
 */
+(NSMutableArray*)getAccountByCategory;


/**
 获取消费数据

 @return array
 */
+(NSMutableArray*)getAccountList;
@end
