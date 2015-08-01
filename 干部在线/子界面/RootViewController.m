//
//  RootViewController.m
//  干部在线
//
//  Created by lixianjun on 15-1-12.
//  Copyright (c) 2015年 中青年. All rights reserved.
//

#import "RootViewController.h"
#import "NewViewController.h"
#import "HotViewViewController.h"
#import "RankViewController.h"
#import "PublicCoureceViewController.h"
#import "AppDelegate.h"
#import "YRSideViewController.h"
#import "MyViewController.h"
#import "ElectCourcrViewController.h"
#import "TitleChallengeViewController.h"
#import "StudyCenterViewController.h"
@interface RootViewController ()

{  UIImageView * bgView;
    UIScrollView * _SC;
    UIButton * button;
    UILabel * titleLable;
    NSMutableArray * tempArray;
    
}
@end

@implementation RootViewController

- (void)viewDidLoad {
    //self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"game_listview_background_imageview.png"]];
    // self.view.backgroundColor =[UIColor colorWithRed:0.92f green:0.92f blue:0.92f alpha:1.00f];
    bgView  = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, WIDETH, HEIGHT)];
    bgView.image  = [UIImage imageNamed:@"子界面bg2.png"];
    [self.view addSubview:bgView];
    //   self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg.png"]];
    //    [self createNav];
    
    //   [self createView];
    [self createSc];
    [self createViews];
    
    
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}


-(void)createViews
{
    //    NSArray * titleArray = @[@"首页",@"课程超市",@"答题挑战",@"学习中心",@"帮助中心",@"退出"];
    //
    //   NSArray * imageArray = @[@"首页测滑.png",@"专题培训测滑.png",@"侧滑页--最新.png",@"学习中心测滑.png",@"资讯测滑.png",@"退出测 滑.png"];
    NSArray * unselectImageArray = @[@"首页默认.png",@"课程超市默认.png",@"答题挑战默认.png",@"学习中心默认.png",@"帮助中心默认.png",@"退出默认.png"];
    NSArray * selectImageArray =@[@"首页选中.png",@"课程超市选中.png",@"答题挑战选中.png",@"学习中心选中.png",@"帮助中心选中.png",@"退出选中.png"];
    for (int i = 0; i < unselectImageArray.count; i ++) {
        button = [[UIButton alloc] initWithFrame:CGRectMake(30, 100+ 70*i, 166, 40)];
        [button setImage:[UIImage imageNamed:unselectImageArray[i]] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:selectImageArray[i]] forState:UIControlStateSelected ];
        button.tag = 10 + i;
        [button addTarget:self action:@selector(butonSelect:) forControlEvents:UIControlEventTouchUpInside];
        [_SC addSubview:button];
        
        //        [button setTitle:titleArray[i] forState:UIControlStateNormal];
        //     //给按钮添加文字
        //         titleLable = [MyContol createLabelWithFrame:CGRectMake(90, 0, 100, 40) Font:18 Text:titleArray[i]];
        //        titleLable.textColor = [UIColor whiteColor];
        //        titleLable.textAlignment = NSTextAlignmentCenter;
        //        [button addSubview:titleLable];
        
        //        [button setTitleColor:[UIColor blueColor] forState:UIControlStateSelected ];
        //        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        //        //给按钮添加图片
        //        UIImageView  * butotnImageView = [[UIImageView alloc] initWithFrame:CGRectMake(40, 5, 35, 35)];
        //        butotnImageView.image = [UIImage imageNamed:imageArray[i]];
        //        [button addSubview:butotnImageView];
    }
    _SC.contentSize = CGSizeMake(0, HEIGHT+0.3);
}
-(void)butonSelect:(UIButton*)sender
{
    //    float index = sender.tag - 10;
    
    for (UIView *view in _SC.subviews)
        
    {
        if ([view isKindOfClass:[UIButton class]]) {
            UIButton * btn = (UIButton*)view;
            btn.selected = NO;
        }
        sender.selected = YES;
        
    }
    
    
    switch (sender.tag)
    {
        case 10:{
            
            AppDelegate  * delete = (AppDelegate*)[[UIApplication sharedApplication] delegate];
            YRSideViewController *sideViewController = [delete sideViewController];
            [sideViewController hideSideViewController:true];
            
            NSLog(@"10 首页");
        }break;
            
        case 11:{
            NSLog(@"11 课程超市");

            ElectCourcrViewController * elect = [[ElectCourcrViewController alloc] init];
            UINavigationController * hotNc =[[UINavigationController alloc] initWithRootViewController:elect];
            elect.myRecord = @"qwdq";
            [self presentViewController:hotNc animated:YES completion:nil];
        }break;
            
        case 12:{
            NSLog(@"12 答题挑战");
//            PublicCoureceViewController * vc = [[PublicCoureceViewController alloc] init];
            TitleChallengeViewController * title =[[TitleChallengeViewController alloc] init];
            UINavigationController * publicNav = [[UINavigationController alloc] initWithRootViewController:title];
            [self presentViewController:publicNav animated:YES completion:nil];
            
        }break;
            
        case 13:{
            
            NSLog(@"13 学习中心");
            
//            RankViewController * rank =[RankViewController alloc];
            StudyCenterViewController * study =[[StudyCenterViewController alloc] init];
            UINavigationController * rankNav = [[UINavigationController alloc] initWithRootViewController:study];
            [self presentViewController:rankNav animated:YES completion:nil];        }break;
            
        case 14:{
            NSLog(@"14帮助中心");
                    MBProgressHUD* reginLoadView = [[MBProgressHUD alloc] initWithView:self.view];
                    [self.view addSubview:reginLoadView];
            
                    reginLoadView.mode = MBProgressHUDModeCustomView;
                    reginLoadView.labelText = @"无帮助";
                    [reginLoadView show:YES];
                    [reginLoadView hide:YES afterDelay:1];
                    reginLoadView = nil;

        }break;
          case 15:
        {
            NSArray * array = @[@"1"];
            NSLog(@"%@",array[1]);

            
        }
        default:
            break;
    }
}

