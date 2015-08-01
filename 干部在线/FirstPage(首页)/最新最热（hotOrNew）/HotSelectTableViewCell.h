//
//  HotSelectTableViewCell.h
//  干部在线
//
//  Created by lixianjun on 15-3-9.
//  Copyright (c) 2015年 中青年. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HotSelecModel.h"
#import "startView.h"
@interface HotSelectTableViewCell : UITableViewCell
{
//    //图标
//    UIImageView * imageView;
//    //名称
//    UILabel * titleLabel;
//    //讲师
//    UILabel * lectureLabel;
//    //课时
//    UILabel * coureTimeLabel;
//    //积分
//    UILabel  * ingeralLabel;
//    //已学人数
//    UILabel * studyNumberLabel;
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
    
    //    //评价
    UILabel * commentLabel;
    
    
}
-(void)config:(HotSelecModel*)model;
@end
