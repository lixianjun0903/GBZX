

//
//  SetingViewController.m
//  干部在线
//
//  Created by lixianjun on 15-1-9.
//  Copyright (c) 2015年 中青年. All rights reserved.
//

#import "SetingViewController.h"
//#import "MyViewController.h"
#import "YRSideViewController.h"
#import "AppDelegate.h"
#import "Adaptation.h"
@interface SetingViewController ()<UIAlertViewDelegate>

{
    
    
    UIScrollView * _Sc;
//屏幕的适配
    
    CGFloat height;
    //我的头像
   CGFloat headButtonHeight ;
    CGFloat headButtonWideth;
    CGFloat headButtonY;
    //通用设置VIEW
    CGFloat commentUseViewHeight;
    CGFloat commentUseViewY;
    //意见和反馈view
  CGFloat  ideaViewHeight;
  CGFloat  ideaViewY;
    //内存管理和应用view
  CGFloat  applyViewHeight;
  CGFloat  applyViewY;
    //退出设置
  CGFloat  outButtonHeight;
  CGFloat  outButtonY;

}
@end

@implementation SetingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createSc];
    //[self createTabelView];
    [self createNav];
   [self createView];

    // Do any additional setup after loading the view.
}
-(void)createSc
{
    _Sc = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, WIDETH, HEIGHT-64)];
    
    _Sc.showsVerticalScrollIndicator = NO;
   _Sc.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_Sc];
    

}
#pragma mark  我的设置
-(void)createView
{
     
//我的头像
    UIImageView * bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, WIDETH, 160)];
    bgImageView.image = [UIImage imageNamed:@"图层 30.png"];
    [_Sc addSubview:bgImageView];
    UIButton *  headButton  =[MyContol createButtonWithFrame:CGRectMake((bgImageView.frame.size.width - 40)/2,( bgImageView.frame.size.height - 40)/2, 50, 50) ImageName:@"yh_icon_头像.png" Target:self Action:@selector(headButtonCilck) Title:nil] ;
        [bgImageView addSubview:headButton];
