//
//  ChildrenRightRankTableViewCell.h
//  干部在线
//
//  Created by lixianjun on 15-2-2.
//  Copyright (c) 2015年 中青年. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "childrenRightRankModel.h"
@interface ChildrenRightRankTableViewCell : UITableViewCell
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

-(void)config:(childrenRightRankModel*)model row:(int)row;
@end
