//
//  NSDate+Common.m
//  GuaGuaAccount
//
//  Created by xxb on 17/1/20.
//  Copyright © 2017年 xxb. All rights reserved.
//

#import "NSDate+Common.h"

#define DATE_COMPONENTS (NSYearCalendarUnit| NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekCalendarUnit |  NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit | NSWeekdayCalendarUnit | NSWeekdayOrdinalCalendarUnit)
#define CURRENT_CALENDAR [NSCalendar currentCalendar]

@implementation NSDate (Common)

-(NSString *)formattedTimeWithFormat:(NSString *)dateFormat{
    NSString *ret = @"";
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = dateFormat;
    ret = [dateFormatter stringFromDate:self];
    return ret;
}

/*nsstring转nsdate 带格式*/
+(NSDate*) convertDateFromString:(NSString*)dateString andFormat:(NSString*)formatter{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //时间偏差处理
    [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    
    [dateFormatter setDateFormat:formatter];
    
    NSDate *destDate= [dateFormatter dateFromString:dateString];
    
    return destDate;
}

- (NSInteger) year
{
    NSDateComponents *components = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:self];
    return components.year;
}

- (NSInteger) month
{
    NSDateComponents *components = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:self];
    return components.month;
}

- (NSInteger) weekday{
    NSDateComponents *components = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:self];
    return components.weekday;
}

#pragma mark -根据偏移量算出偏移到了几月份

-(NSInteger)getMonthByOffset:(NSInteger)offset{
    NSInteger currentMonth = [[[self formattedTimeWithFormat:@"yyyy-MM-dd HH:mm:ss"] substringWithRange:NSMakeRange(5, 2)] integerValue];
    if(offset == 0){
        return currentMonth;
    }else if(offset > 0){
        NSInteger temp = (currentMonth + offset) % 12;
        if(temp == 0){
            //11月份+1就是12月份
            return 12;
        }else{
            //其余的(1-11)
            return temp;
        }
    }else{
        //offset<0
        NSInteger temp = (currentMonth + offset) % 12;
        if(temp > 0){
            return temp;
        }else if(temp == 0){
            return 12;
        }else{
            return 12 + temp;
        }
    }
}

#pragma mark -根据偏移量算出偏移到了第几年

-(NSInteger)getYearByOffset:(NSInteger)offset{
    NSString *temp = [self formattedTimeWithFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSInteger currentYear = [[temp substringToIndex:4] integerValue];
    NSInteger currentMonth = [[temp substringWithRange:NSMakeRange(5, 2)] integerValue];
    if(offset == 0){
        return currentYear;
    }else if(offset > 0){
        NSInteger temp = currentMonth + offset;
        if(temp % 12 == 0){
            return currentYear + temp / 12 - 1;
        }else{
            return currentYear + temp / 12;
        }
    }else{
        NSInteger temp = currentMonth + offset;
        if(temp > 0){
            return currentYear;
        }else if(temp == 0){
            return currentYear - 1;
        }else{
            if(temp % 12 == 0){
                return currentYear + temp / 12 - 1;
            }else{
                return currentYear + floor((double)temp / 12);
            }
        }
    }
}

-(NSDate*)distanceByOffsetMonthes:(NSInteger)monthes{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond) fromDate:self];
    [components setMonth:(components.month + monthes)];
    return [calendar dateFromComponents:components];
}

/**
 获取该日期在这个月的第一天
 
 @return 日期
 */
-(NSDate*)getFirstDateForThisMonth{
    NSDate *startDateOfDay;
    NSTimeInterval TIOfDay;
    //获取该日期最早的天数
    [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitMonth startDate:&startDateOfDay interval:&TIOfDay forDate:self];
    return startDateOfDay;
}
@end
