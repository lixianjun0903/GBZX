//
//  ElectClassViewController.h
//  干部在线
//
//  Created by lixianjun on 14-12-29.
//  Copyright (c) 2014年 中青年. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ElectClassViewController : UIViewController
{
    //用来保存所有分类信息的数组
    NSMutableArray * _categoryArray;
    //用来显示分类信息的表格视图
    UITableView * _tableView;


}
@property(nonatomic,copy)NSString * nattitle;
@property(nonatomic,strong)NSString * mLoadMsg;
@end
