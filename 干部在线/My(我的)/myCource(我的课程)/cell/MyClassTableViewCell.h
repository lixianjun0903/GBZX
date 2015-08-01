//
//  MyClassTableViewCell.h
//  干部在线
//
//  Created by lixianjun on 15-1-9.
//  Copyright (c) 2015年 中青年. All rights reserved.
//

#import "hotOrNewTableViewCell.h"
#import "MyClassModel.h"
@interface MyClassTableViewCell : UITableViewCell

{
    
    
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
    //学习进度底部条
    UIImageView * bgLearnPressImageVeiw;
    //学习进度
    UIImageView * LearnPressImageVeiw;
//    //观看
//    UIImageView *  seeImageView;
//学习进度
    UILabel * learnProgressLabel;
  
    
}
-(void)myClassCofig:(MyClassModel*)model rowNumber:(int)row;
@end
