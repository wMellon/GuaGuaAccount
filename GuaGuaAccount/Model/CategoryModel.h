//
//  CategoryModel.h
//  GuaGuaAccount
//
//  Created by xxb on 17/1/15.
//  Copyright © 2017年 xxb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CategoryModel : NSObject

@property(nonatomic, copy) NSString *categoryId;
@property(nonatomic, copy) NSString *categoryName;
@property(nonatomic, copy) NSString *categoryPic;
@property(nonatomic, copy) NSString *categoryType;//支出or收入

@end
