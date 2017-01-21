//
//  NSString+Common.m
//  ShortCakeSFPatient
//
//  Created by amu on 15/4/20.
//  Copyright (c) 2015年 智业软件股份有限公司 糖友网 . All rights reserved.
//

#import "NSString+Common.h"

@implementation NSString (Common)

#pragma mark - 判断是否为空
+ (BOOL) isBlankString:(NSString *)string {
    if (string == nil || string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    return NO;
}

@end
