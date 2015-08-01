//
//  searchTableViewCell.h
//  干部在线
//
//  Created by lixianjun on 15-2-3.
//  Copyright (c) 2015年 中青年. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ClassEveryModel.h"
@interface searchTableViewCell : UITableViewCell
{
    //图标
    UIImageView * imageView;
    //名称
    UILabel * titleLabel;
    //讲师
    UILabel * lectureLabel;
    //课时
    UILabel * coureTimeLabel;
    //积分
    UILabel  * ingeralLabel;
    //已学人数
    UILabel * studyNumberLabel;
    //选课
    UIButton * electButton;
    //选课退课
    UIImageView *isSelectView;
    UIImageView * retreatView;


}
-(void)config:(ClassEveryModel*)model;
@end
