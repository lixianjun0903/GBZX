//
//  AppDelegate.h
//  干部在线
//
//  Created by lixianjun on 14-12-29.
//  Copyright (c) 2014年 中青年. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YRSideViewController.h"
#import "RootViewController.h"
#import "mainTabBarViewController.h"
#import "MyViewController.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate>


@property (strong, nonatomic) UIWindow *window;
@property(strong,nonatomic)mainTabBarViewController *mainVC;
@property(strong,nonatomic)MyViewController * myController;
@property (nonatomic,strong)YRSideViewController *sideViewController;
@property (assign) int ori_flag;
@end