-(void)createSc
{
    _SC = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, 250, HEIGHT )];
    //    _SC.backgroundColor = [UIColor colorWithRed:0.89f green:0.89f blue:0.89f alpha:1.00f];
    _SC.showsVerticalScrollIndicator = NO;
    _SC.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0];
    [self.view addSubview:_SC];
    
}
-(void)viewDidAppear:(BOOL)animated
{
    //隐藏导航
    //[self.navigationController setNavigationBarHidden:YES animated:YES];
    //self.navigationController.navigationBar.translucent = NO;
    
    
}
-(void)createNav
{
    //self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.93f green:0.65f blue:0.25f alpha:1.00f];
    //修改状态栏的颜色
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 20)];
    view.backgroundColor = [UIColor blackColor];
    [self.view addSubview:view];
    UIView * navView =[[UIView alloc] initWithFrame:CGRectMake(0, 20, WIDETH, 44)];
    navView.backgroundColor =[UIColor colorWithRed:0.19f green:0.51f blue:0.93f alpha:1.00f];
    [self.view addSubview:navView];
    UILabel * titleLabel =[[UILabel alloc] initWithFrame:CGRectMake(0, 0, WIDETH, 44)];
    titleLabel.text = @"我的首页";
    titleLabel.textColor =[UIColor whiteColor];
    titleLabel.font = [UIFont boldSystemFontOfSize:20];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [navView addSubview:titleLabel];
}
-(void)createView
{//最热
    UIView * hotBackGroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 65, 210, (HEIGHT-95)/11.0*3)];
    hotBackGroundView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:hotBackGroundView];
    
    
    //     NSArray * enterImagegeArray  = @[@"进入.jpg",@"进入.jpg",@"进入.jpg"];
    NSArray * hotTitleImageViewArrar = @[@"首页测滑.png",@"侧滑页--最新.png",@"最热测滑.png"];
    NSArray * hotTitleArray = @[@"首页",@"最新课程",@"最热课程"];
    for (int i = 0; i < hotTitleArray.count; i++) {
        UIButton * hotButton = [MyContol createButtonWithFrame:CGRectMake(0, 0+i *(HEIGHT-95)/11.0, 210,(HEIGHT-95)/11.0 ) ImageName:nil Target:self Action:@selector(hotButtonClick:) Title:nil];
        hotButton.tag = 10+i;
        //        hotButton.layer.borderWidth = 0.5;
        //        hotButton.layer.borderColor = [UIColor colorWithRed:0.84f green:0.84f blue:0.84f alpha:1.00f].CGColor;
        [hotButton setBackgroundImage:[UIImage imageNamed:@"子界面backGround.png"] forState:UIControlStateHighlighted];
        
        [hotBackGroundView addSubview:hotButton];
        
        //添加标题
        UILabel *  hotTitleLabel = [MyContol createLabelWithFrame:CGRectMake(45, 6,120 , 25) Font:15 Text:hotTitleArray[i]];
        hotTitleLabel.font = [UIFont boldSystemFontOfSize:16];
        [hotButton addSubview:hotTitleLabel];
        //添加头像图片
        UIImageView * hotTitleImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 6, 22, 22)];
        hotTitleImageView.image = [UIImage imageNamed:hotTitleImageViewArrar[i]];
        [hotButton addSubview:hotTitleImageView];
        //        //添加图片
        //        UIImageView * hotmageView = [[UIImageView alloc] initWithFrame:CGRectMake(190, 20, 10, 13)];
        //                [hotButton addSubview: hotmageView];
        //        hotmageView.image = [UIImage imageNamed:enterImagegeArray[i]];
    }
    
    
    //公开课
    UIView * publicBackGroundView = [[UIView alloc] initWithFrame:CGRectMake(0, (HEIGHT-95)/11.0*3+73, 210, (HEIGHT-95)/11.0*3)];
    
    NSArray * publicImageArray = @[@"选课测滑.png",@"公开课测滑.png",@"奖杯测动.png"];
    NSArray * publicTitleArray = @[@"精品专题",@"公开课",@"排行榜"];
    
    publicBackGroundView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:publicBackGroundView];
    for (int i = 0; i < 3; i++) {
        UIButton * publicButton = [MyContol createButtonWithFrame:CGRectMake(0, 0+i *(HEIGHT-95)/11.0, 210,(HEIGHT-95)/11.0 ) ImageName:nil Target:self Action:@selector(publicButtonClick:) Title:nil];
        
        publicButton.tag = 10+i;
        [publicButton setBackgroundImage:[UIImage imageNamed:@"子界面backGround.png"] forState:UIControlStateHighlighted];
        //        publicButton.layer.borderWidth = 0.5;
        //        publicButton.layer.borderColor = [UIColor colorWithRed:0.84f green:0.84f blue:0.84f alpha:1.00f].CGColor;
        [publicBackGroundView addSubview:publicButton];
        
        
        //添加标题
        UILabel *  publicTitleLabel = [MyContol createLabelWithFrame:CGRectMake(45, 6,120 , 25) Font:15 Text:publicTitleArray[i]];
        publicTitleLabel.font =[UIFont boldSystemFontOfSize:15];
        [publicButton addSubview:publicTitleLabel];
        //添加头像图片
        UIImageView * publictleTitleImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 6, 22, 22)];
        publictleTitleImageView.image = [UIImage imageNamed:publicImageArray[i]];
        // hotTitleImageView.backgroundColor = [UIColor blackColor];
        [publicButton addSubview:publictleTitleImageView];
        //        //添加图片
        //        UIImageView *  publicImageView = [[UIImageView alloc] initWithFrame:CGRectMake(190, 20, 10, 13)];
        //        [publicButton addSubview: publicImageView];
        //        publicImageView.image = [UIImage imageNamed:enterImagegeArray[i]];
    }
    
    
    
    
    //专题
    UIView *specialBackGroundView = [[UIView alloc] initWithFrame:CGRectMake(0, (HEIGHT-95)/11.0*6+84, 210, (HEIGHT-95)/11.0*3)];
    specialBackGroundView.backgroundColor = [UIColor whiteColor];
    
    NSArray * specialImageViewArray = @[@"专题培训测滑.png",@"学习资料测滑.png",@"资讯测滑.png"];
    NSArray * specialTitleArray = @[@"专题培训",@"学习资料",@"最新咨询"];
    
    [self.view addSubview:specialBackGroundView];
    for (int i = 0; i < 3; i++) {
        UIButton * specialButton = [MyContol createButtonWithFrame:CGRectMake(0, 0+i *(HEIGHT-95)/11.0, 210,(HEIGHT-95)/11.0 ) ImageName:nil Target:self Action:@selector(SpecialButtonClick:) Title:nil];
        //        specialButton.layer.borderWidth = 0.5;
        //        specialButton.layer.borderColor = [UIColor colorWithRed:0.84f green:0.84f blue:0.84f alpha:1.00f].CGColor;
        specialButton.tag = 10  + i;
        [specialButton setBackgroundImage:[UIImage imageNamed:@"子界面backGround.png"] forState:UIControlStateHighlighted];
        
        [specialBackGroundView addSubview:specialButton];
        
        //添加头像图片
        UIImageView * specialTitleImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 6, 22, 22)];
        specialTitleImageView.image = [UIImage imageNamed:specialImageViewArray[i]];
        [specialButton addSubview:specialTitleImageView];
        //添加标题
        UILabel * specialTitleLabel = [MyContol createLabelWithFrame:CGRectMake(45, 6,120 , 25) Font:15 Text:specialTitleArray[i]];
        specialTitleLabel.font = [UIFont boldSystemFontOfSize:15];
        [specialButton addSubview:specialTitleLabel];
        //        //添加图片
        //        UIImageView *  specialImageView = [[UIImageView alloc] initWithFrame:CGRectMake(190, 20, 10, 13)];
        //                [specialButton addSubview: specialImageView];
        //        specialImageView.image = [UIImage imageNamed:enterImagegeArray[i]];
        
    }
    
    
    
    //学习中心
    
    UIView * studyCenterBackGroundView = [[UIView alloc] initWithFrame:CGRectMake(0, (HEIGHT-95)/11.0*9+96, 210, (HEIGHT-95)/11.0*2)];
    studyCenterBackGroundView.backgroundColor  = [UIColor whiteColor];
    
    NSArray * studyCenterImageArray = @[@"学习中心测滑.png",@"退出测 滑.png"];
    NSArray * studyCenterTitleArray = @[@"学习中心",@"退出"];
    [self.view addSubview:studyCenterBackGroundView];
    for (int i = 0; i < 2; i++) {
        UIButton * studyCenterButton = [MyContol createButtonWithFrame:CGRectMake(0, 0+i *(HEIGHT-95)/11.0, 210,(HEIGHT-95)/11.0 ) ImageName:nil Target:self Action:@selector(studyButtonClick:) Title:nil];
        [studyCenterButton setBackgroundImage:[UIImage imageNamed:@"子界面backGround.png"] forState:UIControlStateHighlighted];
        //        studyCenterButton.layer.borderWidth = 0.5;
        //        studyCenterButton.layer.borderColor = [UIColor colorWithRed:0.84f green:0.84f blue:0.84f alpha:1.00f].CGColor;
        [studyCenterBackGroundView addSubview:studyCenterButton];
        
        //添加头像图片
        UIImageView * studyCenterTitleImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 6, 22, 22)];
        studyCenterTitleImageView.image = [UIImage imageNamed:studyCenterImageArray[i]];
        [studyCenterButton addSubview:studyCenterTitleImageView];
        //添加标题
        UILabel * studyCenterTitleLabel = [MyContol createLabelWithFrame:CGRectMake(45, 6,120 , 25) Font:15 Text:studyCenterTitleArray[i]];
        studyCenterTitleLabel.font =[UIFont boldSystemFontOfSize:15];
        [studyCenterButton addSubview:studyCenterTitleLabel];
        
        //        //添加图片
        //        UIImageView *  studyCenterImageView = [[UIImageView alloc] initWithFrame:CGRectMake(190, 20, 10, 13)];
        //        //hotmageView.backgroundColor = [UIColor redColor];
        //        [studyCenterButton addSubview: studyCenterImageView];
        //        studyCenterImageView.image = [UIImage imageNamed:enterImagegeArray[i]];
    }
}
#pragma mark 最新最热
-(void)hotButtonClick:(UIButton*)sender
{    if (sender.tag==11) {
    NewViewController * newVc = [[NewViewController alloc]init];
    UINavigationController * newNc =[[UINavigationController alloc]initWithRootViewController:newVc];
    [self presentViewController:newNc animated:YES completion:nil];
}
    if (sender.tag==12) {
        HotViewViewController * hotVc = [[HotViewViewController alloc] init];
        UINavigationController * hotNc =[[UINavigationController alloc] initWithRootViewController:hotVc];
        [self presentViewController:hotNc animated:YES completion:nil];
    }
    NSLog(@"最新最热");
    
}
#pragma mark 公开课
-(void)publicButtonClick:(UIButton*)sender
{
    switch (sender.tag ) {
        case 11:
        {
            
            PublicCoureceViewController * vc = [[PublicCoureceViewController alloc] init];
            UINavigationController * publicNav = [[UINavigationController alloc] initWithRootViewController:vc];
            [self presentViewController:publicNav animated:YES completion:nil];
        }
            break;
        case 12:
        {
            
            RankViewController * rank = [[RankViewController alloc] init];;
            UINavigationController * rankNav = [[UINavigationController alloc] initWithRootViewController:rank];
            [self presentViewController:rankNav animated:YES completion:nil];
        }
            break;
            
            
            
        default:
            break;
    }
    NSLog(@"公开课");
    
}
#pragma mark 专题
-(void)SpecialButtonClick:(UIButton*)sender
{
    NSLog(@"专题");
}
#pragma mark 学习中心
-(void)studyButtonClick:(UIButton*)sender
{
    
    NSLog(@"学习中心");
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*
 - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
 UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: forIndexPath:indexPath];
 
 // Configure the cell...
 
 return cell;
 }
 */

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 } else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
