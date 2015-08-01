
//
//  HotTableViewCell.m
//  干部在线
//
//  Created by lixianjun on 15-1-19.
//  Copyright (c) 2015年 中青年. All rights reserved.
//

#import "HotTableViewCell.h"

@implementation HotTableViewCell
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
    //图标
    imageView  = [MyContol createImageViewWithFrame:CGRectMake(10, 15, 100, 70) ImageName:@"侧滑最热.jpg"];
    imageView.layer.cornerRadius  = 8;
    imageView.layer.masksToBounds = YES;
    [self.contentView addSubview:imageView];
    
    //名称
    titleLabel =[MyContol createLabelWithFrame:CGRectMake(130, 5, [UIScreen mainScreen].bounds.size.width - 130, 40) Font:15 Text:@"名称：我对未成年的司法保护"];
    titleLabel.font =[UIFont boldSystemFontOfSize:15];
     titleLabel.adjustsFontSizeToFitWidth = YES;
    //titleLabel.backgroundColor =  [UIColor greenColor];
    [self.contentView addSubview:titleLabel];
    //讲师
    lectureLabel = [MyContol createLabelWithFrame:CGRectMake(130, 40, 90, 30) Font:15 Text:@"讲师：丁丁当"];
    //lectureLabel.backgroundColor =  [UIColor blueColor];
    [self.contentView addSubview:lectureLabel];
    //课时
    coureTimeLabel =[MyContol createLabelWithFrame:CGRectMake(230, 40, 70, 30) Font:15 Text:@"课时：2.5"];
    //coureTimeLabel.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:coureTimeLabel];
    //积分
    ingeralLabel = [MyContol createLabelWithFrame:CGRectMake(130, 70, 75, 30) Font:15 Text:@"积分：25"];
    //ingeralLabel.backgroundColor = [UIColor grayColor];
    [self.contentView addSubview:ingeralLabel];
    //已学人数
    studyNumberLabel = [MyContol createLabelWithFrame:CGRectMake(205, 70, 190, 30) Font:15 Text:@"已有12人选学"];
    [self.contentView addSubview:studyNumberLabel];
    
}
-(void)config:(Hotmodel*)model
{
    //图标
    [imageView sd_setImageWithURL:[NSURL URLWithString:model.courseImg]placeholderImage:[UIImage imageNamed:@"侧滑最热.jpg"]];
    //名称
    titleLabel.text = model.title;
    //讲师
    if (model.teacherName==nil) {
        lectureLabel.text= @"讲师:暂无 ";
    }
    else
    {
    lectureLabel.text = [NSString stringWithFormat:@"讲师:%@ ",model.teacherName];
    }
    
    NSMutableAttributedString *lectureLabelStr = [[NSMutableAttributedString alloc] initWithString:lectureLabel.text];
    [lectureLabelStr addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0,2)];
    [lectureLabelStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"HelveticaNeue-Bold" size:16.0] range:NSMakeRange(0, 2)];
    lectureLabel.attributedText = lectureLabelStr;
    //课时
    coureTimeLabel.text =[NSString  stringWithFormat:@"课时:%d", model.period];
    NSMutableAttributedString *coureTimeLabelStr = [[NSMutableAttributedString alloc] initWithString:coureTimeLabel.text];
    [coureTimeLabelStr addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0,2)];
    [coureTimeLabelStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"HelveticaNeue-Bold" size:16.0] range:NSMakeRange(0, 2)];
    coureTimeLabel.attributedText = coureTimeLabelStr;
    //积分
    ingeralLabel.text = [NSString stringWithFormat:@"积分:%d",model.period * 10 ];
    NSMutableAttributedString *ingeralLabelStr = [[NSMutableAttributedString alloc] initWithString:ingeralLabel.text];
    [ingeralLabelStr addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0,2)];
    [ingeralLabelStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"HelveticaNeue-Bold" size:16.0] range:NSMakeRange(0, 2)];
    ingeralLabel.attributedText = ingeralLabelStr;
    //已学人数
    studyNumberLabel.text = [NSString stringWithFormat:@"已有%d人选学",model.studyNum];
    NSMutableAttributedString *studyNumberLabelStr = [[NSMutableAttributedString alloc] initWithString:studyNumberLabel.text];
    [studyNumberLabelStr addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0,6)];
    [studyNumberLabelStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"HelveticaNeue-Bold" size:16.0] range:NSMakeRange(0, 6)];
    studyNumberLabel.attributedText = studyNumberLabelStr;
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
