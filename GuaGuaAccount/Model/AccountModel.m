//
//  AccountModel.m
//  GuaGuaAccount
//
//  Created by xxb on 17/1/17.
//  Copyright © 2017年 xxb. All rights reserved.
//

#import "AccountModel.h"

@implementation AccountModel

-(id)init{
    self = [super init];
    if(self){
        CFUUIDRef uuid = CFUUIDCreate(NULL);
        CFStringRef uuidStr = CFUUIDCreateString(NULL, uuid);
        _accountId = [[NSString stringWithFormat:@"%@", uuidStr] stringByReplacingOccurrencesOfString:@"-" withString:@""];
        _time = [[NSDate date] formattedTimeWithFormat:@"yyyy-MM-dd HH:mm:ss"];
    }
    return self;
}

+(NSArray *)getPrimaryKeyUnionArray
{
    return @[@"accountId"];
}

//表名
+(NSString *)getTableName
{
    return @"Account";
}
@end
