//
//  MyStudyCenterViewController.m
//  干部在线
//
//  Created by lixianjun on 15-3-11.
//  Copyright (c) 2015年 中青年. All rights reserved.
//

#import "MyStudyCenterViewController.h"
#import "StatictisViewController.h"
#import "SetingViewController.h"
#import "MyclassViewController.h"
#import "MyRecordViewController.h"
#import "MySubjectViewController.h"
@interface MyStudyCenterViewController ()
{
    UIScrollView * _Sc;
}
@end

@implementation MyStudyCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =[UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;
    [self createNav];
    [self createSC];
    [self createView];
    // Do any additional setup after loading the view.
}
-(void)createView
{
// 头像
    UIImageView * bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, WIDETH, 160)];
    bgImageView.image =[UIImage imageNamed:@"图层 30.png"];
   [_Sc addSubview:bgImageView];
UIImageView * headImageView = [[UIImageView alloc] initWithFrame:CGRectMake((bgImageView.frame.size.width - 40)/2,( bgImageView.frame.size.height - 40)/2, 50, 50)];
     headImageView.image = [UIImage imageNamed:@"yh_icon_头像.png"];
    [bgImageView addSubview:headImageView];
    //push箭头
    NSArray * pushArray = @[@"进入.jpg",@"进入.jpg"];
    //我的课程
    UIView * bgMyClassView = [[UIView alloc] initWithFrame:CGRectMake(0, 160, WIDETH, 80)];
    bgMyClassView.layer.borderWidth = 0.5;
    bgMyClassView.layer.borderColor =[UIColor colorWithRed:0.84f green:0.84f blue:0.84f alpha:1.00f].CGColor;
    bgMyClassView.backgroundColor =[UIColor whiteColor];
    [_Sc addSubview:bgMyClassView];
    //添加背景暗条
    UIView * classView =[[UIView alloc] initWithFrame:CGRectMake(45, bgMyClassView.frame.size.height/2-0.2, WIDETH-50, 0.5)];
    classView.backgroundColor =[UIColor colorWithRed:0.84f green:0.84f blue:0.84f alpha:1.00f];
    [bgMyClassView addSubview:classView];
    NSArray  * myclassTitleArray = @[@"我的课程",@"最近播放"];
    NSArray * myVClassImageView = @[@"yidong-xlg_03(1).png",@"yidong-xlg_06.png"];
    for (int i  = 0; i < myclassTitleArray.count; i++) {
        
        UIButton * myClassButton = [[UIButton alloc] initWithFrame:CGRectMake(0, bgMyClassView.frame.size.height/2 *i, WIDETH, bgMyClassView.frame.size.height/2)];
        myClassButton.tag = 10 +i;
        [myClassButton addTarget:self action:@selector(myClassButton:) forControlEvents:UIControlEventTouchUpInside];
        [bgMyClassView addSubview:myClassButton];
        //添加图片
        UIImageView * myCalssImageView =[[UIImageView alloc] initWithFrame:CGRectMake(20, 5, 25, 25)];
        myCalssImageView.image = [UIImage imageNamed:myVClassImageView[i]];
        [myClassButton addSubview:myCalssImageView];
        //添加文字
        UILabel * myClassLable = [[UILabel alloc] initWithFrame:CGRectMake(60, 7, 100, 20)];
        myClassLable.font =[UIFont systemFontOfSize:17];
        myClassLable.text = myclassTitleArray[i];
        [myClassButton addSubview:myClassLable];
        //添加导向箭头
        UIImageView * myClassPushImageView =[[UIImageView alloc] initWithFrame:CGRectMake(WIDETH-15, 13, 11, 15)];
        myClassPushImageView.image =[UIImage  imageNamed:pushArray[i]];
        [myClassButton addSubview:myClassPushImageView];
        
    }
    //我的题目
   UIView * bgMySubjectView =[[UIView alloc] initWithFrame:CGRectMake(0, 260, WIDETH, 80)];
    bgMySubjectView.backgroundColor =[UIColor whiteColor];
    bgMySubjectView.layer.borderWidth = 0.5;
    bgMySubjectView.layer.borderColor =[UIColor colorWithRed:0.84f green:0.84f blue:0.84f alpha:1.00f].CGColor;
    [_Sc addSubview:bgMySubjectView];
    //添加背景暗条
    UIView * subjectView =[[UIView alloc] initWithFrame:CGRectMake(45, bgMySubjectView.frame.size.height/2-0.2, WIDETH-50, 0.5)];
    subjectView.backgroundColor = [UIColor colorWithRed:0.84f green:0.84f blue:0.84f alpha:1.00f];
    [bgMySubjectView addSubview:subjectView];
    NSArray * mySubjectArray = @[@"我的题目",@"学习统计"];
    NSArray * mySujectImageArray = @[@"yidong-xlg_08.png",@"yidong-xlg_10.png"];
    for (int i = 0 ; i < mySubjectArray.count; i++) {
        UIButton   * mySubjectButton =[[UIButton alloc] initWithFrame:CGRectMake(0, 0+ bgMySubjectView.frame.size.height/2*i, WIDETH, bgMySubjectView.frame.size.height/2)];
        [mySubjectButton addTarget:self action:@selector(mySubjectButton:) forControlEvents:UIControlEventTouchUpInside];
        mySubjectButton.tag = 10 + i;
        [bgMySubjectView addSubview:mySubjectButton];
        //添加图片
        UIImageView * mySubjectImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 5, 25, 25)];
        mySubjectImageView.image  =[UIImage imageNamed:mySujectImageArray[i]];
        [mySubjectButton addSubview:mySubjectImageView];
        //添加文字
        UILabel * mySubjectLale =[[UILabel alloc] initWithFrame:CGRectMake(60, 7, 100, 20)];
        mySubjectLale.text = mySubjectArray[i];
        mySubjectLale.font =[UIFont systemFontOfSize:17];
        [mySubjectButton addSubview:mySubjectLale];
        //添加push箭头
        UIImageView *mySubjectPushImageView =[[UIImageView alloc] initWithFrame:CGRectMake(WIDETH-15, 13, 11, 15)];
        mySubjectPushImageView.image =[UIImage imageNamed:pushArray[i]];
        [mySubjectButton addSubview:mySubjectPushImageView];
    }
    
