//
//  InformationViewController.m
//  干部在线
//
//  Created by lixianjun on 14-12-29.
//  Copyright (c) 2014年 中青年. All rights reserved.
//

#import "InformationViewController.h"
#import "AppDelegate.h"
@interface InformationViewController ()

@end
@implementation InformationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self createNav];
   
    [self createLabel];
        // Do any additional setup after loading the view.
}
-(void)createLabel
{
//    UILabel * label =[[UILabel alloc] initWithFrame:CGRectMake(0, 60, WIDETH, 40)];
//    label.text = @"暂无相关内容";
//    label.textColor =[UIColor greenColor];
//    label.textAlignment = NSTextAlignmentCenter;
//    [self.view addSubview:label];
    UIImageView * imageView =[[UIImageView alloc] initWithFrame:CGRectMake((WIDETH - 145)/2,(HEIGHT - 355)/2, 145, 205)];
    imageView.image =[UIImage imageNamed:@"答题.png"];
    [self.view addSubview:imageView];
    
    
    
//    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(10, 10, 200, 30)];
//    // 设置UITextField的样式
//    textField.borderStyle = UITextBorderStyleBezel;
//    //输入框中是否有个叉号，在什么时候显示，用于一次性删除输入框中的内容
//    textField.clearButtonMode = UITextFieldViewModeAlways;
//    [self.view addSubview:textField];
//    //设置背景
//    textField.background = [UIImage imageNamed:@"dd.png"];
//    //设置背景
//    textField.disabledBackground = [UIImage imageNamed:@"cc.png"];
    
}

-(void)createNav
{
    
  self.navigationController.navigationBar.translucent = NO;
    //修改状态栏的颜色
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 20)];
    view.backgroundColor = [UIColor blackColor];
    
    //[self.navigationController.view addSubview:view];
    UIApplication * app = [UIApplication sharedApplication];
    AppDelegate * delegate = (AppDelegate*)app.delegate;
    [delegate.window addSubview:view];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.19f green:0.51f blue:0.93f alpha:1.00f];
        UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 80, 44)];
    titleLabel.text = @"答题";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor =[UIColor whiteColor];
    titleLabel.font = [UIFont boldSystemFontOfSize:20];
    self.navigationItem.titleView = titleLabel;
    
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
