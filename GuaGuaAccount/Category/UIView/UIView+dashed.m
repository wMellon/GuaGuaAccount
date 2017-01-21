//
//  UIView+dashed.m
//  xjdoctor
//
//  Created by aiyoyou on 16/2/2.
//  Copyright © 2016年 zoenet. All rights reserved.
//

#import "UIView+dashed.h"

@implementation UIView (dashed)

- (void)layerDashedWithColer:(UIColor *)strokeColor {
    CAShapeLayer *borderLayer = [CAShapeLayer layer];
    borderLayer.bounds = CGRectMake(0, 0,self.frame.size.width,self.frame.size.height);
    borderLayer.position = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
    
    borderLayer.path = [UIBezierPath bezierPathWithRect:borderLayer.bounds].CGPath;
    borderLayer.lineWidth = 2. / [[UIScreen mainScreen] scale];
    //虚线边框
    borderLayer.lineDashPattern = @[@5, @5];
    //实线边框
    //borderLayer.lineDashPattern = nil;
    borderLayer.fillColor = [UIColor clearColor].CGColor;
    borderLayer.strokeColor = strokeColor.CGColor;
    [self.layer addSublayer:borderLayer];
}

@end
