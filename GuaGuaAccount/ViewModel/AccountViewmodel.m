//
//  AccountViewmodel.m
//  GuaGuaAccount
//
//  Created by xxb on 17/1/15.
//  Copyright © 2017年 xxb. All rights reserved.
//

#import "AccountViewmodel.h"
#import "CategoryModel.h"
#import "AccountModel.h"
#import "AccountStatisticsModel.h"

#define PayOutCategoryNames @[@"饮食",@"衣服",@"护肤品",@"日用",@"外借",@"零食",@"装饰",@"电影"]
#define InComeCategoryNames @[@"工资",@"还钱"]//薪资ID必须是0
#define MonthBeginFrom 5  //每个月从5号算起

@implementation AccountViewmodel

+(void)load{
    //本地初始化类别
    int index = 0;
    CategoryModel *model;
    for(NSString *name in InComeCategoryNames){
        model = [[CategoryModel alloc] init];
        model.categoryId = [NSString stringWithFormat:@"%d", index];
        model.categoryName = name;
        model.categoryType = enumToString(TypeIncome);
        [model saveToDB];
        index ++;
    }
    for(NSString *name in PayOutCategoryNames){
        model = [[CategoryModel alloc] init];
        model.categoryId = [NSString stringWithFormat:@"%d", index];
        model.categoryName = name;
        model.categoryType = enumToString(TypePayOut);
        [model saveToDB];
        index ++;
    }
}

+(NSMutableArray*)getPayOutCategorys{
    return [CategoryModel searchWithWhere:[NSString stringWithFormat:@"categoryType='%@'", enumToString(TypePayOut)]];
}

+(NSMutableArray*)getInComeCategorys{
    return [CategoryModel searchWithWhere:[NSString stringWithFormat:@"categoryType='%@'", enumToString(TypeIncome)]];
}

+(void)getLastLeftMoneyWithBlock:(void(^)(NSString*leftCount,NSString*consumeCount))block{
    NSString *sql = @"SELECT \
                        * \
                        FROM \
                        Account \
                        WHERE \
                        time >= ( \
                             SELECT \
                             time \
                             FROM \
                             Account \
                             WHERE \
                             categoryId = '0' \
                             ORDER BY \
                             time DESC \
                             LIMIT 0, \
                             1 \
                         )";
    NSMutableArray *array = [AccountModel searchWithSQL:sql];
    NSDecimalNumber *number;
    NSDecimalNumber *inComeCount = [NSDecimalNumber decimalNumberWithString:@"0.0"];
    NSDecimalNumber *leftCount = [NSDecimalNumber decimalNumberWithString:@"0.0"];
    NSDecimalNumber *consumeCount = [NSDecimalNumber decimalNumberWithString:@"0.0"];
    for(AccountModel *model in array){
        number = [NSDecimalNumber decimalNumberWithString:model.price];
        if([model.accountType isEqualToString:enumToString(TypeIncome)]){
            //收入
            leftCount = [leftCount decimalNumberByAdding:number];
            inComeCount = [inComeCount decimalNumberByAdding:number];
        }else{
            //支出
            leftCount = [leftCount decimalNumberBySubtracting:number];
            consumeCount = [consumeCount decimalNumberByAdding:number];
        }
    }
    NSString *leftCountS;
    if(inComeCount.doubleValue <= 0){
        //如果没有录入收入的话
        leftCountS = @"--";
    }else{
        leftCountS = [NSString stringWithFormat:@"%g", leftCount.doubleValue];
    }
    block(leftCountS,[NSString stringWithFormat:@"%g", consumeCount.doubleValue]);
}

+(NSMutableArray*)getAccountByCategory{
    NSString *sql = [NSString stringWithFormat:@"SELECT \
                    *,sum(price) priceCount \
                    FROM \
                    Account \
                    WHERE accountType = '%@' \
                    GROUP BY \
                    categoryId", enumToString(TypePayOut)];
    return [AccountStatisticsModel searchWithSQL:sql];
}

@end
