//
//  CALayer+IJColorLayer.m
//  IJHealth
//
//  Created by xxb on 16/2/26.
//  Copyright © 2016年 智业互联网络科技有限公司 艾嘉健康. All rights reserved.
//

#import "CALayer+IJXibConfiguration.h"

@implementation CALayer (IJColorLayer)

-(void)setBorderUIColor:(UIColor*)color
{
    self.borderColor = color.CGColor;
}

-(UIColor*)borderUIColor
{
    return [UIColor colorWithCGColor:self.borderColor];
}

@end
