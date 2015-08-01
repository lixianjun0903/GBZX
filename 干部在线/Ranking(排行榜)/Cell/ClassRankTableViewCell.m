//
//  ClassRankTableViewCell.m
//  干部在线
//
//  Created by lixianjun on 15-1-6.
//  Copyright (c) 2015年 中青年. All rights reserved.
//

#import "ClassRankTableViewCell.h"

@implementation ClassRankTableViewCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createUI];
    }
    return self;
}
-(void)createUI
{
    //排行编号
    //self.contentView.backgroundColor = [UIColor purpleColor];
    numberImageView =[ MyContol createImageViewWithFrame:CGRectMake(10, (90-30)/2,30, 30) ImageName:@"4"];
    numberImageView.layer.cornerRadius = 15;
    numberImageView.layer.masksToBounds = YES;
    [self.contentView addSubview:numberImageView];
    numberLabel   = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, 20, 20)];
    numberLabel.text = @"";
    numberLabel.adjustsFontSizeToFitWidth = YES;
    numberLabel.textAlignment = NSTextAlignmentCenter;
    numberLabel.numberOfLines = 1;
    numberLabel.textColor = [UIColor whiteColor];
    [numberImageView addSubview:numberLabel];
    //学员头像
    studentHeadImageView = [MyContol createImageViewWithFrame:CGRectMake(50,(90 - 70 )/ 2, 85, 70) ImageName:@"course_bg_g.png"];
    studentHeadImageView.layer.cornerRadius = 4;
    studentHeadImageView.layer.masksToBounds = YES;
    [self.contentView addSubview:studentHeadImageView];
    //课程标题
    studentNameLabel = [MyContol createLabelWithFrame:CGRectMake(150, 10, [UIScreen mainScreen].bounds.size.width  - 150 - 5, 35) Font:14.5 Text:@"2014年度第三期全国地市级团委"]
    ;
    studentNameLabel.lineBreakMode = NSLineBreakByWordWrapping;
    studentNameLabel.numberOfLines = 0;
    studentNameLabel.textColor = [UIColor colorWithRed:0.3 green:0.34 blue:0.3 alpha:1];
    studentNameLabel.font = [UIFont boldSystemFontOfSize:14.5];
    [self.contentView addSubview:studentNameLabel];
//    //学员单位
//    studentUnit = [MyContol createLabelWithFrame:CGRectMake(150, 40, 140, 30) Font:20 Text:@"____班子成员和县级"];
//    [self.contentView addSubview:studentUnit];
    //选课人数
    onlineNumberLbel = [MyContol createLabelWithFrame:CGRectMake(150, 80 -15 , 120, 15) Font:15 Text:@"已有27人选学"];
    onlineNumberLbel.textColor = [UIColor grayColor];
    onlineNumberLbel.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:onlineNumberLbel];
}
-(void)config:(CourceRankModel *)model row:(int)row
{
    //排行编号
    //图像
    //numberImageView.image = nil;
    if (row == 0) {
        numberImageView.image = [UIImage imageNamed:@"1"];
    }
    else if (row == 1)
    {
        numberImageView.image = [UIImage imageNamed:@"2"];
    }
    else if(row == 2)
    {
        numberImageView.image = [UIImage imageNamed:@"3"];
    }
    else
    {
        numberImageView.image = [UIImage imageNamed:@"4"];
       
    }
    if (row >=3) {
         numberLabel.text = [NSString stringWithFormat:@"%d",1+row++];
    }
    else
    {
        numberLabel.text = @"";
    }
    [studentHeadImageView sd_setImageWithURL:[NSURL URLWithString:model.courseImgUrl] placeholderImage:[UIImage imageNamed:@"course_bg_g.png"]];
    //课程标题
    if (model.name == nil) {
        studentNameLabel.text =@"2014年度第三期全国地市级团委";
    }
    else
    {studentNameLabel.text = model.name;

    }
    //    studentUnit.text = @"___大力推进依法治国";
    //选课人数
    onlineNumberLbel.text = [NSString stringWithFormat:@"已有%d人选学",model.studyNum];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
