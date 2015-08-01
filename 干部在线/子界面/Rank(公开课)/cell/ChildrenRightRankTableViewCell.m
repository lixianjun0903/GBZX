
//
//  ChildrenRightRankTableViewCell.m
//  干部在线
//
//  Created by lixianjun on 15-2-2.
//  Copyright (c) 2015年 中青年. All rights reserved.
//

#import "ChildrenRightRankTableViewCell.h"

@implementation ChildrenRightRankTableViewCell
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
    //self.contentView.backgroundColor = [UIColor purpleColor];
    numberImageView =[ MyContol createImageViewWithFrame:CGRectMake(10, (100-30)/2,30, 30) ImageName:@"4"];
    numberImageView.layer.cornerRadius = 10;
    numberImageView.layer.masksToBounds = YES;
    [self.contentView addSubview:numberImageView];
    numberLabel   = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, 20, 20)];
    numberLabel.text = @"";
    numberLabel.adjustsFontSizeToFitWidth = YES;
    numberLabel.textAlignment = NSTextAlignmentCenter;
    numberLabel.numberOfLines = 1;
    numberLabel.textColor = [UIColor whiteColor];
    [numberImageView addSubview:numberLabel];
    //学员头像
    studentHeadImageView = [MyContol createImageViewWithFrame:CGRectMake(50,(100-70)/2, 80, 70) ImageName:@"course_bg_g.png"];
    studentHeadImageView.layer.cornerRadius = 8;
    studentHeadImageView.layer.masksToBounds = YES;
    [self.contentView addSubview:studentHeadImageView];
    //课程标题
    studentNameLabel = [MyContol createLabelWithFrame:CGRectMake(150, 10, [UIScreen mainScreen].bounds.size.width  - 150 - 10, 60) Font:16 Text:@"2014年度第三期全国地市级团委"]
    ;
    studentNameLabel.lineBreakMode = NSLineBreakByWordWrapping;
    studentNameLabel.font = [UIFont systemFontOfSize:16];
    [self.contentView addSubview:studentNameLabel];
    //    //学员单位
    //    studentUnit = [MyContol createLabelWithFrame:CGRectMake(150, 40, 140, 30) Font:20 Text:@"____班子成员和县级"];
    //    [self.contentView addSubview:studentUnit];
    //选课人数
    onlineNumberLbel = [MyContol createLabelWithFrame:CGRectMake(150, 63, 120, 30) Font:15 Text:@"在线人数：50人在线"];
    [self.contentView addSubview:onlineNumberLbel];
}
-(void)config:(childrenRightRankModel *)model row:(int)row
{
    //排行编号
    //图像
    //numberImageView.image = nil;
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
    [studentHeadImageView sd_setImageWithURL:[NSURL URLWithString:model.courseImgUrl] placeholderImage:[UIImage imageNamed:@"course_bg_g.png"]];
    //课程标题
    studentNameLabel.text = model.name;
    //    studentUnit.text = @"___大力推进依法治国";
    //选课人数
    onlineNumberLbel.text = [NSString stringWithFormat:@"选课人数:%d人",model.studyNum];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
