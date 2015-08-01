//
//  MyViewController.m
//  干部在线
//
//  Created by lixianjun on 14-12-29.
//  Copyright (c) 2014年 中青年. All rights reserved.
//

#import "MyViewController.h"
#import "AppDelegate.h"
#import "mainTabBarViewController.h"
#import "MBProgressHUD.h"
#import "ImageDownManager.h"
#import "JSON.h"
#import "MyStudyCenterViewController.h"
@interface MyViewController ()
{
    UITextField * countField;
    UITextField * secretField;
    
    MBProgressHUD *hud;
//屏幕适配
    CGFloat height;
    //账号密码bgview
    CGFloat bgViewY ;
    CGFloat bgViewHeight;
    //登陆
    CGFloat loginButtonY ;
    CGFloat loginButtonHeight;
}
@property(nonatomic,strong)ImageDownManager *mDownManager;
@end

@implementation MyViewController
-(void)viewWillAppear:(BOOL)animated
{


}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self createNav];
    [self createView];
    
    
// Do any additional setup after loading the view.
}
-(void)dealloc
{
[[NSNotificationCenter defaultCenter] removeObserver:self];
    _mDownManager.delegate = nil;
}
-(void)createUI
{
    if (is3_5Inch) {
        height = 480.0;
        //账号密码bgview
        bgViewY = 20;
        bgViewHeight = 80;
        //登陆
        loginButtonY = 120;
        loginButtonHeight = 40;
    }
    else if (is4Inch)
    {
        height = 568.0;
        //账号密码bgview
        bgViewY = 22;
        bgViewHeight = 90;
        //登陆
        loginButtonY = 130;
        loginButtonHeight =  45;
    }else if (is4_7Inch)
    {
        height = 667.0;
        //账号密码bgview
        bgViewY = 25;
        bgViewHeight = 100;
        //登陆
        loginButtonY = 160;
        loginButtonHeight = 50;
    }else if (is5_5Inch)
    {
    
        height= 736.0;
        //账号密码bgview
        bgViewY = 30;
        bgViewHeight = 100;
        //登陆
        loginButtonY = 180;
        loginButtonHeight = 50;
    }
}
-(void)createView
{
    [self createUI];
    UIView * bgView = [[UIView alloc] initWithFrame:CGRectMake(0, bgViewY, WIDETH, bgViewHeight)];
    bgView.layer.borderWidth = 0.5;
    bgView.layer.borderColor = [UIColor colorWithRed:0.53f green:0.53f blue:0.53f alpha:1.00f].CGColor;
    bgView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bgView];
    //添加背静暗条
    UIView * childrenView = [[UIView alloc] initWithFrame:CGRectMake(30, bgView.frame.size.height/2-0.3, WIDETH - 30, 0.5)];
    childrenView.backgroundColor = [UIColor colorWithRed:0.53f green:0.53f blue:0.53f alpha:1.00f];
    [bgView addSubview:childrenView];
    
    //账号
    UIView * countView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDETH-40, bgView.frame.size.height/2)];
//    countView.layer.borderWidth = 0.5;
//        countView.layer.borderColor = [UIColor colorWithRed:0.53f green:0.53f blue:0.53f alpha:1.00f].CGColor;
        countView.layer.masksToBounds = YES;
        [bgView addSubview:countView];
    
    UIImageView *countImgv= [[UIImageView alloc] initWithFrame:CGRectMake(15, (bgView.frame.size.height/2-24)/2, 24, 25)];
    countImgv.image = [UIImage imageNamed:@"newlogin_nickname_icon.png"];
    [countView addSubview:countImgv];
    countField = [[UITextField alloc] initWithFrame:CGRectMake(50, 0, WIDETH-100, bgView.frame.size.height/2)];
      countField.placeholder = @"请输入用户账号";
    countField.clearButtonMode = UITextFieldViewModeAlways;

    [countView addSubview:countField];


    //密码
    UIView * secretView =  [[UIView alloc] initWithFrame:CGRectMake(0, bgView.frame.size.height/2, WIDETH-40, bgView.frame.size.height/2)];
//    secretView.layer.borderWidth = 0.5;
//    secretView.layer.borderColor = [UIColor colorWithRed:0.53f green:0.53f blue:0.53f alpha:1.00f].CGColor;
    secretView.layer.masksToBounds = YES;
    [bgView addSubview:secretView];
    
    UIImageView *secretImgv= [[UIImageView alloc] initWithFrame:CGRectMake(15, (bgView.frame.size.height/2-24)/2, 25, 26)];
    secretImgv.image = [UIImage imageNamed:@"newlogin_password_icon.png"];
    
    [secretView addSubview:secretImgv];
    secretField = [[UITextField alloc] initWithFrame:CGRectMake(50, 0, WIDETH-100, bgView.frame.size.height/2)];
        secretField.placeholder = @"请输入账号密码";
        secretField.secureTextEntry = YES;
    secretField.clearButtonMode = UITextFieldViewModeAlways;
    [secretView addSubview:secretField];
    
      UIButton * loginButton = [MyContol createButtonWithFrame:CGRectMake(25 , loginButtonY, WIDETH - 50, loginButtonHeight) ImageName:nil Target:self Action:@selector(loginClick) Title:@"登录"];
    loginButton.backgroundColor = [UIColor colorWithRed:0.19f green:0.51f blue:0.93f alpha:1.00f];
    [self.view addSubview:loginButton];
   }
