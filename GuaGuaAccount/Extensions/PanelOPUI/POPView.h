//
//  POPView.h
//  FamilyDoctor
//
//  Created by xxb on 16/12/28.
//  Copyright © 2016年 zoenet. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE
@interface POPView : UIView

// 注意: 加上IBInspectable就可以可视化显示相关的属性哦
/** 可视化设置边框宽度 */
@property (nonatomic, assign)IBInspectable CGFloat borderWidth;
/** 可视化设置边框颜色 */
@property (nonatomic, strong)IBInspectable UIColor *borderColor;

/** 可视化设置圆角 */
@property (nonatomic, assign)IBInspectable CGFloat cornerRadius;

@end
