


//
//  LisenLeftTableViewCell.m
//  干部在线
//
//  Created by lixianjun on 15-1-19.
//  Copyright (c) 2015年 中青年. All rights reserved.
//

#import "LisenLeftTableViewCell.h"

@implementation LisenLeftTableViewCell
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
    //评论头像
    headImageVeiw = [MyContol createImageViewWithFrame:CGRectMake(10, 20, 60, 60) ImageName:@"学员头像1.png"];
    headImageVeiw.backgroundColor  =[UIColor redColor];
    [self.contentView addSubview:headImageVeiw];
    headImageVeiw.layer.cornerRadius = 30;
    
    headImageVeiw.layer.masksToBounds = YES;
    headImageVeiw.layer.borderColor = [UIColor colorWithRed:0.52 green:0.09 blue:0.07 alpha:1].CGColor;
    
    //姓名
    namelabel = [MyContol createLabelWithFrame:CGRectMake(80, 20, 60, 20) Font:15 Text:@"张三"];
    namelabel.font =[UIFont systemFontOfSize:15];
    namelabel.textColor = [UIColor colorWithRed:0.3 green:0.34 blue:0.3 alpha:1];
    [self.contentView addSubview:namelabel];
    //评论时间
    timeLabel = [MyContol createLabelWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 160,20, self.frame.size.width - 130,20) Font:15 Text:@"2014:09:02"];
    timeLabel.textColor = [UIColor grayColor];
    timeLabel.textColor = [UIColor colorWithRed:0.3 green:0.34 blue:0.3 alpha:1];
    [self.contentView addSubview:timeLabel];
    //评论内容
    contentLabel = [MyContol createLabelWithFrame:CGRectMake(80, 80 -20 , self.contentView .frame.size.width - 70, 20) Font:14 Text:@"经过这次的培训，使我受益匪浅"];
    contentLabel.numberOfLines = 0;
    contentLabel.font = [UIFont systemFontOfSize:14];
    contentLabel.textColor = [UIColor grayColor];
    [self.contentView addSubview:contentLabel];
    
}
-(void)config:(commentMOdel*)model
{//评论头像
    [headImageVeiw sd_setImageWithURL:[NSURL URLWithString:model.headPortraitUrl]placeholderImage:[UIImage imageNamed:@"学员头像1.png"]];
    //评论的名字
    namelabel.text = model.userName;
    //评论时间
    timeLabel.text = model.commentTime;
    //评论的内容
    contentLabel.text = model.commentContent;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
