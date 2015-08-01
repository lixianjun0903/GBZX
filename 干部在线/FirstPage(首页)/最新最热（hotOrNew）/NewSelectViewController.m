//
//  NewSelectViewController.m
//  干部在线
//
//  Created by lixianjun on 15-3-9.
//  Copyright (c) 2015年 中青年. All rights reserved.
//

#import "NewSelectViewController.h"

@interface NewSelectViewController ()

@end

@implementation NewSelectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =[UIColor whiteColor];
    [self cerateNav];
    // Do any additional setup after loading the view.
}
-(void)cerateNav
{
    self.title = @"最新";
    //修改状态栏的颜色
    if (iOS7) {
        [self.navigationController.navigationBar
         
         setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont boldSystemFontOfSize:20]}];
    }else{
        [self.navigationController.navigationBar setTitleTextAttributes:@{UITextAttributeTextColor: [UIColor whiteColor],UITextAttributeFont : [UIFont boldSystemFontOfSize:20]}];
    }
    //左侧首页按钮
    UIButton * leftButton = [MyContol createButtonWithFrame:CGRectMake(5, 15, 14, 22) ImageName:@"back.png" Target:self Action:@selector(NewLeftClick) Title:nil];
    leftButton.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    self.navigationItem.leftBarButtonItem =[[UIBarButtonItem alloc] initWithCustomView:leftButton];
}
-(void)NewLeftClick
{
    [self.navigationController popToRootViewControllerAnimated:YES];
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
