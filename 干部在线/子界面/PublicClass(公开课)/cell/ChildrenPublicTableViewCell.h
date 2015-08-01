//
//  ChildrenPublicTableViewCell.h
//  干部在线
//
//  Created by lixianjun on 15-2-2.
//  Copyright (c) 2015年 中青年. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChildrenPublicModel.h"
@interface ChildrenPublicTableViewCell : UITableViewCell

{
    
    //热门选项buton
    UIButton * hotButton ;
    //最新想想button
    UIButton * newButton ;
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
    //播放
    UIImageView * playIMageView;
}
-(void)config:(ChildrenPublicModel*)model;

@end
