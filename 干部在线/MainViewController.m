//
//  MainViewController.m
//  干部在线
//
//  Created by lixianjun on 14-12-29.
//  Copyright (c) 2014年 中青年. All rights reserved.
//

#import "MainViewController.h"
#include "FirstPageViewController.h"
#include "ElectClassViewController.h"
#include "InformationViewController.h"
#include "MyViewController.h"
@interface MainViewController ()

{

    SelectTabBar * _SectTabView;

}
@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createView];
//    self.tabBar.alpha = 0.6;
    //self.tabBar.hidden = YES;
    // Do any additional setup after loading the view.
}
#pragma mark ---创建takeview
-(void)createView
{
    FirstPageViewController * first = [[FirstPageViewController alloc] init];
    UINavigationController * nc1 = [[UINavigationController alloc] initWithRootViewController:first];
//    nc1.navigationBar.translucent = NO;
    nc1.interactivePopGestureRecognizer.enabled = NO;
    ElectClassViewController * elect = [[ElectClassViewController alloc] init];
    UINavigationController * nc2 = [[UINavigationController alloc] initWithRootViewController:elect];
//    nc2.navigationBar.translucent = NO;
    InformationViewController * infor = [[InformationViewController alloc] init];
    UINavigationController * nc3 = [[UINavigationController alloc] initWithRootViewController:infor];
//    nc3.navigationBar.translucent = NO;
    MyViewController * my =[[MyViewController alloc] init];
    UINavigationController * nc4 = [[UINavigationController alloc] initWithRootViewController:my];
//    nc4.navigationBar.translucent = NO;
    NSArray * array = @[nc1,nc2,nc3,nc4];
    self.viewControllers = array;
    self.selectedIndex = 0;
    _SectTabView = [[SelectTabBar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 50)];
    _SectTabView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleTopMargin;
    _SectTabView.delegate = self;
    [self.tabBar addSubview:_SectTabView];
    NSLog(@"tabbar %@", self.tabBar);
    [self OnTabSelect:_SectTabView];
}
- (void)OnTabSelect:(SelectTabBar *)sender {
    int index = sender.miIndex;
    NSLog(@"OnTabSelect:%d", index);
    self.selectedIndex = index;
    [self.tabBar bringSubviewToFront:_SectTabView];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
