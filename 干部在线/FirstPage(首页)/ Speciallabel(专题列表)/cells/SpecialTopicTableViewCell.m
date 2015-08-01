

//
//  SpecialTopicTableViewCell.m
//  干部在线
//
//  Created by lixianjun on 15-1-17.
//  Copyright (c) 2015年 中青年. All rights reserved.
//

#import "SpecialTopicTableViewCell.h"
#import "ImageDownManager.h"
#import "JSON.h"
#import "SpecialClassDetailViewController.h"
@implementation SpecialTopicTableViewCell

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

{    //titlelabel
//    self.contentView.backgroundColor = [UIColor redColor];
    //标题
    self.accessoryType = UITableViewCellAccessoryNone;
    titleLabel = [MyContol createLabelWithFrame:CGRectMake(0, 5, [UIScreen mainScreen].bounds.size.width, 20) Font:17 Text:@"全面推进依法治国"];
    titleLabel.font = [UIFont boldSystemFontOfSize:17];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:titleLabel];
    //logo图片
    imageView = [MyContol createImageViewWithFrame:CGRectMake(10, 30,[UIScreen mainScreen].bounds.size.width-20,140) ImageName:@"专题.png"];
    imageView.layer.cornerRadius = 10;
    imageView.layer.masksToBounds = YES;
    [self addSubview:imageView];
    //课程数量
    classNumber = [MyContol createLabelWithFrame:CGRectMake(10, 175, 140, 20) Font:15 Text:@"课程数量：10门"];
    //classNumber.backgroundColor = [UIColor grayColor];
    [self addSubview:classNumber];
    //上线时间
    startTime =[MyContol createLabelWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 190, 175,[UIScreen mainScreen].bounds.size.width - 170, 20) Font:15 Text:@"上线时间：2013:1月：1日"];
    [self addSubview:startTime];
    //    //详细描述
    describeLbel =[MyContol createLabelWithFrame:CGRectMake(0,205,[UIScreen mainScreen].bounds.size.width, 40) Font:15 Text:[NSString stringWithFormat:@" "" "" 为确保团的业务课程质量，团中央机关各部门精心备课，对工作进行了系统梳理"]];
    describeLbel.numberOfLines = 2;
    describeLbel.lineBreakMode = NSLineBreakByWordWrapping;
    
    [self addSubview:describeLbel];
    //更多
    moreButton = [MyContol createButtonWithFrame:CGRectMake(describeLbel.frame.size.width - 50, 25, 40, 25) ImageName:nil Target:self Action:@selector(moreButton) Title:@"更多"];
    moreButton.titleLabel.font =[UIFont boldSystemFontOfSize:15];
    [moreButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [describeLbel addSubview:moreButton];
    
    //黑线条
    backGroundView = [[UIView alloc] initWithFrame:CGRectMake(10, 265,self.frame.size.width - 20, 1)];
    backGroundView.backgroundColor =[UIColor colorWithRed:244/255.0 green:244/255.0 blue:244/255.0 alpha:1];
    [self addSubview:backGroundView];
    //进入专题
    enterSpecial = [MyContol createButtonWithFrame:CGRectMake(20, 290, [UIScreen mainScreen].bounds.size.width/2-40, 40) ImageName:nil Target:self Action:@selector(enterClick) Title:@"进入专题"];
    
    enterSpecial.layer.cornerRadius = 5;
    enterSpecial.layer.masksToBounds = YES;
    enterSpecial.backgroundColor =[UIColor colorWithRed:0.19f green:0.51f blue:0.94f alpha:1.00f];
    [self addSubview:enterSpecial];

}
-(void)config:(NSDictionary*)dic
{
    //标题
    titleLabel.text = dic[@"topicName"];
    //logo图片
    [imageView sd_setImageWithURL:[NSURL URLWithString:dic[@"topicImgUrl"]]placeholderImage:[UIImage imageNamed:@"专题.png"]];
    //课程数量
    
    classNumber.text = [NSString stringWithFormat:@"课程数量：%@",dic[@"courseNum"]];
    //课程ID
    self.topicId =[NSString stringWithFormat:@"%@",dic[@"topicId"]];
    //上线时间
    startTime.text = [NSString stringWithFormat:@"上线时间: %@",dic[@"createTime"]];
    
    //详细描述
    describeLbel.text = [NSString stringWithFormat:@"    %@",dic[@"topicIntro"]];

}
-(void)enterClick
{
    NSLog(@"进入专题");
    SpecialClassDetailViewController  * special = [[SpecialClassDetailViewController alloc] init];
    special.topicID = self.topicId;
    [self.delegate.navigationController pushViewController:special animated:YES];
    
    
}
-(void)classButtonClick
{
    
    NSLog(@"选择全部课程");
    
}
#pragma mark 更多内容
-(void)moreButton
{
    
    NSLog(@"显示更多内容");
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
