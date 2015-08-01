//
//  ChildrenRightLisenTableViewCell.m
//  干部在线
//
//  Created by lixianjun on 15-2-2.
//  Copyright (c) 2015年 中青年. All rights reserved.
//

#import "ChildrenRightLisenTableViewCell.h"

@implementation ChildrenRightLisenTableViewCell

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
    //左边图片
    leftImageView  = [MyContol createImageViewWithFrame:CGRectMake(10, 10, 120, 100) ImageName:@"kecheng.png"];
    
    [self.contentView addSubview:leftImageView];
    //课程
    classLabel = [MyContol createLabelWithFrame:CGRectMake(140, 10, [UIScreen mainScreen].bounds.size.width-150, 25) Font:15 Text:@"名称：团中央学习报告团的业务、团干部能力"];
    classLabel.adjustsFontSizeToFitWidth =YES;
    //classLabel.backgroundColor =[UIColor redColor];
    [self.contentView addSubview:classLabel];
    //讲师
    lecturerLabel = [MyContol createLabelWithFrame:CGRectMake(140, 45, 90, 20) Font:15 Text:@"讲师:李老师"];
    //    lecturerLabel.backgroundColor =[UIColor purpleColor];
    [self.contentView addSubview:lecturerLabel];
    //课shi
    classTimeLabel = [MyContol createLabelWithFrame:CGRectMake(230, 45, 80, 20) Font:15 Text:@"课时:130小时"];
    [self.contentView addSubview:classTimeLabel];
    //积分
    markLabel = [MyContol createLabelWithFrame:CGRectMake(140, 77, 70, 20) Font:15 Text:@"积分：25"];
    [self.contentView addSubview:markLabel];
    //学习人数
    leanNumberLabel = [MyContol createLabelWithFrame:CGRectMake(210, 75, 150, 20) Font:15 Text:@"已有10000选学"];
    [self.contentView addSubview:leanNumberLabel];
    
    
}
-(void)LisenConfig:(ChildrenRightLisenModel*)model
{//图片
    [leftImageView sd_setImageWithURL:[NSURL URLWithString:model.courseImg]placeholderImage:[UIImage imageNamed:@"course_bg.png"]];
    //课程名
    classLabel.text = [NSString stringWithFormat:@"课时:%@",model.title];
    //讲师
    if
        (model.teacherName ==nil)
    {
        leanNumberLabel.text = [NSString stringWithFormat:@"讲师:暂无"];
    }else{
        
        lecturerLabel.text = [NSString stringWithFormat:@"讲师:%@",model.teacherName];
    }
    //课时
    classTimeLabel.text = [NSString stringWithFormat:@"课时:%d小时",model.period];
    //积分
    markLabel.text = [NSString stringWithFormat:@"积分:%d",model.period*10];
    //学习人数
    leanNumberLabel.text = [NSString stringWithFormat:@"学习人数:%d",model.studyNum];
    
    }
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
