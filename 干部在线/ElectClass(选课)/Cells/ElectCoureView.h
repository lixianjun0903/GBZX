//
//  ElectCourevIEW.h
//  干部在线
//
//  Created by lixianjun on 15-1-8.
//  Copyright (c) 2015年 中青年. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ElectCoureView : UIView
{
    
    //section分类的图标
    UIImageView * logoImageView;
    //标题
    UILabel * titleLabel;
}
@property (strong,nonatomic) NSString * sectionTitle;
-(void)config:(NSDictionary *)dic;
@end
