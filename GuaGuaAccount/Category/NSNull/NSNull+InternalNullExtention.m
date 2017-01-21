//
//  NSNull+InternalNullExtention.m
//  ShortCakeSFPatient
//
//  Created by xxb on 15/10/22.
//  Copyright © 2015年 智业软件股份有限公司 睿康. All rights reserved.
//

#define NSNullObjects @[@"",@0,@{},@[]]

@interface NSNull (InternalNullExtention)
@end



@implementation NSNull (InternalNullExtention)


- (NSMethodSignature*)methodSignatureForSelector:(SEL)selector
{
    NSMethodSignature* signature = [super methodSignatureForSelector:selector];
    if (!signature) {
        for (NSObject *object in NSNullObjects) {
            signature = [object methodSignatureForSelector:selector];
            if (signature) {
                break;
            }
        }
    }
    return signature;
}

- (void)forwardInvocation:(NSInvocation *)anInvocation
{
    SEL aSelector = [anInvocation selector];
    
    for (NSObject *object in NSNullObjects) {
        if ([object respondsToSelector:aSelector]) {
            [anInvocation invokeWithTarget:object];
            return;
        }
    }
    
    [self doesNotRecognizeSelector:aSelector];
}
@end
