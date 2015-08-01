//
//  RootViewController.h
//  干部在线
//
//  Created by lixianjun on 15-1-12.
//  Copyright (c) 2015年 中青年. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol RootViewControllerDelegate <NSObject>

- (void)pushToNextClass:(NSString *)className;
@end

@interface RootViewController : UIViewController

@property (nonatomic,assign)id<RootViewControllerDelegate>delegate;
@end
