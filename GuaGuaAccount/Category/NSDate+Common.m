//
//  NSDate+Common.m
//  GuaGuaAccount
//
//  Created by xxb on 17/1/20.
//  Copyright © 2017年 xxb. All rights reserved.
//

#import "NSDate+Common.h"

@implementation NSDate (Common)

-(NSString *)formattedTimeWithFormat:(NSString *)dateFormat{
    NSString *ret = @"";
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = dateFormat;
    ret = [dateFormatter stringFromDate:self];
    return ret;
}

@end
