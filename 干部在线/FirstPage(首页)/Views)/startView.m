//
//  startView.m
//  干部在线
//
//  Created by lixianjun on 14-12-31.
//  Copyright (c) 2014年 中青年. All rights reserved.
//

#import "startView.h"

@implementation startView
-(id)initWithFrame:(CGRect)frame
{

    self  = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}
-(void)createUI
{
    //背景星星
   bgImageView = [MyContol createImageViewWithFrame:CGRectMake(0, 0, 65,23) ImageName:@"StarsBackground.png"];
    bgImageView.backgroundColor =[UIColor colorWithRed:0.94f green:0.94f blue:0.94f alpha:1.00f];
       [self addSubview:bgImageView];
    //上边的红星星
    startImageView = [MyContol createImageViewWithFrame:CGRectMake(0, 0, 65, 23) ImageName:@"starts.png"];
    //设置停靠模式
    startImageView.contentMode=UIViewContentModeLeft;
    //设置裁剪
    startImageView.clipsToBounds=YES;
    [self addSubview:startImageView];

}

-(void)conFigNumber:(float)num
{

startImageView.frame=CGRectMake(0, 0, 65/5*num *1/ 2.0, 23);
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
