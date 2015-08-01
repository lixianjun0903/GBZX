//
//  StudyMeterialViewController.m
//  干部在线
//
//  Created by lixianjun on 14-12-29.
//  Copyright (c) 2014年 中青年. All rights reserved.
//

#import "StudyMeterialViewController.h"

@interface StudyMeterialViewController ()

@end

@implementation StudyMeterialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =[UIColor whiteColor];
    [self createNav];
    // Do any additional setup after loading the view.
}
-(void)createNav
{
    self.navigationController.navigationBar.translucent = NO;
    self.navigationItem.hidesBackButton = YES;
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 80, 44)];
    titleLabel.text = @"学习资料";
    titleLabel.textColor =[UIColor whiteColor];
    titleLabel.font = [UIFont boldSystemFontOfSize:22];
    self.navigationItem.titleView = titleLabel;
    //左侧首页按钮
    UIButton * leftButton = [MyContol createButtonWithFrame:CGRectMake(15, 15, 14, 22) ImageName:@"登陆返回.png" Target:self Action:@selector(meteriaLeftClick) Title:nil];
    leftButton.titleLabel.font =[UIFont boldSystemFontOfSize:18];
    self.navigationItem.leftBarButtonItem =[[UIBarButtonItem alloc] initWithCustomView:leftButton];

}
-(void)meteriaLeftClick
{
    [self.navigationController popViewControllerAnimated:YES];

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
