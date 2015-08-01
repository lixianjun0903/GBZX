
//
//  ElectCourceTableViewCell.m
//  干部在线
//
//  Created by lixianjun on 15-1-8.
//  Copyright (c) 2015年 中青年. All rights reserved.
//

#import "ElectCourceTableViewCell.h"

@implementation ElectCourceTableViewCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self makeUI];
    }
    return self;
}
-(void)makeUI
{   //图标
    logoImageView =[MyContol createImageViewWithFrame:CGRectMake(20,(60 - 18)/2, 14, 14) ImageName:@"课程分类.png"];
    [self.contentView addSubview:logoImageView
     ];
    //课程名
    courceLabel = [MyContol createLabelWithFrame:CGRectMake(50, 20, self.frame.size.width - 100, 20) Font:16 Text:@"团的基本知识"];
    [self.contentView addSubview:courceLabel];
    
}
-(void)config:(NSDictionary*)dic
{
    
    courceLabel.text = dic[@"childCategoryName"];
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
