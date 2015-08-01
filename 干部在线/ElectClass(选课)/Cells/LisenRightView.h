//
//  LisenRightView.h
//  干部在线
//
//  Created by lixianjun on 15-1-19.
//  Copyright (c) 2015年 中青年. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LisenRightView : UIView<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,copy)NSString *  coureId;
-(void)loadData;
@end
