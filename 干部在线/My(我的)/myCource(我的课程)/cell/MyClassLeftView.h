//
//  MyClassLeftView.h
//  干部在线
//
//  Created by lixianjun on 15-1-22.
//  Copyright (c) 2015年 中青年. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyClassLeftView : UIView
{
MBProgressHUD * mLoadView;
}
@property (nonatomic, strong) NSString *mLoadMsg;
-(void)loadData;
@end