//   设置
    
    UIView * bgSetView =[[UIView alloc] initWithFrame:CGRectMake(0, 360, WIDETH, 40)];
    bgSetView.layer.borderWidth = 0.5;
    bgSetView.layer.borderColor =[UIColor colorWithRed:0.84f green:0.84f blue:0.84f alpha:1.00f].CGColor;
    bgSetView.backgroundColor = [UIColor whiteColor];
    [_Sc addSubview:bgSetView];
    //添加按钮
    UIButton * setButton =[[UIButton alloc] initWithFrame:CGRectMake(0, 0, WIDETH, 40)];
    [setButton addTarget:self action:@selector(setButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [bgSetView addSubview:setButton ];
    //添加图片
    UIImageView * setImageView =[[UIImageView alloc] initWithFrame:CGRectMake(20, 5, 25, 25)];
    setImageView.image = [UIImage imageNamed:@"yidong-xlg_12.png"];
    [setButton addSubview:setImageView];
    //添加文字
    UILabel *  setLable = [[UILabel alloc] initWithFrame:CGRectMake(60, 7, 100, 20)];
    setLable.text = @"设置";
    setLable.font =[UIFont systemFontOfSize:17];
    [setButton addSubview:setLable];
    
    //添加push箭头
    UIImageView * setPushImageView = [[UIImageView alloc] initWithFrame:CGRectMake(WIDETH-20, 13, 11, 15)];
    setPushImageView.image =[UIImage imageNamed:@"进入.jpg"];
    [setButton addSubview:setPushImageView];
    
    _Sc.contentSize = CGSizeMake(WIDETH, HEIGHT -64+1);
}
#pragma mark 设置
-(void)setButtonClick
{
    NSLog(@"我的设置");
    SetingViewController * mySet = [[SetingViewController alloc]init];
    mySet.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:mySet animated:YES];
    


}
#pragma mark 我的课程
-(void)myClassButton:(UIButton*)sender
{
    switch (sender.tag) {
        case 10:
        {
            MyclassViewController * Myclass = [[MyclassViewController alloc] init];
          Myclass.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:Myclass animated:YES];
            NSLog(@"我的课程");
        }
            break;
        case 11:
        {
            MyRecordViewController * Myrecord = [[MyRecordViewController alloc] init];
            Myrecord.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:Myrecord animated:YES];
            NSLog(@"最近播放");
        }
            break;
        default:
            break;
    }

}
#pragma mark 我的题目
-(void)mySubjectButton:(UIButton*)senser
{
    switch (senser.tag) {
        case 10:
        {
            NSLog(@"我的题目");
            MySubjectViewController * mySubject  = [[MySubjectViewController alloc] init];
            mySubject.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:mySubject animated:YES];
        }
            break;
        case 11:
        {
            NSLog(@"我的统计");
            StatictisViewController * statics = [[StatictisViewController alloc] init];
            statics.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:statics animated:YES];
        }
            break;
 
        default:
            break;
    }

}
//-(void)buttonClick:(UIButton*)sender
//{
//
//    switch (sender.tag) {
//        case 10:
//        {MyclassViewController * my = [[MyclassViewController alloc] init];
//            [self.navigationController pushViewController:my animated:YES];
//            NSLog(@"我的课程");
//        }
//            break;
//        case 11:
//        {
//            MyRecordViewController * Myrecord = [[MyRecordViewController alloc] init];
//            [self.navigationController pushViewController:Myrecord animated:YES];
//            NSLog(@"最近播放");
//        }
//            break;
//        case 12:
//        {
//            NSLog(@"我的题目");
//            MySubjectViewController * mySubject  = [[MySubjectViewController alloc] init];
//            [self.navigationController pushViewController:mySubject animated:YES];
//            
//        }
//            break;
//        case 13:
//        {
//            NSLog(@"我的统计");
//            StatictisViewController * statics = [[StatictisViewController alloc] init];
//            [self.navigationController pushViewController:statics animated:YES];
//                    }
//            break;
//            case 14:
//        {
//            NSLog(@"我的设置");
//            SetingViewController * mySet = [[SetingViewController alloc]init];
//            [self.navigationController pushViewController:mySet animated:YES];
//
//        }
//            break;
//            
//        default:
//            break;
//    }
//}
-(void)createSC
{
    _Sc =[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, WIDETH, HEIGHT - 49)];
   _Sc.backgroundColor = [UIColor colorWithRed:0.96f green:0.96f blue:0.96f alpha:1];
    _Sc.showsVerticalScrollIndicator =NO;
    [self.view addSubview:_Sc];

}
-(void)createNav
{

   self.title = @"我的学习中心";
    if (iOS7) {
        [self.navigationController.navigationBar
         
         setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont boldSystemFontOfSize:19]}];
    }else{
        [self.navigationController.navigationBar setTitleTextAttributes:@{UITextAttributeTextColor: [UIColor whiteColor],UITextAttributeFont : [UIFont boldSystemFontOfSize:19]}];
    }
    
    //左侧首页按钮
    UIButton * leftButton = [MyContol createButtonWithFrame:CGRectMake(5, 15, 14, 22) ImageName:nil Target:self Action:@selector(MyLeftClick) Title:nil];
    leftButton.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    self.navigationItem.leftBarButtonItem =[[UIBarButtonItem alloc] initWithCustomView:leftButton];
}
-(void)MyLeftClick
{
//    [self.navigationController popToRootViewControllerAnimated:YES];
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
