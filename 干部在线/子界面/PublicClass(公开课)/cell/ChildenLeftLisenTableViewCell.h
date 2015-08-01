//
//  ChildenLeftLisenTableViewCell.h
//  干部在线
//
//  Created by lixianjun on 15-2-2.
//  Copyright (c) 2015年 中青年. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "childrenleftLisenModel.h"
@interface ChildenLeftLisenTableViewCell : UITableViewCell
{
    
    //评论头像
    UIImageView * headImageVeiw;
    //姓名
    UILabel *namelabel;
    //评论时间
    UILabel * timeLabel;
    //评论内容
    UILabel * contentLabel;
}
-(void)config:(childrenleftLisenModel*)model;
@end