////我的账号管理
//    UIView  *  acountView = [[UIView alloc] initWithFrame:CGRectMake(0, 170, WIDETH , 40)];
//    acountView.layer.borderWidth = 0.5;
//    acountView.layer.borderColor = [UIColor colorWithRed:0.84f green:0.84f blue:0.84f alpha:1.00f].CGColor;
//    [self.view addSubview:acountView];
//    UIButton * acountButon = [MyContol createButtonWithFrame:CGRectMake(0, 0, WIDETH, 40) ImageName:nil Target:nil Action:nil Title:nil];
//    [acountView addSubview:acountButon];
//    UILabel * accountLabel =[MyContol createLabelWithFrame:CGRectMake(20, 0, 120, 40) Font:16 Text:@"账号管理"];
//    [acountButon addSubview:accountLabel];
    //通用设置VIEW
    UIView * commentUseView =[[UIView alloc] initWithFrame:CGRectMake(0, 160, WIDETH, 130)];
    commentUseView.layer.borderWidth = 0.5;
    commentUseView.layer.borderColor = [UIColor colorWithRed:0.84f green:0.84f blue:0.84f alpha:1.00f].CGColor;
    [_Sc addSubview:commentUseView];
    //暗条1
    UIView * commentView1  = [[UIView alloc] initWithFrame:CGRectMake(45, commentUseView.frame.size.height/3*1, WIDETH-50, 0.5)];
    commentView1.backgroundColor = [UIColor colorWithRed:0.84f green:0.84f blue:0.84f alpha:1.00f];
    [commentUseView addSubview:commentView1];
    //暗条2
    UIView * commentView2  = [[UIView alloc] initWithFrame:CGRectMake(45, commentUseView.frame.size.height/3*2, WIDETH-50, 0.5)];
    commentView2.backgroundColor = [UIColor colorWithRed:0.84f green:0.84f blue:0.84f alpha:1.00f];
    [commentUseView addSubview:commentView2];

    NSArray *commentImageViewArray = @[@"提醒.png",@"通用设置.png",@"隐私.png"];
    NSArray * commentArray =@[@"提醒与通知",@"通用设置",@"隐私与安全"];
    for (int i = 0; i < commentArray.count; i++) {
        UIButton * commentButton =[MyContol createButtonWithFrame:CGRectMake(0, 0+i * commentUseView.frame.size.height/3, WIDETH,40) ImageName:nil Target:nil Action:nil Title:nil];
//        commentButton.layer.borderWidth =  0.5;
//        commentButton.layer.borderColor = [UIColor colorWithRed:0.84f green:0.84f blue:0.84f alpha:1.00f].CGColor;
        
        [commentUseView addSubview:commentButton];
        //相关图片
        UIImageView * commentImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 10, 25, 25)];
        commentImageView.image = [UIImage imageNamed:commentImageViewArray[i]];
        [commentButton addSubview:commentImageView];
        //相关文字
        UILabel * commentlabel = [MyContol createLabelWithFrame:CGRectMake(60, 0, 100, commentUseView.frame.size.height/3) Font:17 Text:commentArray[i]];
        commentlabel.textColor =  [UIColor colorWithRed:0.3 green:0.34 blue:0.3 alpha:1];
        [commentButton addSubview:commentlabel];
        // 对应的图标
        UIImageView *commentView = [[UIImageView alloc] initWithFrame:CGRectMake(WIDETH-20,  (commentUseView.frame.size.height/3 - 16)/2, 11, 15)];
        commentView.image =[UIImage imageNamed:@"进入.jpg"];
        [commentButton addSubview:commentView];
        
    }
    
    //意见和反馈view
    UIView * ideaView =[[UIView alloc] initWithFrame:CGRectMake(0, 305, WIDETH, 85)];
    ideaView.layer.borderWidth = 0.5;
    ideaView.layer.borderColor = [UIColor colorWithRed:0.84f green:0.84f blue:0.84f alpha:1.00f].CGColor;
    [_Sc addSubview:ideaView];
    //暗条
    UIView * ideaView1 =  [[UIView alloc] initWithFrame:CGRectMake(45, ideaView.frame.size.height/2*1, WIDETH - 50, 0.5)];
    ideaView1.backgroundColor =[UIColor colorWithRed:0.84f green:0.84f blue:0.84f alpha:1.00f];
    [ideaView addSubview:ideaView1];
    NSArray * ideaImageViewArray = @[@"意见反馈.png",@"关于.png"];
    NSArray * ideaAarray = @[@"意见反馈",@"关于"];
    for (int i = 0; i < ideaAarray.count; i++) {
        UIButton * ideaButton =[MyContol createButtonWithFrame:CGRectMake(0, 0+i  * ideaView.frame.size.height/2, WIDETH, ideaView.frame.size.height/2) ImageName:nil Target:nil Action:nil Title:nil];
        [ideaView addSubview:ideaButton];
//        ideaButton.layer.borderWidth =  0.5;
//        ideaButton.layer.borderColor = [UIColor colorWithRed:0.84f green:0.84f blue:0.84f alpha:1.00f].CGColor;
        //相关图片
        UIImageView * ideaImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 10, 25, 25 )];
        ideaImageView.image = [UIImage imageNamed:ideaImageViewArray[i]];
        [ideaButton addSubview:ideaImageView];
        //反馈的文字
        UILabel * ideaLabel = [MyContol createLabelWithFrame:CGRectMake(60, 0, 100, ideaView.frame.size.height/2*1) Font:17 Text:ideaAarray[i]];
        ideaLabel.textColor = [UIColor colorWithRed:0.3 green:0.34 blue:0.3 alpha:1];
        [ideaButton addSubview:ideaLabel];
        //对应图标
        UIImageView * idealImageView =[[UIImageView alloc] initWithFrame:CGRectMake(WIDETH -20, (ideaView.frame.size.height/2-16)/2, 11, 15)];
        idealImageView.image = [UIImage imageNamed:@"进入.jpg"];
        [ideaButton addSubview:idealImageView];
            }
    //内存管理和应用view
    UIView *applyView =[[UIView alloc] initWithFrame:CGRectMake(0, 405, WIDETH, 85)];
    applyView.layer.borderWidth = 0.5;
    applyView.layer.borderColor = [UIColor colorWithRed:0.84f green:0.84f blue:0.84f alpha:1.00f].CGColor;
    [_Sc addSubview:applyView];
    //暗条
    UIView * applyView1 =[[UIView alloc] initWithFrame:CGRectMake(45, applyView.frame.size.height/2*1, WIDETH - 50, 0.5)];
    applyView1.backgroundColor =[UIColor colorWithRed:0.84f green:0.84f blue:0.84f alpha:1.00f];
    [applyView addSubview:applyView1];
    NSArray * applyImageViewArray = @[@"应用中心.png",@"内存管理.png"];
    NSArray * applyArray = @[@"应用中心",@"内存管理"];
    for (int i = 0; i < applyArray.count; i++) {
        UIButton * applyButton = [MyContol createButtonWithFrame:CGRectMake(0, 0 +i* applyView.frame.size.height/2*1, WIDETH, applyView.frame.size.height/2*1) ImageName:nil Target:nil Action:nil Title:nil];
//        applyButton.layer.borderWidth =  0.5;
//        applyButton.layer.borderColor = [UIColor colorWithRed:0.84f green:0.84f blue:0.84f alpha:1.00f].CGColor;
        [applyView addSubview:applyButton];
        //相关图标
        UIImageView * applyImageViews = [[UIImageView alloc] initWithFrame:CGRectMake(20, 10, 25, 25)];
        applyImageViews.image = [UIImage imageNamed:applyImageViewArray[i]];
        [applyButton addSubview:applyImageViews];
        //相关文字
        UILabel *  applyLabel = [MyContol createLabelWithFrame:CGRectMake(60, 0, 100, applyView.frame.size.height/2) Font:17 Text:applyArray[i]];
        applyLabel.textColor =  [UIColor colorWithRed:0.3 green:0.34 blue:0.3 alpha:1];        [applyButton addSubview:applyLabel];
        //对应的图标
        UIImageView * applyImageView =[[UIImageView alloc] initWithFrame:CGRectMake(WIDETH - 20, (ideaView.frame.size.height/2-16)/2, 11, 15)];
        applyImageView.image =[UIImage imageNamed:@"进入.jpg"];
        [applyButton addSubview:applyImageView];
    }
    //退出设置
    UIButton * outButton = [MyContol createButtonWithFrame:CGRectMake(50,520 , WIDETH-100 , 40) ImageName:nil Target:self Action:@selector(outButotnCLick) Title:@"退出"];
    outButton.backgroundColor = [UIColor colorWithRed:0.19f green:0.51f blue:0.93f alpha:1.00f];
    [_Sc addSubview:outButton];
    _Sc.contentSize = CGSizeMake(WIDETH, 520+120);
        }
