//
//  classPlay.h
//  干部在线
//
//  Created by lixianjun on 15-1-5.
//  Copyright (c) 2015年 中青年. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface classDisplay : UIView

{
    //标题
    UILabel * titleLabel;
    //图标
    UIImageView * imageView ;
    //讲师
    UILabel *teacherLabel;
    //课时
    UILabel * classTimeLabel;
    //积分
    UILabel * markLabel;
    //学习人数
    UILabel * learnNumberLabel;
    //评价
    UILabel * smarkLabel;
    //想写描述
    UILabel * describeLabel;
    
    //更多
    UIButton * moreButton;
       
    
}
-(void)config:(NSDictionary *)dic;
@end
