//
//  SpecialClassCell.m
//  干部在线
//
//  Created by lixianjun on 14-12-30.
//  Copyright (c) 2014年 中青年. All rights reserved.
//

#import "SpecialClassCell.h"

@implementation SpecialClassCell

-(id)initWithFrame:(CGRect)frame
{

    self = [super initWithFrame:frame];
    if (self) {
        
        [self makeUI];
    }
    return self;
    
}
-(void)makeUI
{
    //分割线图片
    lineImageView = [MyContol createImageViewWithFrame:CGRectMake(10, 14, 4, 22) ImageName:nil];
    lineImageView.image = [UIImage imageNamed:@"分隔条.png"];
    [self addSubview:lineImageView];
    //标题lable
    titleLabel = [MyContol createLabelWithFrame:CGRectMake(20, 15, self.frame.size.width, 20) Font:18 Text:@"中共十八届四中全会系列课程"];
    titleLabel.font = [UIFont boldSystemFontOfSize:18];
    titleLabel.textColor =[UIColor grayColor];
    [self addSubview:titleLabel];
    //左边图片
    leftImageView = [MyContol createImageViewWithFrame:CGRectMake(10, 45,95, 70) ImageName:nil];
    
    leftImageView.layer.cornerRadius = 6;
    leftImageView.layer.masksToBounds = YES;
    leftImageView.image = [UIImage imageNamed:@"专题详情.jpg"];
    [self addSubview:leftImageView];
    //课程的描述
    describleLabel = [MyContol createLabelWithFrame:CGRectMake(120, 35, self.frame.size.width - 130, 60) Font:16 Text:@"专题课程简介:本次培训的课程体系紧紧围绕政治理论 ..."];
    describleLabel.numberOfLines = 0;
    describleLabel.lineBreakMode = NSLineBreakByCharWrapping;
    //describleLabel.backgroundColor =[UIColor redColor];
    [self addSubview:describleLabel];
    //课程数量
    classNumberLabel = [MyContol createLabelWithFrame:CGRectMake(125, 92, self.frame.size.width - 120, 20) Font:17 Text:@"课程数量:  6门"];
    [self addSubview:classNumberLabel];


}
-(void)specialConfig:(NSDictionary*)dic
{
    //标题lable
    titleLabel.text = dic[@"topicName"];
    //左边图片
    [leftImageView sd_setImageWithURL:[NSURL URLWithString:dic[@"topicImgUrl"]] placeholderImage:[UIImage imageNamed:@"专题详情.jpg"]];
    //课程的描述
    describleLabel.text = [NSString stringWithFormat:@"专题课程简介:  %@",dic[@"topicIntro"]];
    NSMutableAttributedString *describleLabelStr = [[NSMutableAttributedString alloc] initWithString:describleLabel.text];
    [describleLabelStr addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0,6)];
    [describleLabelStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Arial-BoldItalicMT" size:17.0] range:NSMakeRange(0, 6)];
    describleLabel.attributedText = describleLabelStr;
        //课程数量
    classNumberLabel.text =[NSString stringWithFormat:@"课程数量:  %@ 门", dic[@"courseNum"]];
    NSMutableAttributedString *classNumberLabelStr = [[NSMutableAttributedString alloc] initWithString:classNumberLabel.text];
    [classNumberLabelStr addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0,4)];
    [classNumberLabelStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Arial-BoldItalicMT" size:17.0] range:NSMakeRange(0, 4)];
    classNumberLabel.attributedText = classNumberLabelStr;

}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
