//
//  testTableViewCell.h
//  干部在线
//
//  Created by lixianjun on 15-3-21.
//  Copyright (c) 2015年 中青年. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface testTableViewCell : UITableViewCell

{
    UIImageView * imageView;
    UILabel * lable;
    UILabel * teacherLable;
}
-(void)config:(int)row;
@end
