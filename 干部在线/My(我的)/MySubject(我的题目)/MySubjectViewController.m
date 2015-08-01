//
//  MySubjectViewController.m
//  干部在线
//
//  Created by lixianjun on 15-3-11.
//  Copyright (c) 2015年 中青年. All rights reserved.
//

#import "MySubjectViewController.h"

@interface MySubjectViewController ()

@end

@implementation MySubjectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =[UIColor whiteColor];
    [self creteateNav];
    UILabel * lable =[[UILabel alloc] initWithFrame:CGRectMake(0, 100, WIDETH, 50)];
    lable.text = @"暂时无相关答题";
    lable.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:lable];
    // Do any additional setup after loading the view.
}
-(void)creteateNav
{
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 80, 44)];
    titleLabel.text = @"我的题目";
    titleLabel.textColor =[UIColor whiteColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont boldSystemFontOfSize:20];
    self.navigationItem.titleView = titleLabel;
    //修改状态栏的颜色
    if (iOS7) {
        [self.navigationController.navigationBar
         
         setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont boldSystemFontOfSize:20]}];
    }else{
        [self.navigationController.navigationBar setTitleTextAttributes:@{UITextAttributeTextColor: [UIColor whiteColor],UITextAttributeFont : [UIFont boldSystemFontOfSize:20]}];
    }
    //左侧首页按钮
    UIButton * leftButton = [MyContol createButtonWithFrame:CGRectMake(5, 15, 14, 22) ImageName:@"back.png" Target:self Action:@selector(MySubjectLeftClick) Title:nil];
    leftButton.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    self.navigationItem.leftBarButtonItem =[[UIBarButtonItem alloc] initWithCustomView:leftButton];
    }

-(void)MySubjectLeftClick
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
