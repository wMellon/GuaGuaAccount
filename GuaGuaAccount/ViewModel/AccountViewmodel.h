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
#define DateSelectFormat @"yyyy年MM月"

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

/**
 根据日期获取一个月内的消费
 
 @param dateString 有特殊格式的
 @return 数组
 */
+(NSMutableArray*)getAccountByDate:(NSString*)dateString;

/**
 根据日期选择的格式来返回上/下个月的日期字符串

 @param dateString 字符串
 */
+(void)getSelectDateBy:(NSString*)dateString monthOffset:(NSInteger)offset block:(void(^)(BOOL canNext, NSString *dateString))callBack;

/**
 从起始日期到结束日期按照月份、类别分组获取数据

 @param from 起始日期
 @param to 结束日期
 */
+(NSMutableArray*)getAccountListGBMonthCategoryFrom:(NSString*)from to:(NSString*)to;

@end
