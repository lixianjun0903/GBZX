

//
//  searchTableViewCell.m
//  干部在线
//
//  Created by lixianjun on 15-2-3.
//  Copyright (c) 2015年 中青年. All rights reserved.
//

#import "searchTableViewCell.h"
#import "Adaptation.h"
@implementation searchTableViewCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self makeUI];
    }
    return self;
}
-(void)makeUI
{  //宽度
    static CGFloat width;
    //图标
    static CGFloat imageViewWidth;
    //名称
    static CGFloat titleLabelX;
    static CGFloat titleLabelWidth;
    //讲师
    static CGFloat lectureLabelX;
    static CGFloat lectureLabelWidth;
    //课时
    static CGFloat coureTimeLabelX;
    static CGFloat coureTimeLabelWidth;
    //积分
    static CGFloat ingeralLabelX;
    static CGFloat ingeralLabelWidth;
    //已学人数
    static CGFloat studyNumberLabelX;
    static CGFloat studyNumberLabelWith;
    //选课
    static CGFloat electButtonX;
    static CGFloat electButtonWith;
    
    if (is3_5Inch||is4Inch) {
        width = 320;
        //图标
        imageViewWidth = 80;
        //名称
        titleLabelX = 100;
        titleLabelWidth = 220;
        //讲师
        lectureLabelX =100;
        lectureLabelWidth = 80;
        //课时
        coureTimeLabelX = 185;
        coureTimeLabelWidth = 70;
        //积分
        ingeralLabelX =100;
        ingeralLabelWidth = 54;
        //已学人数
        studyNumberLabelX =  160;
        studyNumberLabelWith = 95;
        //选课
        electButtonX  = 260;
        electButtonWith = 55;
        
    }else if (is4_7Inch)
    {
        
        width = 375;
        //图标
        imageViewWidth= 96;
        //名称
        titleLabelX = 116;
        titleLabelWidth =  244;
        //讲师
        lectureLabelX = 116;
        lectureLabelWidth = 96;
        //课时
        coureTimeLabelX = 220;
        coureTimeLabelWidth = 80;
        //积分
        ingeralLabelX = 116;
        ingeralLabelWidth = 64;
        //已学人数
        studyNumberLabelX = 185;
        studyNumberLabelWith = 115;
        //选课
        electButtonX = 310;
        electButtonWith =60;
        
    }else if (is5_5Inch)
    {
        
        width = 414;
        //图标
        imageViewWidth = 110;
        //名称
        titleLabelX = 130;
        titleLabelWidth = 284;
        //讲师
        lectureLabelX = 130;
        lectureLabelWidth = 100;
        //课时
        coureTimeLabelX = 235;
        coureTimeLabelWidth = 85;
        //积分
        ingeralLabelX = 130;
        ingeralLabelWidth = 69;
        //已学人数
        studyNumberLabelX = 200;
        studyNumberLabelWith = 120;
        //选课
        electButtonX = 330;
        electButtonWith = 76;
        
    }
    //图标
    imageView  = [MyContol createImageViewWithFrame:CGRectMake(10, 10, imageViewWidth, 70) ImageName:@"class_mianshouban_image.png"];
    [self.contentView addSubview:imageView];
    //选课
    isSelectView = [MyContol createImageViewWithFrame:CGRectMake(0, 0, imageViewWidth, 70) ImageName:@"big_play"];
    isSelectView.hidden = YES;
    [imageView addSubview:isSelectView];
    //    //退课
    //    retreatView =[MyContol createImageViewWithFrame:CGRectMake(0, 0, imageViewWidth, 70) ImageName:@""];
    //    retreatView.hidden = YES;
    //    [imageView addSubview:retreatView];
    
    //名称
    titleLabel =[MyContol createLabelWithFrame:CGRectMake(titleLabelX, 0, titleLabelWidth,36) Font:15 Text:@"名称：我对未成年的司法保护"];
    titleLabel.textColor = [UIColor grayColor];
    [self.contentView addSubview:titleLabel];
    //讲师
    lectureLabel = [MyContol createLabelWithFrame:CGRectMake(lectureLabelX, 40, lectureLabelWidth, 20) Font:15 Text:@"讲师:丁丁当"];
    //lectureLabel.backgroundColor =  [UIColor blueColor];
    lectureLabel.textColor =[UIColor grayColor];
    [self.contentView addSubview:lectureLabel];
    //课时
    coureTimeLabel =[MyContol createLabelWithFrame:CGRectMake(coureTimeLabelX, 33, coureTimeLabelWidth, 40) Font:15 Text:@"课时：2.5"];
    coureTimeLabel.textColor = [UIColor grayColor];
    //coureTimeLabel.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:coureTimeLabel];
    //积分
    ingeralLabel = [MyContol createLabelWithFrame:CGRectMake(ingeralLabelX, 65, ingeralLabelWidth, 20) Font:15 Text:@"积分:25"];
    ingeralLabel.textColor =[UIColor grayColor];
    //ingeralLabel.backgroundColor = [UIColor grayColor];
    [self.contentView addSubview:ingeralLabel];
    //已学人数
    studyNumberLabel = [MyContol createLabelWithFrame:CGRectMake(studyNumberLabelX, 65, studyNumberLabelWith, 20) Font:15 Text:@"已有12人选学"];
    //studyNumberLabel.backgroundColor =[UIColor redColor];
    studyNumberLabel.textColor =[UIColor grayColor];
    [self.contentView addSubview:studyNumberLabel];
    //选课
    //    electButton = [MyContol createButtonWithFrame:CGRectMake(electButtonX, 50, electButtonWith, 30) ImageName:@"选课退课.png" Target:self Action:@selector(electButton) Title:nil];
    //    electButton.layer.cornerRadius = 5;
    //    electButton.layer.masksToBounds =YES;
    //    electButton.backgroundColor =[UIColor redColor];
    //    [self.contentView addSubview:electButton];
    
    //    //图标
    //    imageView  = [MyContol createImageViewWithFrame:CGRectMake(10, 10, 90, 70) ImageName:@"class_mianshouban_image.png"];
    //    [self.contentView addSubview:imageView];
    //
    //    //名称
    //    titleLabel =[MyContol createLabelWithFrame:CGRectMake(110, 5, [UIScreen mainScreen].bounds.size.width - 120,20) Font:15 Text:@"名称：我对未成年的司法保护"];
    //    [self.contentView addSubview:titleLabel];
    //    //讲师
    //    lectureLabel = [MyContol createLabelWithFrame:CGRectMake(110, 33, 85, 20) Font:15 Text:@"讲师:丁丁当"];
    //    //lectureLabel.backgroundColor =  [UIColor blueColor];
    //    [self.contentView addSubview:lectureLabel];
    //    //课时
    //    coureTimeLabel =[MyContol createLabelWithFrame:CGRectMake(200, 33, [UIScreen mainScreen].bounds.size.width-200-50, 20) Font:15 Text:@"课时：2.5"];
    //   //coureTimeLabel.backgroundColor = [UIColor redColor];
    //    [self.contentView addSubview:coureTimeLabel];
    //    //积分
    //    ingeralLabel = [MyContol createLabelWithFrame:CGRectMake(110, 61, 55, 20) Font:15 Text:@"积分:25"];
    //    //ingeralLabel.backgroundColor = [UIColor grayColor];
    //    [self.contentView addSubview:ingeralLabel];
    //    //已学人数
    //    studyNumberLabel = [MyContol createLabelWithFrame:CGRectMake(170, 63, 90, 20) Font:14 Text:@"已有12人选学"];
    //    //studyNumberLabel.backgroundColor =[UIColor redColor];
    //    [self.contentView addSubview:studyNumberLabel];
    //    //选课
    //    electButton = [MyContol createButtonWithFrame:CGRectMake(265, 50, 55, 30) ImageName:@"选课退课.png" Target:self Action:@selector(electButton) Title:nil];
    //    electButton.layer.cornerRadius = 5;
    //    electButton.layer.masksToBounds =YES;
    //    electButton.backgroundColor =[UIColor redColor];
    //    [self.contentView addSubview:electButton];
    
}

