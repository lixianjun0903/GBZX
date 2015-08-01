

//
//  spcialTableViewCell.m
//  干部在线
//
//  Created by lixianjun on 15-1-4.
//  Copyright (c) 2015年 中青年. All rights reserved.
//

#import "spcialTableViewCell.h"

@implementation spcialTableViewCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createUI];
    }
    return self;
}
#pragma mark 创建UI
-(void)createUI
{
    //课程序号
    courceNumberLabel = [MyContol createLabelWithFrame:CGRectMake(15,50, 25, 25) Font:20 Text:@"1"];
    courceNumberLabel.textAlignment  = NSTextAlignmentCenter;
    //courceNumberLabel.backgroundColor =[UIColor redColor];
    [self.contentView addSubview:courceNumberLabel];
    //左边图片
    leftImageView  = [MyContol createImageViewWithFrame:CGRectMake(50, 22, 90, 83) ImageName:@"专题详情.jpg"];
    leftImageView.layer.cornerRadius = 6;
    leftImageView.layer.masksToBounds = YES;
    [self.contentView addSubview:leftImageView];
    //课程
    classLabel = [MyContol createLabelWithFrame:CGRectMake(150, 15, 150, 30) Font:17 Text:@"名称：团中央学习报告团的业务、团干部能力"];
    classLabel.font =[UIFont boldSystemFontOfSize:17];
    [self.contentView addSubview:classLabel];
    //讲师
    lecturerLabel = [MyContol createLabelWithFrame:CGRectMake(150, 50, 50, 20) Font:15 Text:@"讲师：老师"];
    [self.contentView addSubview:lecturerLabel];
    //课shi
    classTimeLabel = [MyContol createLabelWithFrame:CGRectMake(250, 50, 100, 20) Font:15 Text:@"课时：130小时"];
    [self.contentView addSubview:classTimeLabel];
    //积分
    markLabel = [MyContol createLabelWithFrame:CGRectMake(150, 75, 75, 20) Font:15 Text:@"积分：25"];
    [self.contentView addSubview:markLabel];
    //学习人数
    leanNumberLabel = [MyContol createLabelWithFrame:CGRectMake(250, 75, 100, 20) Font:15 Text:@"已有10000选学"];
    [self.contentView addSubview:leanNumberLabel];
    //显示星星
   
    
    
}
-(void)config:(specialTabelModel*)model row:(int)row;
{//读取图片
    if (row>= 0) {
        courceNumberLabel.text =[NSString stringWithFormat:@"%d", row++];
    }
    else
    {
        
    }
    // 左边图片
    [leftImageView sd_setImageWithURL:[NSURL URLWithString:model.courseImg]placeholderImage:[UIImage imageNamed:@"专题详情.jpg"]];
    //课程
    classLabel.text = model.title;
    //讲师
    lecturerLabel.text = [NSString stringWithFormat:@"讲师：%@",model.teacherName];
    //课时
    classTimeLabel.text = [NSString stringWithFormat:@"课时：%d",model.period];
    //积分
    markLabel.text = [NSString stringWithFormat:@"积分：%d",model.period*10];
    //学习人数
    leanNumberLabel.text = [NSString stringWithFormat:@"已有%d多少人选学",model.studyNum];
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
