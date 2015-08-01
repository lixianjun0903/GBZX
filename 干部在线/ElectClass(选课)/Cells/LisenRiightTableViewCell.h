//
//  LisenRiightTableViewCell.h
//  干部在线
//
//  Created by lixianjun on 15-1-19.
//  Copyright (c) 2015年 中青年. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LisenRightModel.h"
#import "startView.h"
@interface LisenRiightTableViewCell : UITableViewCell
{
    
    //分割线
    UIImageView * lineImageView ;
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
    //   评价
    UILabel * commentLabel ;
}
-(void)LisenConfig:(LisenRightModel*)model;
@end