-(void)headButtonCilck
{
    NSLog(@"设置头像");
}
-(void)createNav

{self.view.backgroundColor =[UIColor grayColor];
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.19f green:0.51f blue:0.93f alpha:1.00f];
    //修改状态栏的颜色
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 20)];
    view.backgroundColor = [UIColor blackColor];
    [self.navigationController.view addSubview:view];
    //    UIApplication * app = [UIApplication sharedApplication];
    //    AppDelegate * delegate = (AppDelegate*)app.delegate;
    //   [delegate.window addSubview:view];
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 80, 44)];
    titleLabel.text = @"我的设置";
    titleLabel.textColor =[UIColor whiteColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont boldSystemFontOfSize:20];
    self.navigationItem.titleView = titleLabel;
    //左侧首页按钮
    UIButton * leftButton = [MyContol createButtonWithFrame:CGRectMake(5, 15, 14, 22) ImageName:@"登陆返回.png" Target:self Action:@selector(recenLeftClick) Title:nil];
    self.navigationItem.leftBarButtonItem =[[UIBarButtonItem alloc] initWithCustomView:leftButton];
}
-(void)recenLeftClick
{
    [self.navigationController popViewControllerAnimated:YES];
   
     NSLog(@"返回");
    
}
-(void)outButotnCLick
{
    
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"警告" message:@"确定退出" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alert.delegate = self;
    [alert show];
        //创建单列
//    UIApplication * app = [UIApplication sharedApplication];
//    //获得app的代理
//    AppDelegate * delegate = (AppDelegate *)app.delegate;
//    YRSideViewController* _sideViewController = delegate.sideViewController;
//   
//    if (!_sideViewController ) {
//        _sideViewController = [[YRSideViewController alloc] init];
//        delegate.window.rootViewController = _sideViewController;
//    }else
//    {
//        
//        delegate.window.rootViewController = _sideViewController;
//    }
//    
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        return;
    }
    else
    {
        NSUserDefaults * user =[NSUserDefaults standardUserDefaults];
        [user removeObjectForKey:@"j_password"];
        [user synchronize];
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
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
