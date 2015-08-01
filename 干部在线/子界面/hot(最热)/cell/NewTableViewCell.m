




//
//  NewTableViewCell.m
//  干部在线
//
//  Created by lixianjun on 15-1-19.
//  Copyright (c) 2015年 中青年. All rights reserved.
//

#import "NewTableViewCell.h"

@implementation NewTableViewCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self makeUI];
    }
    return self;
}
-(void)makeUI
{
//    //图标
//    imageView  = [MyContol createImageViewWithFrame:CGRectMake(10, 15, 100, 70) ImageName:@"侧滑最新.jpg"];
//    imageView.layer.cornerRadius = 6;
//    imageView.layer.masksToBounds = YES;
//    [self.contentView addSubview:imageView];
//    
//    //名称
//    titleLabel =[MyContol createLabelWithFrame:CGRectMake(120, 10, [UIScreen mainScreen].bounds.size.width - 130, 40) Font:14 Text:@"名称：我对未成年的司法保护"];
//    //titleLabel.backgroundColor =[UIColor redColor];
//    
//    titleLabel.numberOfLines = 0;
//    titleLabel.textColor =[UIColor colorWithRed:0.3 green:0.3 blue:0.3 alpha:1];
//    titleLabel.font =[UIFont boldSystemFontOfSize:14];
//    titleLabel.adjustsFontSizeToFitWidth = YES;
//    //titleLabel.backgroundColor =  [UIColor greenColor];
//    [self.contentView addSubview:titleLabel];
//    //讲师
//    lectureLabel = [MyContol createLabelWithFrame:CGRectMake(220, 45, 100, 30) Font:14 Text:@"讲师：丁丁当"];
//    //lectureLabel.backgroundColor =  [UIColor blueColor];
//    [self.contentView addSubview:lectureLabel];
//    //课时
//    coureTimeLabel =[MyContol createLabelWithFrame:CGRectMake(120, 45, 190, 30) Font:14 Text:@"课时：2.5"];
//   // coureTimeLabel.backgroundColor = [UIColor redColor];
//    [self.contentView addSubview:coureTimeLabel];
//    //积分
//    ingeralLabel = [MyContol createLabelWithFrame:CGRectMake(120, 70, 75, 30) Font:14 Text:@"积分：25"];
//    //ingeralLabel.backgroundColor = [UIColor grayColor];
//    [self.contentView addSubview:ingeralLabel];
//    //已学人数
//    studyNumberLabel = [MyContol createLabelWithFrame:CGRectMake(220, 70, 190, 30) Font:14 Text:@"已有12人选学"];
//    [self.contentView addSubview:studyNumberLabel];
    
    //左边图片
    leftImageView  = [MyContol createImageViewWithFrame:CGRectMake(15, 15, 100, 85) ImageName:@"首图标.png"];
    leftImageView.layer.cornerRadius = 4;
    leftImageView.layer.masksToBounds = YES;
    [self.contentView addSubview:leftImageView];
    //课程
    classLabel = [MyContol createLabelWithFrame:CGRectMake(130, 10, [UIScreen mainScreen].bounds.size.width-140, 35) Font:14 Text:@"名称：团中央学习报告团的业务、团干部能力"];
    classLabel.textColor = [UIColor colorWithRed:0.3 green:0.34 blue:0.3 alpha:1];
    classLabel.font = [UIFont boldSystemFontOfSize:14];
    classLabel.numberOfLines = 0;
    //    classLabel.backgroundColor =[UIColor redColor];
    classLabel.adjustsFontSizeToFitWidth = YES;
    [self.contentView addSubview:classLabel];
    //讲师
    lecturerLabel = [MyContol createLabelWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 100,45, 90, 20) Font:14 Text:@"讲师:李老师"];
    lecturerLabel.adjustsFontSizeToFitWidth  =  YES;
    lecturerLabel.textColor =[UIColor grayColor];
    //    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:lecturerLabel.text];
    //    [str addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(1,2)];
    //    [str addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"HelveticaNeue-Bold" size:30.0] range:NSMakeRange(1, 2)];
    //    lecturerLabel.attributedText = str;
    //
    [self.contentView addSubview:lecturerLabel];
    
    
    //课时
    classTimeLabel = [MyContol createLabelWithFrame:CGRectMake(130, 45, [UIScreen mainScreen].bounds.size.width - 130 - 86, 20) Font:14 Text:@"课时：130小时"];
    classTimeLabel.adjustsFontSizeToFitWidth = YES;
    
    classTimeLabel.textColor =[UIColor grayColor];
    //    classTimeLabel.backgroundColor =[UIColor yellowColor];
    [self.contentView addSubview:classTimeLabel];
    //积分
    markLabel = [MyContol createLabelWithFrame:CGRectMake(130, 65, [UIScreen mainScreen].bounds.size.width - 130 -125, 20) Font:14 Text:@"积分：25"];
    markLabel.adjustsFontSizeToFitWidth = YES;
    markLabel.textColor =[UIColor grayColor];
    //    markLabel.backgroundColor = [UIColor yellowColor];
    [self.contentView addSubview:markLabel];
    //学习人数
    leanNumberLabel = [MyContol createLabelWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 100, 65, 90, 20) Font:14 Text:@"已有10000选学"];
    leanNumberLabel.adjustsFontSizeToFitWidth = YES;
    leanNumberLabel.textColor =[UIColor grayColor];
    //     leanNumberLabel.backgroundColor =[UIColor redColor];
    [self.contentView addSubview:leanNumberLabel];
    //显示星星
    startView * startViews = [[startView alloc] initWithFrame:CGRectMake(170, 87, 65, 23)];
    //startViews.backgroundColor =[UIColor redColor];
    [self.contentView addSubview:startViews];
    NSString * str = @"4";
    [startViews conFigNumber:[str floatValue]];
    commentLabel =  [MyContol createLabelWithFrame:CGRectMake(130, 86, 50, 20) Font:14 Text:@"评价 ："];
    commentLabel.textColor = [UIColor grayColor];
        [self.contentView addSubview:commentLabel];
    
}

-(void)config:(NewModel*)model
{
    //图标
    [leftImageView sd_setImageWithURL:[NSURL URLWithString:model.courseImg]placeholderImage:[UIImage imageNamed:@"侧滑最新.jpg"]];
    //名称
    classLabel.text = model.title;
    //讲师
    if (model.teacherName== nil) {
        lecturerLabel.text = @"讲师:暂无";
    }else
    {
    
    lecturerLabel.text = [NSString stringWithFormat:@"讲师:%@",model.teacherName];
    }
    //课时
    classTimeLabel.text =[NSString  stringWithFormat:@"课时：%@", model.period ];
    //积分
    markLabel.text = [NSString stringWithFormat:@"积分：%d",[model.period intValue]* 10];
    //已学人数
    leanNumberLabel.text = [NSString stringWithFormat:@"已有%@人选学",model.studyNum ];
    
    
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
