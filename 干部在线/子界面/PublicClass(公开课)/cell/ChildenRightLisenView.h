//
//  ChildenRightLisenView.h
//  干部在线
//
//  Created by lixianjun on 15-2-2.
//  Copyright (c) 2015年 中青年. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChildenRightLisenView : UIView<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,copy)NSString *  coureId;
-(void)loadData;
@end