-(void)config:(ClassEveryModel*)model
{
    //图标
    [imageView sd_setImageWithURL:[NSURL URLWithString:model.courseImg]placeholderImage:[UIImage imageNamed:@"class_mianshouban_image.png"]];
    if ([[NSString stringWithFormat:@"%@",model.isSelect]isEqualToString:@"1"]) {
        isSelectView.hidden = NO;
    }
    else
    {
        isSelectView.hidden = YES;
    }
    //名称
    titleLabel.text = [NSString stringWithFormat:@"名称 : %@",model.title];
    NSMutableAttributedString *titleLabelStr = [[NSMutableAttributedString alloc] initWithString:titleLabel.text];
    [titleLabelStr addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0,3)];
    [titleLabelStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Arial-BoldItalicMT" size:16.0] range:NSMakeRange(0, 3)];
    titleLabel.attributedText = titleLabelStr;
    //讲师
    if (model.teacherName == nil) {
        lectureLabel.text = [NSString stringWithFormat:@"讲师 : 暂无"];
    }else
    {
        lectureLabel.text = [NSString stringWithFormat:@"讲师 : %@",model.teacherName];
    }
    NSMutableAttributedString *lectureLabelStr = [[NSMutableAttributedString alloc] initWithString:lectureLabel.text];
    [lectureLabelStr addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0,3)];
    [lectureLabelStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Arial-BoldItalicMT" size:16.0] range:NSMakeRange(0, 3)];
    lectureLabel.attributedText = lectureLabelStr;
    //积分
    ingeralLabel.text = [NSString stringWithFormat:@"积分 : %d",model.period*10];
    NSMutableAttributedString *ingeralLabelStr = [[NSMutableAttributedString alloc] initWithString:ingeralLabel.text];
    [ingeralLabelStr addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0,3)];
    [ingeralLabelStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Arial-BoldItalicMT" size:16.0] range:NSMakeRange(0, 3)];
    ingeralLabel.attributedText = ingeralLabelStr;
    //课时
    coureTimeLabel.text =[NSString  stringWithFormat:@"课时 : %d", model.period];
    NSMutableAttributedString *coureTimeLabelStr = [[NSMutableAttributedString alloc] initWithString:coureTimeLabel.text];
    [coureTimeLabelStr addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0,3)];
    [coureTimeLabelStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Arial-BoldItalicMT" size:16.0] range:NSMakeRange(0, 3)];
    coureTimeLabel.attributedText = coureTimeLabelStr;
    //已学人数
    studyNumberLabel.text = [NSString stringWithFormat:@"学习人数 : %d",model.studyNum];
    NSMutableAttributedString *studyNumberLabelStr = [[NSMutableAttributedString alloc] initWithString:studyNumberLabel.text];
    [studyNumberLabelStr addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0,5)];
    [studyNumberLabelStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Arial-BoldItalicMT" size:16.0] range:NSMakeRange(0, 5)];
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
