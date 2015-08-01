//
//  StudentRankTableViewCell.h
//  干部在线
//
//  Created by lixianjun on 15-1-6.
//  Copyright (c) 2015年 中青年. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StudentRankModel.h"
@interface StudentRankTableViewCell : UITableViewCell

{
    
    //排行编号
    UIImageView * numberImageView;
    //排行编号数字
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
-(void)config:(StudentRankModel *)model row:(int)row;
@end
