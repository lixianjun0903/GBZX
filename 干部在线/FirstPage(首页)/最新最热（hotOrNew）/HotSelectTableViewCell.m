//
//  HotSelectTableViewCell.m
//  干部在线
//
//  Created by lixianjun on 15-3-9.
//  Copyright (c) 2015年 中青年. All rights reserved.
//

#import "HotSelectTableViewCell.h"

@implementation HotSelectTableViewCell
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
//    imageView  = [MyContol createImageViewWithFrame:CGRectMake(10, 15, 100, 70) ImageName:@"侧滑最热.jpg"];
//    imageView.layer.cornerRadius  = 6;
//    imageView.layer.masksToBounds = YES;
//    [self.contentView addSubview:imageView];
//    
//    //名称
//    titleLabel =[MyContol createLabelWithFrame:CGRectMake(130, 5, [UIScreen mainScreen].bounds.size.width - 130, 40) Font:15 Text:@"名称：我对未成年的司法保护"];
//    titleLabel.font =[UIFont boldSystemFontOfSize:14];
//    titleLabel.adjustsFontSizeToFitWidth = YES;
//    titleLabel.textColor =[UIColor colorWithRed:0.3 green:0.3 blue:0.3 alpha:1];
//    //titleLabel.backgroundColor =  [UIColor greenColor];
//    [self.contentView addSubview:titleLabel];
//    //讲师
//    lectureLabel = [MyContol createLabelWithFrame:CGRectMake(230, 40, 70, 30) Font:14 Text:@"讲师：丁丁当"];
//    //lectureLabel.backgroundColor =  [UIColor blueColor];
//    [self.contentView addSubview:lectureLabel];
//    //课时
//    coureTimeLabel =[MyContol createLabelWithFrame:CGRectMake(130, 40, 90, 30) Font:14 Text:@"课时：2.5"];
//    //coureTimeLabel.backgroundColor = [UIColor redColor];
//    [self.contentView addSubview:coureTimeLabel];
//    //积分
//    ingeralLabel = [MyContol createLabelWithFrame:CGRectMake(130, 65, 75, 30) Font:14 Text:@"积分：25"];
//    //ingeralLabel.backgroundColor = [UIColor grayColor];
//    [self.contentView addSubview:ingeralLabel];
//    //已学人数
//    studyNumberLabel = [MyContol createLabelWithFrame:CGRectMake(230, 65, 190, 30) Font:14 Text:@"已有12人选学"];
//    [self.contentView addSubview:studyNumberLabel];
    //宽度
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
        imageViewWidth = 80;
        //名称
        titleLabelX = 100;
        titleLabelWidth = 220;
        //讲师
        lectureLabelX =100;
        lectureLabelWidth = 80;
        //课时
        coureTimeLabelX = 165;
        coureTimeLabelWidth = 100;
        //积分
        ingeralLabelX =100;
        ingeralLabelWidth = 64;
        //已学人数
        studyNumberLabelX =  165;
        studyNumberLabelWith = 95;
        //选课
        electButtonX  = 260;
        electButtonWith = 55;
        startViewsX = 145;
        imageViewX = 5;
        
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
        coureTimeLabelX = 200;
        coureTimeLabelWidth = 116;
        //积分
        ingeralLabelX = 116;
        ingeralLabelWidth = 70;
        //已学人数
        studyNumberLabelX = 200;
        studyNumberLabelWith = 115;
        //选课
        electButtonX = 310;
        electButtonWith =60;
        startViewsX = 170;
        imageViewX = 10;
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
        lectureLabelWidth = 80;
        //课时
        coureTimeLabelX = 215;
        coureTimeLabelWidth =100;
        //积分
        ingeralLabelX = 130;
        ingeralLabelWidth = 70;
        //已学人数
        studyNumberLabelX = 215;
        studyNumberLabelWith = 120;
        //选课
        electButtonX = 330;
        electButtonWith = 76;
        startViewsX = 185;
        imageViewX = 15;
    }
    //图标
    imageView  = [MyContol createImageViewWithFrame:CGRectMake(imageViewX, 15, 90, 85) ImageName:@"首图标.jpg"];
    imageView.layer.cornerRadius =3;
    imageView.layer.masksToBounds = YES;
    [self.contentView addSubview:imageView];
        
    //名称
    titleLabel =[MyContol createLabelWithFrame:CGRectMake(titleLabelX, 10, titleLabelWidth,35) Font:14 Text:@"我对未成年的司法保护"];
    titleLabel.font =[UIFont boldSystemFontOfSize:13];
    titleLabel.textColor = [UIColor colorWithRed:0.3 green:0.34 blue:0.3 alpha:1];
    //    titleLabel.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:titleLabel];
    //讲师
    lectureLabel = [MyContol createLabelWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 100,45, 90, 20) Font:14 Text:@"讲师:丁丁当"];
    //    lectureLabel.backgroundColor =  [UIColor blueColor];
    lectureLabel.textColor =[UIColor grayColor];
    [self.contentView addSubview:lectureLabel];
    //课时
    coureTimeLabel =[MyContol createLabelWithFrame:CGRectMake(lectureLabelX, 45, lectureLabelWidth, 20) Font:14 Text:@"课时：2.5"];
    coureTimeLabel.textColor = [UIColor grayColor];
    //    coureTimeLabel.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:coureTimeLabel];
    //积分
    ingeralLabel = [MyContol createLabelWithFrame:CGRectMake(ingeralLabelX, 65, ingeralLabelWidth, 20) Font:14 Text:@"积分:25"];
    ingeralLabel.textColor =[UIColor grayColor];
    //ingeralLabel.backgroundColor = [UIColor grayColor];
    [self.contentView addSubview:ingeralLabel];
    //已学人数
    studyNumberLabel = [MyContol createLabelWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 100, 65, 90, 20) Font:14 Text:@"已有12人选学"];
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
    commentLabel =  [MyContol createLabelWithFrame:CGRectMake(ingeralLabelX, 86, 50, 20) Font:14 Text:@"评价 ："];
    commentLabel.textColor = [UIColor grayColor];
    [self.contentView addSubview:commentLabel];
    

    
}
-(void)config:(HotSelecModel*)model
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
    
        //课时
    coureTimeLabel.text =[NSString  stringWithFormat:@"课时:%d", model.period];
       //积分
    ingeralLabel.text = [NSString stringWithFormat:@"积分:%d",model.period * 10 ];
    
    //已学人数
    studyNumberLabel.text = [NSString stringWithFormat:@"已有%d人选学",model.studyNum];
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
