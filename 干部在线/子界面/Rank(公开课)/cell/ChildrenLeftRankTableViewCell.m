

//
//  ChildrenLeftRankTableViewCell.m
//  干部在线
//
//  Created by lixianjun on 15-2-2.
//  Copyright (c) 2015年 中青年. All rights reserved.
//

#import "ChildrenLeftRankTableViewCell.h"

@implementation ChildrenLeftRankTableViewCell
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
    numberImageView =[ MyContol createImageViewWithFrame:CGRectMake(15, 25, 30, 30) ImageName:@"1.png"];
    numberImageView.layer.cornerRadius = 10;
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
    studentHeadImageView = [MyContol createImageViewWithFrame:CGRectMake(52,20, 56, 56) ImageName:@"学员头像1.png"];
    studentHeadImageView.backgroundColor =[UIColor redColor];
    studentHeadImageView.layer.cornerRadius = 28;
    studentHeadImageView.layer.masksToBounds = YES;
    [self.contentView addSubview:studentHeadImageView];
    
    //学员姓名
    studentNameLabel = [MyContol createLabelWithFrame:CGRectMake(130, 10, 50, 24) Font:17 Text:@"李先生"];
    studentNameLabel.font = [UIFont boldSystemFontOfSize:17];
    
    [self.contentView addSubview:studentNameLabel];
    //学员单位
    studentUnit = [MyContol createLabelWithFrame:CGRectMake(130, 40, 100, 30) Font:15 Text:@"工共青团中央组"];
    [self.contentView addSubview:studentUnit];
    //在现人数
    onlineNumberLbel = [MyContol createLabelWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-120, 20, 80, 30) Font:17 Text:@"50分钟"];
    
    //onlineNumberLbel.backgroundColor = [UIColor redColor];
    onlineNumberLbel.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:onlineNumberLbel];
}
-(void)config:(childrenLeftRankModel *)model row:(int)row
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
    studentNameLabel.text  = model.name;
    //学员单位
    
    studentUnit.text = model.organization;
    //学习时间
    onlineNumberLbel.text = [NSString stringWithFormat:@"%@分钟", model.learnedHours];
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
