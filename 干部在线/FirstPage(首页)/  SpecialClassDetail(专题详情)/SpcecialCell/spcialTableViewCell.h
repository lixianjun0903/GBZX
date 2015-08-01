//
//  spcialTableViewCell.h
//  干部在线
//
//  Created by lixianjun on 15-1-4.
//  Copyright (c) 2015年 中青年. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "specialTabelModel.h"
@interface spcialTableViewCell : UITableViewCell
{
//课程排序
    UILabel * courceNumberLabel;
    
    //左边图片
    UIImageView * leftImageView ;
    //课程
    UILabel * classLabel;
    //讲师
    UILabel * lecturerLabel;
    //课shi
    UILabel * classTimeLabel;
    //积分
    UILabel * markLabel;
    //学习人数
    UILabel * leanNumberLabel;
    }
-(void)config:(specialTabelModel*)model row:(int)row;
@end
