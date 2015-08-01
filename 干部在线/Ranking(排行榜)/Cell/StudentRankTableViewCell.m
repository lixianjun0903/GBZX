//
//  StudentRankTableViewCell.m
//  干部在线
//
//  Created by lixianjun on 15-1-6.
//  Copyright (c) 2015年 中青年. All rights reserved.
//

#import "StudentRankTableViewCell.h"

@implementation StudentRankTableViewCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createUI];
    }
    return self;
}

-(void)createUI
{
      //排行编号
    numberImageView =[ MyContol createImageViewWithFrame:CGRectMake(15, (85 - 30) / 2, 30, 30) ImageName:@"1.png"];
    numberImageView.layer.cornerRadius = 15;
    numberImageView.layer.masksToBounds = YES;
    [self.contentView addSubview:numberImageView];
    
    //排行编号数字
    numberLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, 20, 20)];
    numberLabel.text = @"";
    numberLabel.adjustsFontSizeToFitWidth = YES;
    numberLabel.textAlignment = NSTextAlignmentCenter;
    numberLabel.numberOfLines = 1;
    numberLabel.textColor = [UIColor whiteColor];
    [numberImageView addSubview:numberLabel];
    
    //学员头像
    studentHeadImageView = [MyContol createImageViewWithFrame:CGRectMake(54,(85 - 56) / 2, 56, 56) ImageName:@"学员头像1.png"];
//   studentHeadImageView.backgroundColor =[UIColor redColor];
    studentHeadImageView.layer.cornerRadius = 28;
    studentHeadImageView.layer.masksToBounds = YES;
    [self.contentView addSubview:studentHeadImageView];

    //学员姓名
    studentNameLabel = [MyContol createLabelWithFrame:CGRectMake(130, (85 - 56) / 2, 50, 15) Font:15 Text:@"张三"];
   studentNameLabel.textColor = [UIColor grayColor];
//    studentNameLabel.backgroundColor = [UIColor yellowColor];
    studentNameLabel.font = [UIFont boldSystemFontOfSize:15];
    
    [self.contentView addSubview:studentNameLabel];
    //学员单位
    studentUnit = [MyContol createLabelWithFrame:CGRectMake(130, (85 - (85 - 56) / 2-14)-2, 120, 14) Font:14 Text:@"北京地税局"];
//    studentUnit.backgroundColor =[UIColor redColor];
    studentUnit.textColor = [UIColor grayColor];
    studentUnit.textColor = [UIColor colorWithRed:0.3 green:0.34 blue:0.3 alpha:1];
    studentUnit.font =[UIFont boldSystemFontOfSize:14];
    [self.contentView addSubview:studentUnit];
    //在现人数
    onlineNumberLbel = [MyContol createLabelWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-120, (85 - 20)/2-8, 80, 20) Font:14 Text:@"50分钟"];
    onlineNumberLbel.textColor =[UIColor grayColor];
    
    //onlineNumberLbel.backgroundColor = [UIColor redColor];
    onlineNumberLbel.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:onlineNumberLbel];
}
-(void)config:(StudentRankModel *)model row:(int)row
{
    //图像
    if (row == 0) {
        numberImageView.image = [UIImage imageNamed:@"1"];
    }
    else if (row == 1)
    {
        numberImageView.image = [UIImage imageNamed:@"2"];
    }
    else if(row == 2)
    {
        numberImageView.image = [UIImage imageNamed:@"3"];
    }
    else
    {
        numberImageView.image = [UIImage imageNamed:@"4"];
        
    }
    if (row >=3) {
        numberLabel.text = [NSString stringWithFormat:@"%d",1+row++];
    }
    else
    {
        numberLabel.text = @"";
    }
    //学员头像
//    [studentHeadImageView sd_setImageWithURL:[NSURL URLWithString:model.headPortraitUrl]placeholderImage:[UIImage imageNamed:@"yh_icon_头像.png"]];
    //学员姓名
    if (model.name == nil) {
        studentNameLabel.text  = @"张三";

    }
    else
    {studentNameLabel.text  = model.name;

    }
  //学员单位
    if (model.organization==nil) {
        studentUnit.text =@"北京地随局";
    }
    else
    {
    studentUnit.text = model.organization;
    }
    //学习时间
    if (model.learnedHours == nil) {
        onlineNumberLbel.text = @"0分钟";
    }
    else
    {
        onlineNumberLbel.text = [NSString stringWithFormat:@"%@分钟", model.learnedHours];

        
        }
    
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
