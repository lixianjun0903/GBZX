//
//  SpecialTopicTableViewCell.h
//  干部在线
//
//  Created by lixianjun on 15-1-17.
//  Copyright (c) 2015年 中青年. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SpecialTopicListViewController.h"

@interface SpecialTopicTableViewCell : UITableViewCell

{

    //titlelabel
    UILabel  * titleLabel;
    //logo图片
    UIImageView * imageView;
    //课程数量
    UILabel * classNumber;
    //上线时间
    UILabel * startTime;
    //详细描述
    UILabel * describeLbel;
    UIView * backGroundView;
    UIButton * selectButton;
    
    //进入专题
    UIButton * enterSpecial;
    //选择全部课程
   // UIButton * selectAllCourceButton;
    UIButton * moreButton;
}
-(void)config:(NSDictionary *)dic;
@property(nonatomic,strong)SpecialTopicListViewController  * delegate;
@property(nonatomic,copy)NSString * topicId;
@end
