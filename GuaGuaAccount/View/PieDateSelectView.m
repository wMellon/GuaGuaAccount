//
//  DateSelectView.m
//  GuaGuaAccount
//
//  Created by xxb on 17/1/20.
//  Copyright © 2017年 xxb. All rights reserved.
//

#import "PieDateSelectView.h"

@implementation PieDateSelectView

-(id)init{
    self = [super init];
    if(self){
        [self setupContentView];
        [self autoLayout];
    }
    return self;
}

-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        [self setupContentView];
        [self autoLayout];
    }
    return self;
}

-(void)setupContentView{
    self.backgroundColor = RGB(242, 242, 242);
    
    _dateLabel = [[UILabel alloc] init];
    _dateLabel.textColor = RGB(0, 122, 255);
    _dateLabel.font = [UIFont systemFontOfSize:17];
    [self addSubview:_dateLabel];
    
    _lastBtn = [[UIButton alloc] init];
    [_lastBtn setTitle:@"<" forState:UIControlStateNormal];
    [_lastBtn setTitleColor:RGB(153, 153, 153) forState:UIControlStateNormal];
    [_lastBtn setTitleColor:RGB(230, 230, 230) forState:UIControlStateDisabled];
    [self addSubview:_lastBtn];
    
    _nextBtn = [[UIButton alloc] init];
    [_nextBtn setTitle:@">" forState:UIControlStateNormal];
    [_nextBtn setTitleColor:RGB(153, 153, 153) forState:UIControlStateNormal];
    [_nextBtn setTitleColor:RGB(230, 230, 230) forState:UIControlStateDisabled];
    [self addSubview:_nextBtn];
}

-(void)autoLayout{
    _dateLabel.sd_layout
    .centerYEqualToView(self)
    .centerXEqualToView(self)
    .heightIs(_dateLabel.font.lineHeight);
    [_dateLabel setSingleLineAutoResizeWithMaxWidth:200];
    
    _lastBtn.sd_layout
    .rightSpaceToView(_dateLabel, 10)
    .centerYEqualToView(_dateLabel)
    .heightIs(15)
    .widthIs(15);
    
    _nextBtn.sd_layout
    .leftSpaceToView(_dateLabel, 10)
    .centerYEqualToView(_dateLabel)
    .heightIs(15)
    .widthIs(15);
}
@end
