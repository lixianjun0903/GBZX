//
//  HotTableViewCell.h
//  干部在线
//
//  Created by lixianjun on 15-1-19.
//  Copyright (c) 2015年 中青年. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Hotmodel.h"
@interface HotTableViewCell : UITableViewCell
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
    
    
}
-(void)config:(Hotmodel*)model;

@end
