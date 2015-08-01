//
//  evreyClassNumberTableViewCell.m
//  干部在线
//
//  Created by lixianjun on 15-1-12.
//  Copyright (c) 2015年 中青年. All rights reserved.
//

#import "evreyClassNumberTableViewCell.h"
#import "Adaptation.h"
#import "startView.h"
@implementation evreyClassNumberTableViewCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self makeUI];
    }
    return self;
}
/*
-(void)makeUI1
{
    
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
    markLabel = [MyContol createLabelWithFrame:CGRectMake(ingeralLabelX, 65, ingeralLabelWidth, 20) Font:14 Text:@"积分：25"];
    markLabel.adjustsFontSizeToFitWidth = YES;
    markLabel.textColor =[UIColor grayColor];
    //    markLabel.backgroundColor = [UIColor yellowColor];
    [self.contentView addSubview:markLabel];
    //学习人数
//    leanNumberLabel = [MyContol createLabelWithFrame:CGRectMake([studyNumberLabelX, 65, studyNumberLabelWith, 20) Font:14 Text:@"已有10000选学"];
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
    //    NSMutableAttributedString *commentLabelStr = [[NSMutableAttributedString alloc] initWithString:commentLabel.text];
    //    [commentLabelStr addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0,2)];
    //    [commentLabelStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:nil size:17.0] range:NSMakeRange(0, 2)];
    //    commentLabel.attributedText = commentLabelStr;
    [self.contentView addSubview:commentLabel];
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
 */

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
    static CGFloat startViewsX;
    static CGFloat imageViewX;
    
    if (is3_5Inch||is4Inch) {
        width = 320;
        //图标
        imageViewWidth = 90;
        imageViewX = 10;

        //名称
      titleLabelX = 116;
        titleLabelWidth = 200;
        //讲师
       lectureLabelX =116;
        lectureLabelWidth = 80;
        //课时
         coureTimeLabelX = 180;
       coureTimeLabelWidth = 100;
        //积分
        ingeralLabelX =116;
         ingeralLabelWidth = 64;
        //已学人数
         studyNumberLabelX =  180;
        studyNumberLabelWith = 95;
        //选课
        electButtonX  = 260;
        electButtonWith = 55;
        startViewsX = 145;
        
    }else if (is4_7Inch)
    {
    
        width = 375;
        //图标
         imageViewWidth= 100;
        imageViewX = 15;

        //名称
         titleLabelX = 130;
        titleLabelWidth =  235;
        //讲师
         lectureLabelX = 130;
         lectureLabelWidth = 96;
        //课时
        coureTimeLabelX = 215;
        coureTimeLabelWidth = 116;
        //积分
         ingeralLabelX = 130;
       ingeralLabelWidth = 70;
        //已学人数
         studyNumberLabelX = 215;
         studyNumberLabelWith = 115;
        //选课
        electButtonX = 310;
       electButtonWith =60;
        startViewsX = 170;
    }else if (is5_5Inch)
    {
    
        width = 414;
        //图标
        imageViewWidth = 110;
        imageViewX = 18;

        //名称
         titleLabelX = 144;
         titleLabelWidth = 264;
        //讲师
       lectureLabelX = 144;
         lectureLabelWidth = 80;
        //课时
         coureTimeLabelX = 230;
       coureTimeLabelWidth =100;
        //积分
         ingeralLabelX = 144;
        ingeralLabelWidth = 70;
        //已学人数
         studyNumberLabelX = 230;
        studyNumberLabelWith = 120;
        //选课
         electButtonX = 330;
         electButtonWith = 76;
        startViewsX = 185;
           }
    //图标
    imageView  = [MyContol createImageViewWithFrame:CGRectMake(imageViewX, 15, imageViewWidth, 85) ImageName:@"首图标.jpg"];
    imageView.layer.cornerRadius =3;
    imageView.layer.masksToBounds = YES;
    [self.contentView addSubview:imageView];
    //选课
    isSelectView = [MyContol createImageViewWithFrame:CGRectMake(0, 0, 100, 85) ImageName:@"big_play"];
    isSelectView.hidden = YES;
    [imageView addSubview:isSelectView];
    //退课
    retreatView =[MyContol createImageViewWithFrame:CGRectMake(0, 0, 90, 85) ImageName:@""];
    retreatView.hidden = YES;
    [imageView addSubview:retreatView];
    
    //名称
    titleLabel =[MyContol createLabelWithFrame:CGRectMake(titleLabelX, 10, titleLabelWidth,35) Font:14 Text:@"我对未成年的司法保护"];
    titleLabel.font =[UIFont systemFontOfSize:14];
    titleLabel.textColor = [UIColor colorWithRed:0.3 green:0.34 blue:0.3 alpha:1];
