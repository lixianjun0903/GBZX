//
//  ClassRankTableViewCell.h
//  干部在线
//
//  Created by lixianjun on 15-1-6.
//  Copyright (c) 2015年 中青年. All rights reserved.
//

#import "StudentRankTableViewCell.h"
#import "CourceRankModel.h"
@interface ClassRankTableViewCell : UITableViewCell
{
    
    //排行编号
    UIImageView * numberImageView;
    UILabel * numberLabel;
    //学员头像
    UIImageView * studentHeadImageView;
    //学员姓名
    UILabel * studentNameLabel;
    //学员单位
    UILabel * studentUnit;
    //在现人数
    UILabel * onlineNumberLbel;
}

-(void)config:(CourceRankModel*)model row:(int)row;

@end
