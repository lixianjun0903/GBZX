//
//  SpecialClassCell.h
//  干部在线
//
//  Created by lixianjun on 14-12-30.
//  Copyright (c) 2014年 中青年. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface SpecialClassCell : UIView

{
//分割线图片
    UIImageView * lineImageView;
    //标题lable
    UILabel * titleLabel;
    //左边图片
    UIImageView * leftImageView;
    //课程的描述
    UILabel * describleLabel;
    //课程数量
    UILabel * classNumberLabel;

}
-(void)specialConfig:(NSDictionary*)dic;
@end
