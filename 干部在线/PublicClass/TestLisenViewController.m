


//
//  TestLisenViewController.m
//  干部在线
//
//  Created by lixianjun on 15-3-21.
//  Copyright (c) 2015年 中青年. All rights reserved.
//

#import "TestLisenViewController.h"

@interface TestLisenViewController ()
{

}
@property (nonatomic,assign) BOOL m_bScreen;
@end

@implementation TestLisenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self createNav];
    // Do any additional setup after loading the view.
}
-(void)createNav
{

    UIButton * leftButton = [MyContol createButtonWithFrame:CGRectMake(10, 15, 14, 22) ImageName:@"back.png" Target:self Action:@selector(publicLeftClick) Title:nil];
    leftButton.titleLabel.font =[UIFont boldSystemFontOfSize:18];
    self.navigationItem.leftBarButtonItem =[[UIBarButtonItem alloc] initWithCustomView:leftButton];
    
}


#pragma mark  返回
-(void)publicLeftClick
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
