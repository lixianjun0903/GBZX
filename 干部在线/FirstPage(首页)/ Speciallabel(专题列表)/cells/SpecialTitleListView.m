//
//  SpecialTitleListView.m
//  干部在线
//
//  Created by lixianjun on 15-1-9.
//  Copyright (c) 2015年 中青年. All rights reserved.
//

#import "SpecialTitleListView.h"
#import "SpecialClassDetailViewController.h"
@implementation SpecialTitleListView
-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}
-(void)createUI
{
    //titlelabel
    titleLabel = [MyContol createLabelWithFrame:CGRectMake(0, 5, self.frame.size.width, 20) Font:15 Text:@"全面推进依法治国"];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:titleLabel];
    //logo图片
    imageView = [MyContol createImageViewWithFrame:CGRectMake(10, 30,self.frame.size.width-20,140) ImageName:@"image0.png"];
    [self addSubview:imageView];
    //课程数量
    classNumber = [MyContol createLabelWithFrame:CGRectMake(10, 175, 140, 20) Font:15 Text:@"课程数量：10门"];
    //classNumber.backgroundColor = [UIColor grayColor];
    [self addSubview:classNumber];
    //上线时间
    startTime =[MyContol createLabelWithFrame:CGRectMake(self.frame.size.width - 190, 175,[UIScreen mainScreen].bounds.size.width - 170, 20) Font:15 Text:@"上线时间：2013:1月：1日"];
    [self addSubview:startTime];
//    //详细描述
    describeLbel =[MyContol createLabelWithFrame:CGRectMake(0,205,self.frame.size.width, 40) Font:15 Text:@"为确保团的业务课程质量，团中央机关各部门精心备课，对工作进行了系统梳理，形成了标准化讲稿。为确保团的业务课程质量，团中央机关各部门精心备课，对工作进行了系统梳理，形成了标准化讲稿"];
    describeLbel.numberOfLines = 2;
    describeLbel.lineBreakMode = NSLineBreakByWordWrapping;
   
    [self addSubview:describeLbel];
    //更多
    moreButton = [MyContol createButtonWithFrame:CGRectMake(describeLbel.frame.size.width - 50, 20, 40, 25) ImageName:nil Target:self Action:@selector(moreButton) Title:@"更多"];
    moreButton.titleLabel.font =[UIFont boldSystemFontOfSize:15];
    [moreButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [describeLbel addSubview:moreButton];
   moreButton.backgroundColor =[UIColor redColor];
    
       //黑线条
    backGroundView = [[UIView alloc] initWithFrame:CGRectMake(10, 265,self.frame.size.width - 20, 1)];
    backGroundView.backgroundColor =[UIColor colorWithRed:244/255.0 green:244/255.0 blue:244/255.0 alpha:1];
    [self addSubview:backGroundView];
    //进入专题
        enterSpecial = [MyContol createButtonWithFrame:CGRectMake(30, 290, 120, 40) ImageName:nil Target:self Action:@selector(enterClick) Title:@"进入专题"];
    
    enterSpecial.layer.cornerRadius = 5;
    enterSpecial.layer.masksToBounds = YES;
    enterSpecial.backgroundColor =[UIColor colorWithRed:0.19f green:0.51f blue:0.94f alpha:1.00f];
    [self addSubview:enterSpecial];
//    //选择全部课程
//    selectAllCourceButton = [MyContol createButtonWithFrame:CGRectMake(self.frame.size.width - 120 - 30, 290, 120, 40) ImageName:nil Target:selectButton Action:@selector(classButtonClick) Title:@"选择全部课程"];
//    selectAllCourceButton.layer.cornerRadius = 5;
//    selectAllCourceButton.layer.masksToBounds = YES;
//    selectAllCourceButton.backgroundColor =[UIColor colorWithRed:0.19f green:0.51f blue:0.94f alpha:1.00f];
//    [self addSubview:selectAllCourceButton];
}
-(void)config:(NSDictionary*)dic
{
    //titlelabel
    titleLabel.text = dic[@""];
    //logo图片
    [imageView sd_setImageWithURL:[NSURL URLWithString:dic[@""]]];
    //课程数量
    classNumber.text = dic[@""];
    //详细描述
}

-(void)enterClick
{
    NSLog(@"进入专题");
    SpecialClassDetailViewController * vc =[[SpecialClassDetailViewController alloc] init];
    [self.delegate.navigationController pushViewController:vc animated:YES];

    
}
-(void)classButtonClick
{
    
    NSLog(@"选择全部课程");
}
#pragma mark 更多内容
-(void)moreButton
{

    NSLog(@"显示更多内容");
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
