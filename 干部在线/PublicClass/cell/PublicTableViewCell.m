
//
//  PublicTableViewCell.m
//  干部在线
//
//  Created by lixianjun on 15-1-9.
//  Copyright (c) 2015年 中青年. All rights reserved.
//

#import "PublicTableViewCell.h"

@implementation PublicTableViewCell

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
    //左边图片
    leftImageView  = [MyContol createImageViewWithFrame:CGRectMake(15, 15, 100, 85) ImageName:@"首图标.jpg"];
    leftImageView.layer.cornerRadius = 4;
    leftImageView.layer.masksToBounds = YES;
    [self addSubview:leftImageView];
    UILabel * htlm =[[UILabel alloc] initWithFrame:CGRectMake(15, 20, 80, 40)];
    htlm.text = @"htlm5课件";
    htlm.textColor = [UIColor whiteColor];
    [leftImageView addSubview:htlm];
    [leftImageView addSubview:playIMageView];
    //课程
    classLabel = [MyContol createLabelWithFrame:CGRectMake(130, 10, [UIScreen mainScreen].bounds.size.width-140, 35) Font:14 Text:@"中国共产党第十八届中央委员会第三次全体会议"];
    classLabel.textColor = [UIColor colorWithRed:0.3 green:0.34 blue:0.3 alpha:1];
    classLabel.font = [UIFont boldSystemFontOfSize:14];
    classLabel.numberOfLines = 0;
    //    classLabel.backgroundColor =[UIColor redColor];
    classLabel.adjustsFontSizeToFitWidth = YES;
    [self addSubview:classLabel];
    //讲师
    lecturerLabel = [MyContol createLabelWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 100,45, 90, 20) Font:14 Text:@"讲师:李老师"];
    lecturerLabel.adjustsFontSizeToFitWidth  =  YES;
    lecturerLabel.textColor =[UIColor grayColor];
    [self addSubview:lecturerLabel];
    
    
    //课时
    classTimeLabel = [MyContol createLabelWithFrame:CGRectMake(130, 45, [UIScreen mainScreen].bounds.size.width - 130 - 86, 20) Font:14 Text:@"课时：130小时"];
    classTimeLabel.adjustsFontSizeToFitWidth = YES;
    
    classTimeLabel.textColor =[UIColor grayColor];
    //    classTimeLabel.backgroundColor =[UIColor yellowColor];
    [self addSubview:classTimeLabel];
    //积分
    markLabel = [MyContol createLabelWithFrame:CGRectMake(130, 65, [UIScreen mainScreen].bounds.size.width - 130 -125, 20) Font:14 Text:@"积分：25"];
    markLabel.adjustsFontSizeToFitWidth = YES;
    markLabel.textColor =[UIColor grayColor];
    //    markLabel.backgroundColor = [UIColor yellowColor];
    [self addSubview:markLabel];
    //学习人数
    leanNumberLabel = [MyContol createLabelWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 100, 65, 90, 20) Font:14 Text:@"点播次数:10次"];
    leanNumberLabel.adjustsFontSizeToFitWidth = YES;
    leanNumberLabel.textColor =[UIColor grayColor];
    //     leanNumberLabel.backgroundColor =[UIColor redColor];
    [self addSubview:leanNumberLabel];
    //显示星星
    startView * startViews = [[startView alloc] initWithFrame:CGRectMake(170, 87, 65, 23)];
    //startViews.backgroundColor =[UIColor redColor];
    [self addSubview:startViews];
    NSString * str = @"4";
    [startViews conFigNumber:[str floatValue]];
    commentLabel =  [MyContol createLabelWithFrame:CGRectMake(130, 86, 50, 20) Font:14 Text:@"评价 ："];
    commentLabel.textColor = [UIColor grayColor];
    [self addSubview:commentLabel];

    
}
//-(void)config:(publicClsaa*)model
//{
//    //左边图片
//    [leftImageView sd_setImageWithURL:[NSURL URLWithString:model.courseImg]];
//    //课程
//    classLabel.text = model.title;
//    //讲师
//    lecturerLabel.text = model.teacherName;
//    //课shi
//    classTimeLabel.text= [NSString stringWithFormat:@"课时：%d小时",model.period];
//    //积分
//    markLabel.text = [NSString stringWithFormat:@"积分：%d",model.period *10];
//    //学习人数
//    leanNumberLabel.text= [NSString stringWithFormat:@"学习人数：%d",model
//                           .studyNum];
//    
//}
@end
