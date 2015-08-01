//
//  StudyCenterViewController.m
//  干部在线
//
//  Created by lixianjun on 15-3-20.
//  Copyright (c) 2015年 中青年. All rights reserved.
//

#import "StudyCenterViewController.h"

@interface StudyCenterViewController ()

@end

@implementation StudyCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =[UIColor whiteColor];
    [self createNav];
    // Do any additional setup after loading the view.
}
-(void)createNav
{

    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 20)];
    view.backgroundColor = [UIColor blackColor];
    [self.navigationController.view addSubview:view];
    self.navigationController.navigationBar.barTintColor  = [UIColor colorWithRed:0.19f green:0.51f blue:0.93f alpha:1.00f];
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 80, 44)];
    titleLabel.text = @"学习中心";
    titleLabel.textColor =[UIColor whiteColor];
    titleLabel.font = [UIFont boldSystemFontOfSize:20];
    self.navigationItem.titleView = titleLabel;
    //左侧首页按钮
    UIButton * leftButton = [MyContol createButtonWithFrame:CGRectMake(5, 15, 14, 22) ImageName:@"back.png" Target:self Action:@selector(firstLeftClick) Title:nil];
    leftButton.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    self.navigationItem.leftBarButtonItem =[[UIBarButtonItem alloc] initWithCustomView:leftButton];
    
}
-(void)firstLeftClick
{[self dismissViewControllerAnimated:YES completion:nil];
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
