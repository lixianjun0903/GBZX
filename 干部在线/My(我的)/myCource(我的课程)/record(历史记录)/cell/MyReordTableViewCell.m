//
//  MyReordTableViewCell.m
//  干部在线
//
//  Created by lixianjun on 15-2-2.
//  Copyright (c) 2015年 中青年. All rights reserved.
//

#import "MyReordTableViewCell.h"
@implementation MyReordTableViewCell

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
//    //左边图片
//    leftImageView  = [MyContol createImageViewWithFrame:CGRectMake(10, 10, 110, 80) ImageName:@"kecheng.png"];
//    [self.contentView addSubview:leftImageView];
//    //课程
//    classLabel = [MyContol createLabelWithFrame:CGRectMake(140, 0, [UIScreen mainScreen].bounds.size.width - 150, 40) Font:15 Text:@"名称：团中央学习报告团的业务、团干部能力"];
//    classLabel.numberOfLines = 0;
//    classLabel.font =[UIFont boldSystemFontOfSize:15];
//    [self.contentView addSubview:classLabel];
//    //讲师
//    lecturerLabel = [MyContol createLabelWithFrame:CGRectMake(140, 37, 100, 20) Font:15 Text:@"讲师：李老师"];
//    [self.contentView addSubview:lecturerLabel];
//    //课shi
//    classTimeLabel = [MyContol createLabelWithFrame:CGRectMake(250, 37, 100, 20) Font:15 Text:@"课时：130小时"];
//    [self.contentView addSubview:classTimeLabel];
//    //积分
//    markLabel = [MyContol createLabelWithFrame:CGRectMake(140, 60, 60, 20) Font:15 Text:@"积分：25"];
//   // markLabel.backgroundColor =[UIColor  yellowColor];
//    [self.contentView addSubview:markLabel];
//    //学习人数
//    leanNumberLabel = [MyContol createLabelWithFrame:CGRectMake(210, 60, [UIScreen mainScreen].bounds.size.width - 220, 20) Font:15 Text:@"已有10000选学"];
//    //leanNumberLabel.backgroundColor =[UIColor redColor];
//    [self.contentView addSubview:leanNumberLabel];
//    //学习进度
//    learnProgressLabel = [MyContol createLabelWithFrame:CGRectMake(200, 80, 140, 20) Font:15 Text:@"已看到：04 24/30:12"];
//    //learnProgressLabel.backgroundColor = [UIColor redColor];
//    
//    [self.contentView addSubview:learnProgressLabel];
    //左边图片
    leftImageView  = [MyContol createImageViewWithFrame:CGRectMake(15, 15, 100, 85) ImageName:@"首图标.png"];
    leftImageView.layer.cornerRadius = 4;
    leftImageView.layer.masksToBounds = YES;
    [self.contentView addSubview:leftImageView];
    //课程
    classLabel = [MyContol createLabelWithFrame:CGRectMake(130, 15, [UIScreen mainScreen].bounds.size.width-140, 35) Font:14.5 Text:@"名称：团中央学习报告团的业务、团干部能力"];
    classLabel.textColor = [UIColor colorWithRed:0.3 green:0.34 blue:0.3 alpha:1];
    classLabel.font = [UIFont boldSystemFontOfSize:14.5];
    classLabel.numberOfLines = 0;
    //    classLabel.backgroundColor =[UIColor redColor];
    classLabel.adjustsFontSizeToFitWidth = YES;
    [self.contentView addSubview:classLabel];
    //讲师
    lecturerLabel = [MyContol createLabelWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 100,49, 90, 20) Font:13.3 Text:@"讲师:李老师"];
    lecturerLabel.adjustsFontSizeToFitWidth  =  YES;
    lecturerLabel.textColor =[UIColor grayColor];
    [self.contentView addSubview:lecturerLabel];
    
    
    //课时
    classTimeLabel = [MyContol createLabelWithFrame:CGRectMake(130, 49, [UIScreen mainScreen].bounds.size.width - 130 - 86, 20) Font:13.3 Text:@"课时：130小时"];
    classTimeLabel.adjustsFontSizeToFitWidth = YES;
    
    classTimeLabel.textColor =[UIColor grayColor];
    //    classTimeLabel.backgroundColor =[UIColor yellowColor];
    [self.contentView addSubview:classTimeLabel];
    //积分
    markLabel = [MyContol createLabelWithFrame:CGRectMake(130, 68, [UIScreen mainScreen].bounds.size.width - 130 -125, 20) Font:13.3 Text:@"积分：25"];
    markLabel.adjustsFontSizeToFitWidth = YES;
    markLabel.textColor =[UIColor grayColor];
    //    markLabel.backgroundColor = [UIColor yellowColor];
    [self.contentView addSubview:markLabel];
    //学习人数
    leanNumberLabel = [MyContol createLabelWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 100, 68, 90, 20) Font:13.3 Text:@"已有10000选学"];
    leanNumberLabel.adjustsFontSizeToFitWidth = YES;
    leanNumberLabel.textColor =[UIColor grayColor];
    //     leanNumberLabel.backgroundColor =[UIColor redColor];
    [self.contentView addSubview:leanNumberLabel];
    //    //显示星星
    //    startView * startViews = [[startView alloc] initWithFrame:CGRectMake(170, 87, 65, 23)];
    //    //startViews.backgroundColor =[UIColor redColor];
    //    [self.contentView addSubview:startViews];
    //    NSString * str = @"4";
    //    [startViews conFigNumber:[str floatValue]];
    //    commentLabel =  [MyContol createLabelWithFrame:CGRectMake(130, 86, 50, 20) Font:14 Text:@"评价 ："];
    //    commentLabel.textColor = [UIColor grayColor];
    //    [self.contentView addSubview:commentLabel];
    //学习进度
    learnProgressLabel = [MyContol createLabelWithFrame:CGRectMake(130, 88, 60, 20) Font:15 Text:@"学习进度:"];
    learnProgressLabel.font = [UIFont systemFontOfSize:13.3];
    learnProgressLabel.textColor = [UIColor grayColor];
    //learnProgressLabel.backgroundColor = [UIColor redColor];
    
    [self.contentView addSubview:learnProgressLabel];
    //学习进度底部条
    bgLearnPressImageVeiw = [[UIImageView alloc] initWithFrame:CGRectMake(190, 95, 80, 6)];
    bgLearnPressImageVeiw.image = [UIImage imageNamed:@"bar_up.png"];
    [self.contentView addSubview:bgLearnPressImageVeiw];
    //学习进度
    LearnPressImageVeiw = [[UIImageView alloc] initWithFrame:CGRectMake(190, 95, 80, 6)];
    LearnPressImageVeiw.contentMode = UIViewContentModeRedraw;
    LearnPressImageVeiw.clipsToBounds  = YES;
    LearnPressImageVeiw.image =[UIImage imageNamed:@"bar_dn.png"];
    [self.contentView addSubview:LearnPressImageVeiw];

}
-(void)myClassCofig:(MyClassModel*)model
{
    //左边图片
    [leftImageView sd_setImageWithURL:[NSURL URLWithString:model.courseImg] placeholderImage:[UIImage imageNamed:@"kecheng.png"]];
    //课程
    classLabel.text = model.title;
    //讲师
    lecturerLabel.text = [NSString stringWithFormat:@"讲师:%@",model.teacherName];
    
    //课shi
    classTimeLabel.text = [NSString stringWithFormat:@"课时:%@",model.period];
    //积分
    markLabel.text = [NSString stringWithFormat:@"积分:%d",[model.period intValue]*10];
    
    //学习人数
    leanNumberLabel.text = [NSString stringWithFormat:@"已有%d人学习",[model.studyNum intValue]*10];
    
//    //学习进度
//    learnProgressLabel.text = [NSString stringWithFormat:@"学习进度:%@",model.learnedHour];
    
    
    
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
