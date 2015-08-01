//
//  MyclassViewController.m
//  干部在线
//
//  Created by lixianjun on 15-1-9.
//  Copyright (c) 2015年 中青年. All rights reserved.
//

#import "MyclassViewController.h"
#import "MyClassTableViewCell.h"
#import "MyFileViewController.h"
#import "MyRecordViewController.h"
#import "AppDelegate.h"
#import "MyClassLeftView.h"
#import "MyClassMidelView.h"
#import "MyClassRightView.h"
#import "MainViewController.h"
#import "YRSideViewController.h"
@interface MyclassViewController ()<UIScrollViewDelegate>

{
    
    //选项卡底部view
    UIView * botomView;
    UIImageView * bottomLineView ;
    //移动的左右view
    UIScrollView * _mainSC;
    MyClassLeftView * _leftTabelView;
    MyClassMidelView *  _middleTabelView;
    MyClassRightView *_rightTabelView;
}
@end

@implementation MyclassViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor =[UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;
    
    [self createNav];
    [self createMainSC];
    //课程切换
    [self createBottomView];
    
    //tabelView
    [self createLeftTabelView];
    [self createMiddleTabelView];
    [self createRightTabelView];
        // Do any additional setup after loading the view.
}
#pragma mark 实现UISCro的协议
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{

    CGPoint point = scrollView.contentOffset;
    
  bottomLineView.frame = CGRectMake((WIDETH /2- WIDETH/4.0)/2+point.x/3.0-35, 47, (WIDETH-30)/3.0, 3);
    
    int index = (int)point.x/(WIDETH/2);
    NSLog(@"index=%d",index);
    UIButton * btn0 = (UIButton *)[botomView viewWithTag:10];
    UIButton * btn1 = (UIButton*)[botomView viewWithTag:11];
    UIButton * btn2 = (UIButton*)[botomView viewWithTag:12];
    if (index == 0) {
        btn0.selected = YES;
        btn1.selected = NO;
        btn2.selected = NO;
    }
    else if(index==2||index == 1)
    {
        btn0.selected = NO;
        btn1.selected = YES;
        btn2.selected = NO;
    }
   else if(index ==4||index==3)
    {
        btn0.selected = NO;
        btn1.selected = NO;
        btn2.selected = YES;
    }

   NSLog(@"%f~~~~%f",scrollView.contentOffset.x,scrollView.contentOffset.y);


}
#pragma mark 创建mainSC

-(void)createMainSC
{
    
    _mainSC =[[UIScrollView alloc] initWithFrame:CGRectMake(0, 50, WIDETH, HEIGHT-50-49)];
  
    _mainSC.delegate = self;
  _mainSC.showsHorizontalScrollIndicator =NO;
    _mainSC.pagingEnabled= YES;
   _mainSC.contentSize = CGSizeMake(WIDETH * 3, HEIGHT - 64 - 50 - 49);
    [self.view addSubview:_mainSC];
    }
#pragma mark 左边tabelView
-(void)createLeftTabelView
{
    _leftTabelView = [[MyClassLeftView alloc] initWithFrame:CGRectMake(0, 0, WIDETH, _mainSC.frame.size.height - 64 + 49)];
    [_leftTabelView loadData];
      [_mainSC addSubview:_leftTabelView];
    
}
#pragma mark中间tabelView
-(void)createMiddleTabelView
{
    _middleTabelView =[[MyClassMidelView alloc] initWithFrame:CGRectMake(WIDETH, 0, WIDETH, _mainSC.frame.size.height-64+49)];
    [_middleTabelView loadData];
    //_middleTabelView.backgroundColor =[UIColor redColor];
     [_mainSC addSubview:_middleTabelView];
    
    
}
#pragma mark 右边tabelView
-(void)createRightTabelView
{

    _rightTabelView =[[MyClassRightView alloc] initWithFrame:CGRectMake(WIDETH*2, 0, WIDETH, _mainSC.frame.size.height - 64+49) ];
    [_rightTabelView loadData];
      // _rightTabelView.backgroundColor =[UIColor purpleColor];
    [_mainSC addSubview:_rightTabelView];
   

}
//-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//    return 20;
//}
//-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    
//        MyClassTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ID"];
//        if (!cell) {
//            cell = [[MyClassTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ID"];
//            cell.selectionStyle =UITableViewCellSelectionStyleNone;
//
//           
//    }
//    return cell;
//    
//}
//
//-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//
//    return 130;
//    
//}
//
#pragma mark 课程切换
-(void)createBottomView
{
   botomView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDETH, 50)];
    //botomView.backgroundColor = [UIColor whiteColor];
    botomView.layer.borderWidth = 0.31;
    botomView.layer.borderColor = [UIColor colorWithRed:0.94f green:0.94f blue:0.94f alpha:1.00f].CGColor;
    [self.view addSubview:botomView];
    NSArray  * coureceElectLabel = @[@"必修课",@"选修课",@"已完成"];
    for (int i = 0; i < coureceElectLabel.count; i ++) {
        UIButton  * electButton = [MyContol createButtonWithFrame:CGRectMake(20 + WIDETH/3.0 * i, 15, WIDETH/3.0 - 30, 20) ImageName:nil Target:self Action:@selector(buttonClick:) Title:coureceElectLabel[i]];
        electButton.tag = 10+i;
        //正常的颜色
        [electButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        //选中的颜色
        [electButton setTitleColor:[UIColor blueColor] forState:UIControlStateSelected];
        //进来是否选中某个颜色
        if (i ==0) {
            electButton.selected = YES;
        }
        [botomView addSubview:electButton];
    }
     bottomLineView = [MyContol createImageViewWithFrame:CGRectMake(5, 47,(WIDETH-30)/3.0, 3) ImageName:@"矩形 10.png"];
    bottomLineView.tag = 100;
    [botomView addSubview:bottomLineView];
}
#pragma 选项卡
-(void)buttonClick:(UIButton*)sender
{
    float index = sender.tag - 10;
    
    for (UIView *view in botomView.subviews)
        
    {
        if ([view isKindOfClass:[UIButton class]]) {
            UIButton * btn = (UIButton*)view;
            btn.selected = NO;
        }
        sender.selected = YES;
        
    }
    UIImageView *bottomLineViews = (UIImageView*)[botomView viewWithTag:100];
    [UIView animateWithDuration:0.3 animations:^{
       // bottomLineView.frame = CGRectMake(2+100, 47,80, 3);
        bottomLineViews.frame = CGRectMake(5 + WIDETH/3.0*index, 47,( WIDETH-30)/3.0, 3);
        _mainSC.contentOffset = CGPointMake(index* WIDETH, 0);
    }];
    
    if (index == 0) {
        NSLog(@"必修课");
    }
    if (index == 1) {
        NSLog(@"选修课");
    }
    if (index ==2) {
        NSLog(@"已完成");
    }
   }

