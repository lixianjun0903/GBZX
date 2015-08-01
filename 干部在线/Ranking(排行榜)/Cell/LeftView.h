//
//  LeftView.h
//  干部在线
//
//  Created by lixianjun on 15-1-8.
//  Copyright (c) 2015年 中青年. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LeftView : UIView<UITableViewDataSource,UITableViewDelegate,MBProgressHUDDelegate>
{


}
@property(nonatomic,strong)NSString *  mLoadMsg;
@end
