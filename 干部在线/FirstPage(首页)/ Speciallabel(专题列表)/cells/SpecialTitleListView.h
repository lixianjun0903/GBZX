//
//  SpecialTitleListView.h
//  干部在线
//
//  Created by lixianjun on 15-1-9.
//  Copyright (c) 2015年 中青年. All rights reserved.
//

#import "specialDetailCell.h"
#import "SpecialLabelViewController.h"
@interface SpecialTitleListView : specialDetailCell
{//进入专题
    UIButton * enterSpecial;
    //选择全部课程
   //UIButton * selectAllCourceButton;
    UIButton * moreButton;
    UIButton * selectButton;
}
-(void)config:(NSDictionary*)dic;
@property(nonatomic,strong)SpecialLabelViewController * delegate;
@end
