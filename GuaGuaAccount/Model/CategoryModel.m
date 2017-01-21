//
//  CategoryModel.m
//  GuaGuaAccount
//
//  Created by xxb on 17/1/15.
//  Copyright © 2017年 xxb. All rights reserved.
//

#import "CategoryModel.h"

@implementation CategoryModel

+(NSArray *)getPrimaryKeyUnionArray
{
    return @[@"categoryId"];
}

//表名
+(NSString *)getTableName
{
    return @"Category";
}

@end
