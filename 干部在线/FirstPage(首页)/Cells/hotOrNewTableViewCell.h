//
//  hotOrNewTableViewCell.h
//  干部在线
//
//  Created by lixianjun on 14-12-30.
//  Copyright (c) 2014年 中青年. All rights reserved.
//

#import <UIKit/UIKit.h>
#include "startView.h"
#import "FirtPageModel.h"
@interface hotOrNewTableViewCell : UITableViewCell
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
    UIActivityIndicatorView *activityIndicatorView;

}
-(void)config:(FirtPageModel*)model;
@end
