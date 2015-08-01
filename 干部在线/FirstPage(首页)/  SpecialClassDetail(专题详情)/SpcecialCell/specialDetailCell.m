//
//  specialDetailCell.m
//  干部在线
//
//  Created by lixianjun on 15-1-4.
//  Copyright (c) 2015年 中青年. All rights reserved.
//

#import "specialDetailCell.h"

@implementation specialDetailCell
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
    titleLabel.font = [UIFont boldSystemFontOfSize:20];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:titleLabel];
    //logo图片
    imageView = [MyContol createImageViewWithFrame:CGRectMake(10, 30, self.frame.size.width-20,140) ImageName:@"image0.png"];
    imageView.layer.cornerRadius = 8;
    imageView.layer.masksToBounds  = YES;
    [self addSubview:imageView];
    //课程数量
    classNumber = [MyContol createLabelWithFrame:CGRectMake(10, 175, 140, 20) Font:15 Text:@"课程数量：10门"];
    //classNumber.backgroundColor = [UIColor grayColor];
    [self addSubview:classNumber];
    //上线时间
    startTime =[MyContol createLabelWithFrame:CGRectMake(self.frame.size.width - 190, 175, self.frame.size.width - 170, 20) Font:15 Text:@"上线时间：2013:1月：1日"];
    [self addSubview:startTime];
    //详细描述
    describeLbel =[MyContol createLabelWithFrame:CGRectMake(10, 205, self.frame.size.width-20, 40) Font:15 Text:@"为确保团的业务课程质量，团中央机关各部门精心备课，对工作进行了系统梳理，形成了标准化讲稿。为了让授课内容更贴近基层干部需要，在轮训工作启动前举办了专题研讨会，邀请基层团干部进行试听，对课程内容提出修改意见"];
    [self addSubview:describeLbel];
    backGroundView = [[UIView alloc] initWithFrame:CGRectMake(10, 265, self.frame.size.width - 20, 1)];
    backGroundView.backgroundColor =[UIColor colorWithRed:244/255.0 green:244/255.0 blue:244/255.0 alpha:1];
    [self addSubview:backGroundView];
//    selectButton = [MyContol createButtonWithFrame:CGRectMake(self.frame.size.width / 3.0 - 15, 270, self.frame.size.width / 3.0+30, 40) ImageName:nil Target:selectButton Action:@selector(classButtonClick) Title:@"选择全部课程"];
//    selectButton.layer.cornerRadius = 10;
//    selectButton.layer.masksToBounds =YES;
//    selectButton.backgroundColor =[UIColor colorWithRed:49/255.0 green:130/255.0 blue:239/255.0 alpha:1];
//    
//    [self addSubview:selectButton];

    
}
-(void)config:(NSDictionary *)dic
{
    //titlelabel
    titleLabel.text = dic[@"topicName"];
    //logo图片
    [imageView sd_setImageWithURL:[NSURL URLWithString:dic[@"topicImgUrl"]]placeholderImage:[UIImage imageNamed:@"course_bg_g.png"]];
    //课程数量
    classNumber.text = [NSString stringWithFormat:@"课程数量: %@",dic[@"courseNum"]];
    //上线时间
    startTime.text = [NSString stringWithFormat:@"上线时间：%@",dic[@"createTime"]];
    //详细描述
    describeLbel.text  = dic[@"topicIntro"];

}
#pragma mark 选课
-(void)classButtonClick{

    NSLog(@"选课");
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