-(void)createNav
{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 20)];
    view.backgroundColor = [UIColor blackColor];
   [self.navigationController.view addSubview:view];
//    UIApplication * app = [UIApplication sharedApplication];
//    AppDelegate * delegate = (AppDelegate*)app.delegate;
//    [delegate.window addSubview:view];
    //修改导航的颜色
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.19f green:0.51f blue:0.93f alpha:1.00f];
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 80, 44)];
    titleLabel.text = @"我的课程";
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont boldSystemFontOfSize:20];
    self.navigationItem.titleView = titleLabel;
    //修改导航的颜色
    self.navigationController.navigationBar.backgroundColor = [UIColor purpleColor];
//    //我的归档和记录view
//    UIView  * fileAndRecord  = [[UIView alloc] initWithFrame:CGRectMake(0, 20, WIDETH / 4.0, 44)];
//  //fileAndRecord.backgroundColor =  [UIColor colorWithRed:0.84f green:0.84f blue:0.84f alpha:1.00f];
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:fileAndRecord];
//    //归档
//    UIButton * fileButton =[MyContol createButtonWithFrame:CGRectMake(10, 15, fileAndRecord.frame.size.width/ 2.0 - 20, 17) ImageName:@"归档课程--图标.png"Target:self Action:@selector(fileButtonClick) Title:nil];
//        [fileAndRecord addSubview:fileButton];
//        UIButton *recordButton = [MyContol createButtonWithFrame:CGRectMake(fileAndRecord.frame.size.width / 2.0+ 10, 15, fileAndRecord.frame.size.width / 2.0 - 20, 17) ImageName:@"历史记录--图标.png" Target:self Action:@selector(recordButtonClick) Title:nil];
//    [fileAndRecord addSubview:recordButton];
//    //我的首页
//    UIButton * leftButton = [MyContol createButtonWithFrame:CGRectMake(10, 10, 40, 40) ImageName:nil Target:self Action:@selector(leftButton) Title:@"首页"];
//    leftButton.titleLabel.font =[UIFont boldSystemFontOfSize:19];
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    //左侧首页按钮
    UIButton * leftButton = [MyContol createButtonWithFrame:CGRectMake(5, 15, 14, 22) ImageName:@"back.png" Target:self Action:@selector(MyClassLeftClick) Title:nil];
    leftButton.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    self.navigationItem.leftBarButtonItem =[[UIBarButtonItem alloc] initWithCustomView:leftButton];
}
-(void)MyClassLeftClick
{
    [self.navigationController popViewControllerAnimated:YES];
}
//-(void)leftButton
//{
//    //创建单列
//    UIApplication * app = [UIApplication sharedApplication];
//    //获得app的代理
//    AppDelegate * delegate = (AppDelegate *)app.delegate;
////    YRSideViewController * mainVc = delegate.sideViewController;
//    MainViewController *  mainVc = [[MainViewController alloc] init];
//    
//    delegate.window.rootViewController = mainVc;
//}
//#pragma mark 我的归档
//-(void)fileButtonClick
//{
//    NSLog(@"我的归档");
//    MyFileViewController * file = [[MyFileViewController alloc] init];
//    
//    [self.navigationController pushViewController:file animated:YES];
//    
//}
//#pragma mark  我的记录
//-(void)recordButtonClick
//{
//    NSLog(@"最近播放");
//    MyRecordViewController * record = [[MyRecordViewController alloc] init];
//    [self.navigationController pushViewController:record animated:YES];
//
//}
//
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
