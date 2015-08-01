

//
//  testTableViewCell.m
//  干部在线
//
//  Created by lixianjun on 15-3-21.
//  Copyright (c) 2015年 中青年. All rights reserved.
//

#import "testTableViewCell.h"

@implementation testTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createUI];
        //self.backgroundColor = [UIColor redColor];
    }
    return self;
}
-(void)createUI
{
    imageView  =[[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 100, 80)];
    imageView.image =[UIImage imageNamed:@"测试.jpg"];
    imageView.layer.cornerRadius = 3;
    imageView.layer.masksToBounds  = YES;
    [self.contentView addSubview:imageView];
    teacherLable =[[UILabel alloc] initWithFrame:CGRectMake(160, 15, 100, 25)];
    teacherLable.text = @"王老师";
    teacherLable.font =[UIFont systemFontOfSize:15];
    teacherLable.textColor =[UIColor blackColor];
    [self.contentView addSubview:teacherLable];
    lable =[[UILabel alloc] initWithFrame:CGRectMake(160, 45, 100, 25)];
    lable.text = @"苦难辉煌（一）";
    lable.font =[UIFont systemFontOfSize:14];
    lable.textColor = [UIColor grayColor];
    [self.contentView addSubview:lable];
}
-(void)config:(int)row
{
   
        lable.text =  [NSString stringWithFormat:@"苦难辉煌（%d）",row];
       
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