-(void)loginClick
{
    if (!hud) {
        hud= [[MBProgressHUD alloc]initWithView:self.view];
        hud.mode = MBProgressHUDModeCustomView;
        hud.dimBackground = YES;
        [self.view addSubview:hud];
    }
    if ([countField.text length]==0) {
        [hud show:YES];
        hud.labelText = @"用户名格式不正确";
        [hud hide:YES afterDelay:1];
        return;
    }
    else if ([secretField.text length]== 0)
    {
        [hud show:YES];
        hud.labelText =@"密码不能为空";
        [hud hide:YES afterDelay:1];
        return;
    }
   [self login];
//               [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(login:)name:@"NSNotificationCenterChage" object:nil];

}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:NO];
}
-(void)createNav
{
    self.navigationController.navigationBar.translucent = NO;
   UIView * navView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.height, 20)];
    navView.backgroundColor = [UIColor blackColor];
//    [self.navigationController.view addSubview:navView];
    UIApplication * app = [UIApplication sharedApplication];
    AppDelegate * delegate = (AppDelegate*)app.delegate;
    [delegate.window addSubview:navView];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.19f green:0.51f blue:0.93f alpha:1.00f];
    UILabel * label = [MyContol createLabelWithFrame:CGRectMake( WIDETH/2.0 - 80, 0, 160, 44) Font:20 Text:@"干部在线账号登录"];
    label.textColor =[UIColor whiteColor]
    ;
    self.navigationItem.titleView = label;
//    UIButton * leftButton = [MyContol createButtonWithFrame:CGRectMake(0, 10, 14, 22) ImageName:@"登陆返回.png" Target:self Action:@selector(leftClick) Title:nil];
//    self.navigationItem.leftBarButtonItem =[[UIBarButtonItem alloc] initWithCustomView:leftButton];
}
//-(void)leftClick
//{
//    NSLog(@"返回");
//}
#pragma mark   登录
-(void)login
//-(void)login: (NSNotification*) aNotification
{
    if (_mDownManager) {
        return;
    }
    NSString *urlstr = [NSString stringWithFormat:@"%@api/j_spring_security_check",BASEURL];
    self.mDownManager = [[ImageDownManager alloc] init];
    _mDownManager.delegate = self;
    _mDownManager.OnImageDown = @selector(OnLoadFinish:);
    _mDownManager.OnImageFail = @selector(OnLoadFail:);
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:0];
    [dic setObject:countField.text forKey:@"j_username"];
    [dic setObject:secretField.text forKey:@"j_password"];
    NSUserDefaults *  user = [NSUserDefaults standardUserDefaults];
    [user setObject:secretField.text forKey:@"j_password"];
    [user synchronize];
    [_mDownManager PostHttpRequest:urlstr :dic];
}
- (void)OnLoadFinish:(ImageDownManager *)sender
{
    NSString *resStr = sender.mWebStr;
    NSDictionary *dict = [resStr JSONValue];
    [self Cancel];
    
    if (dict && [dict isKindOfClass:[NSDictionary class]])
    {
        NSString *str = dict[@"error_code"];
        NSString * stre = [NSString stringWithFormat:@"%d",0];
       //str&&![str isEqualToString:@"0"]
        if (str&&![str isEqualToString:stre]) {
            [hud show:YES];
            hud.labelText = dict[@"msg"];
            [hud hide:YES afterDelay:1];
            return;
        }
        else
        {
            NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
            [user setObject:[NSString stringWithFormat:@"%@",dict[@"data"][@"sutdentId"]] forKey:@"sutdentId"];
            [user setObject:dict[@"data"][@"username"] forKey:@"username"];
            [user synchronize];
            
            if (self.electRecord) {
                [self.navigationController popViewControllerAnimated:YES];
            }
            else
            {
                MyStudyCenterViewController * MyStudyCenter = [[MyStudyCenterViewController alloc] init];
                [self.navigationController pushViewController:MyStudyCenter animated:YES];
            }
                        //创建单列
//        UIApplication * app = [UIApplication sharedApplication];
                           //获得app的代理
//        AppDelegate * delegate = (AppDelegate *)app.delegate;
//            mainTabBarViewController * mainVc = delegate.mainVC;
////            if (!mainVc) {
////                mainVc = [[mainTabBarViewController alloc] init];
////            }
//           mainVc = [[mainTabBarViewController alloc] init];
//
//           delegate.window.rootViewController = mainVc;
                   }
    }
 }
- (void)OnLoadFail:(ImageDownManager *)sender {
    [self Cancel];
}
- (void)Cancel {
    self.mDownManager.delegate = nil;
    SAFE_CANCEL_ARC(self.mDownManager);
}
//-(void)login: (NSNotification*) aNotification
//{
//    MyStudyCenterViewController * MyStudyCenter = [[MyStudyCenterViewController alloc] init];
//    [self.navigationController pushViewController:MyStudyCenter animated:YES];
//
//}
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
