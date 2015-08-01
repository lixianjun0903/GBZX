

//
//  ChildenLeftLisenTableViewCell.m
//  干部在线
//
//  Created by lixianjun on 15-2-2.
//  Copyright (c) 2015年 中青年. All rights reserved.
//

#import "ChildenLeftLisenTableViewCell.h"

@implementation ChildenLeftLisenTableViewCell
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
    headImageVeiw = [MyContol createImageViewWithFrame:CGRectMake(5, 20, 60, 60) ImageName:@"yh_icon_头像.png"];
    headImageVeiw.backgroundColor  =[UIColor redColor];
    [self.contentView addSubview:headImageVeiw];
    headImageVeiw.layer.cornerRadius = 30;
    
    headImageVeiw.layer.masksToBounds = YES;
    headImageVeiw.layer.borderColor = [UIColor colorWithRed:0.52 green:0.09 blue:0.07 alpha:1].CGColor;
    
    //姓名
    namelabel = [MyContol createLabelWithFrame:CGRectMake(70, 20, 60, 20) Font:15 Text:@"张三"];
    [self.contentView addSubview:namelabel];
    //评论时间
    timeLabel = [MyContol createLabelWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 180,20, self.frame.size.width - 130,20) Font:15 Text:@"2014:09:02"];
    [self.contentView addSubview:timeLabel];
    //评论内容
    contentLabel = [MyContol createLabelWithFrame:CGRectMake(70, 50, self.contentView .frame.size.width - 70, 40) Font:15 Text:@"参加过很多培训，进行闭卷考试的培训还是第一次，幸亏考前认真准备了，不然有的题目还真不一定答得上来。"];
    contentLabel.numberOfLines = 0;
    [self.contentView addSubview:contentLabel];
    
}
-(void)config:(childrenleftLisenModel*)model
{//评论头像
    [headImageVeiw sd_setImageWithURL:[NSURL URLWithString:model.headPortraitUrl]placeholderImage:[UIImage imageNamed:@"yh_icon_头像.png"]];
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