//    titleLabel.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:titleLabel];
    //讲师
    lectureLabel = [MyContol createLabelWithFrame:CGRectMake(coureTimeLabelX, 45, lectureLabelWidth, 20) Font:13.4 Text:@"讲师:丁丁当"];
//    lectureLabel.backgroundColor =  [UIColor blueColor];
    lectureLabel.textColor =[UIColor grayColor];
    [self.contentView addSubview:lectureLabel];
    //课时
    coureTimeLabel =[MyContol createLabelWithFrame:CGRectMake(lectureLabelX, 45, lectureLabelWidth, 20) Font:13.4 Text:@"课时：2.5"];
    coureTimeLabel.textColor = [UIColor grayColor];
//    coureTimeLabel.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:coureTimeLabel];
    //积分
    ingeralLabel = [MyContol createLabelWithFrame:CGRectMake(ingeralLabelX, 65, ingeralLabelWidth, 20) Font:13.4 Text:@"积分:25"];
    ingeralLabel.textColor =[UIColor grayColor];
    //ingeralLabel.backgroundColor = [UIColor grayColor];
    [self.contentView addSubview:ingeralLabel];
    //已学人数
    studyNumberLabel = [MyContol createLabelWithFrame:CGRectMake(studyNumberLabelX, 65, studyNumberLabelWith, 20) Font:13.4 Text:@"已有12人选学"];
    //studyNumberLabel.backgroundColor =[UIColor redColor];
    studyNumberLabel.textColor =[UIColor grayColor];
    [self.contentView addSubview:studyNumberLabel];
    //评价
    //显示星星
    startView * startViews = [[startView alloc] initWithFrame:CGRectMake(startViewsX, 87, 65, 23)];
    //startViews.backgroundColor =[UIColor redColor];
    [self.contentView addSubview:startViews];
    NSString * str = @"4";
    [startViews conFigNumber:[str floatValue]];
    commentLabel =  [MyContol createLabelWithFrame:CGRectMake(ingeralLabelX, 86, 50, 20) Font:13.4 Text:@"评价 ："];
    commentLabel.textColor = [UIColor grayColor];
    [self.contentView addSubview:commentLabel];

    
}


-(void)config:(ClassEveryModel*)model
{
    //图标
    [imageView sd_setImageWithURL:[NSURL URLWithString:model.courseImg]placeholderImage:[UIImage imageNamed:@"首图标.jpg"]];
    if ([[NSString stringWithFormat:@"%@",model.isSelect]isEqualToString:@"1"]) {
        isSelectView.hidden = NO;
    }
    else
    {
        isSelectView.hidden = YES;
    }
    //名称
    titleLabel.text = [NSString stringWithFormat:@"%@",model.title];
    
     //讲师
    if (model.teacherName == nil) {
        lectureLabel.text = [NSString stringWithFormat:@"讲师 : 暂无"];
    }else
    {
    lectureLabel.text = [NSString stringWithFormat:@"讲师 : %@",model.teacherName];
    }
    
    //积分
    ingeralLabel.text = [NSString stringWithFormat:@"积分 : %d",model.period*10];
    
    //课时
    coureTimeLabel.text =[NSString  stringWithFormat:@"课时 : %d", model.period];
    
    //已学人数
    studyNumberLabel.text = [NSString stringWithFormat:@"学习人数 : %d",model.studyNum];
   }
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
