//
//  ElectCourevIEW.m
//  干部在线
//
//  Created by lixianjun on 15-1-8.
//  Copyright (c) 2015年 中青年. All rights reserved.
//

#import "ElectCoureView.h"

@implementation ElectCoureView
-(id)initWithFrame:(CGRect)frame
{
    
    self = [super initWithFrame:frame];
    if (self) {
        [self makeUI];
    }
    return self;
}
-(void)makeUI
{
    
    //图标
    logoImageView= [MyContol createImageViewWithFrame:CGRectMake(0, 0, 5, 40) ImageName:@"分隔条.png"];
    [self addSubview:logoImageView];
    
    //标题
    titleLabel = [MyContol createLabelWithFrame:CGRectMake(15, 5, 200, 30) Font:18 Text:nil];
    [self addSubview:titleLabel];
    
}
-(void)config:(NSDictionary *)dic
{
    titleLabel.text = dic[@"parentCategoryName"];
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
