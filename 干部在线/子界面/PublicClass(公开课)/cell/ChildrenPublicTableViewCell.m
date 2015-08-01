


//
//  ChildrenPublicTableViewCell.m
//  干部在线
//
//  Created by lixianjun on 15-2-2.
//  Copyright (c) 2015年 中青年. All rights reserved.
//

#import "ChildrenPublicTableViewCell.h"

@implementation ChildrenPublicTableViewCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createUI];
        //self.backgroundColor = [UIColor redColor];
    }
    return self;
}
-(void)createUI
{
    //左边图片
    leftImageView  = [MyContol createImageViewWithFrame:CGRectMake(10, 10, 110, 80) ImageName:@"course_bg.png"];
    leftImageView.layer.masksToBounds = YES;
    leftImageView.layer.cornerRadius = 8;
    [self.contentView addSubview:leftImageView];
    //播放
    playIMageView = [MyContol createImageViewWithFrame:CGRectMake(0, 0, 110, 80) ImageName:@"big_play.png"];
    [leftImageView addSubview:playIMageView];
    //课程
    classLabel = [MyContol createLabelWithFrame:CGRectMake(140, 0, 150, 30) Font:15 Text:@"名称：团中央学习报告团的业务、团干部能力"];
    [self.contentView addSubview:classLabel];
    //讲师
    lecturerLabel = [MyContol createLabelWithFrame:CGRectMake(140, 35, 100, 20) Font:15 Text:@"讲师：小牛"];
    [self.contentView addSubview:lecturerLabel];
    //课shi
    classTimeLabel = [MyContol createLabelWithFrame:CGRectMake(230, 35, 90, 20) Font:15 Text:@"课时：130小时"];
    classTimeLabel.adjustsFontSizeToFitWidth = YES;
    //classTimeLabel.backgroundColor =[UIColor redColor];
    [self.contentView addSubview:classTimeLabel];
    //积分
    markLabel = [MyContol createLabelWithFrame:CGRectMake(140, 65, 100, 20) Font:15 Text:@"积分：25"];
    [self.contentView addSubview:markLabel];
    //学习人数
    leanNumberLabel = [MyContol createLabelWithFrame:CGRectMake(210, 65, 120, 20) Font:15 Text:@"已有10000选学"];
    [self.contentView addSubview:leanNumberLabel];
    
    
}
-(void)config:(ChildrenPublicModel*)model
{
    //左边图片
    [leftImageView sd_setImageWithURL:[NSURL URLWithString:model.courseImg] placeholderImage:[UIImage imageNamed:@"course_bg.png"]];
    //课程
    classLabel.text = model.title;
    //讲师
    lecturerLabel.text =[NSString stringWithFormat:@"讲师：%@",model.teacherName
                         ];
    //课shi
    classTimeLabel.text= [NSString stringWithFormat:@"课时：%d小时",model.period];
    //积分
    markLabel.text = [NSString stringWithFormat:@"积分：%d",model.period*10];
    //学习人数
    leanNumberLabel.text= [NSString stringWithFormat:@"学习人数：%d",model
                           .studyNum];
    
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
