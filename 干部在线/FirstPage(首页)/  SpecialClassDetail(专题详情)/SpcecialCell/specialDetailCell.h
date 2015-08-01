//
//  specialDetailCell.h
//  干部在线
//
//  Created by lixianjun on 15-1-4.
//  Copyright (c) 2015年 中青年. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface specialDetailCell : UIView
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
//  UIButton * selectButton;
}
-(void)config:(NSDictionary *)dic;
@end
