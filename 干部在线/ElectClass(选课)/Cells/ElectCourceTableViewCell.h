//
//  ElectCourceTableViewCell.h
//  干部在线
//
//  Created by lixianjun on 15-1-8.
//  Copyright (c) 2015年 中青年. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ElectCourceTableViewCell : UITableViewCell

{
    
    //图标
    
    UIImageView * logoImageView;
    //课程名
    UILabel * courceLabel;
    
}
-(void)config:(NSDictionary*)dic;
@end
