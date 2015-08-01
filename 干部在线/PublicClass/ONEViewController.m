//
//  ONEViewController.m
//  RatateTest
//
//  Created by caobo on 14-7-17.
//  Copyright (c) 2014年 caobo. All rights reserved.
//

#import "ONEViewController.h"
#import "TWOViewController.h"
#import "LisenLeftView.h"
#import "LisenRightView.h"

@interface ONEViewController ()<UIWebViewDelegate,UIScrollViewDelegate>

{//评论和推荐
    UIImageView * bottomLineView;
    UIImageView * topView;
    //scroView
    UIScrollView * mainSC;
    //左右view
    LisenLeftView * LeftView;
    LisenRightView * RightView;

    //webview
    UIWebView * webView;
    UIActivityIndicatorView *activityIndicatorView;
}
@end

@implementation ONEViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self createNav];
    [self createMainSC];
    //左侧右侧view
    [self createLeftView];
    [self createRightView];
    [self createCommentAndPushView];
    self.view.backgroundColor =[UIColor whiteColor];
    
    webView = [[UIWebView alloc] initWithFrame:CGRectMake(0,0, WIDETH,280)];
    
    webView.delegate = self;
    webView.scalesPageToFit = YES;
    [self.view addSubview:webView];
    
    activityIndicatorView = [[UIActivityIndicatorView alloc]
                             
                             initWithFrame : CGRectMake(0.0f, 0.0f, 32.0f, 32.0f)] ;
    
    [activityIndicatorView setCenter: webView.center] ;
//    [activityIndicatorView setFrame:CGRectMake((WIDETH - 10)/2, 270/2, 20, 20)];
    
    [activityIndicatorView setActivityIndicatorViewStyle: UIActivityIndicatorViewStyleGray] ;
    
    [self.view addSubview : activityIndicatorView] ;
    
    NSURL *url =[NSURL URLWithString:@"http://192.168.1.175:8080/jueding/test3.mp4"];
    
    NSURLRequest *request =[NSURLRequest requestWithURL:url];
    
    [webView loadRequest:request];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(100,282, 150, 40);
    [btn setTitle:@"点击横屏播放" forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor colorWithRed:0.19f green:0.51f blue:0.93f alpha:1.00f];
    [btn addTarget:self action:@selector(clickBtn) forControlEvents:UIControlEventTouchUpInside];
   
    [self.view addSubview:btn];
}
-(void)createCommentAndPushView{
    
    topView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 285+40, WIDETH, 50)];
    topView.image = [UIImage imageNamed:@""];
    //   topView.backgroundColor = [UIColor grayColor];
    topView.layer.borderWidth = 0.8;
    topView.layer.borderColor = [UIColor colorWithRed:0.84f green:0.84f blue:0.84f alpha:1.00f].CGColor;
    topView.userInteractionEnabled =YES;
    [self.view addSubview:topView];
    
    //评论
    UIButton * commentButton = [MyContol createButtonWithFrame:CGRectMake(0, 0, WIDETH/2.0, 50) ImageName:nil Target:self Action:@selector(commentClick:) Title:@"评论"];
    
    [commentButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [commentButton setTitleColor:[UIColor colorWithRed:0.10f green:0.30f blue:0.99f alpha:1.00f]forState:UIControlStateSelected];
    commentButton.tag = 10;
    commentButton.titleLabel.font = [UIFont systemFontOfSize:20];
    commentButton.selected =YES;
    [topView addSubview:commentButton];
    
    //相关推荐
    UIButton * pushButton = [MyContol createButtonWithFrame:CGRectMake(WIDETH/2.0, 0, WIDETH/2.0,50) ImageName:nil Target:self Action:@selector(commentClick:) Title:@"相关推荐"]
    ;
    [pushButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [pushButton setTitleColor:[UIColor colorWithRed:0.10f green:0.30f blue:0.99f alpha:1.00f]forState:UIControlStateSelected];
    pushButton.tag = 11;
    pushButton.titleLabel.font = [UIFont systemFontOfSize:20];
    pushButton.selected = NO;
    [topView addSubview:pushButton];
    bottomLineView = [MyContol createImageViewWithFrame:CGRectMake((WIDETH /2- 120)/2, 47, 120, 3) ImageName:@"矩形 10.png"];
    
    bottomLineView.tag = 100;
    [topView addSubview:bottomLineView];
}
-(void)commentClick:(UIButton*)sender
{
    float index = sender.tag - 10;
    NSLog(@"%f",index);
    UIButton * btn0 = (UIButton *)[topView viewWithTag:10];
    UIButton * btn1 = (UIButton*)[topView viewWithTag:11];
    NSArray * tempArray = @[btn0,btn1];
    
    for (UIButton * btn in tempArray) {
        if (btn.tag - 10 == index) {
            btn.selected = YES;
        }else
        {
            btn.selected = NO;
        }
    }
    UIImageView *bottomLineViews = (UIImageView*)[topView viewWithTag:100];
    [UIView animateWithDuration:0.3 animations:^{
        bottomLineViews.frame = CGRectMake(WIDETH/2 * index + (WIDETH/2 - 120)/2, 47, 120, 3);
        mainSC.contentOffset =CGPointMake(index*WIDETH, 0);
    }];
    
}

-(void)createMainSC
{
    mainSC = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 335+40, WIDETH, HEIGHT - 325-50)];
    
    mainSC.delegate  =self;
    //mainSC.backgroundColor = [UIColor greenColor];
    mainSC.showsHorizontalScrollIndicator = NO;
    mainSC.contentSize = CGSizeMake(WIDETH * 2, HEIGHT-335);
    mainSC.pagingEnabled = YES;
    [self.view addSubview:mainSC];
    
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGPoint point = scrollView.contentOffset;
    bottomLineView.frame = CGRectMake((WIDETH /2- 120)/2+point.x/2, 47, 120, 3);
    
    int index = (int)point.x/(WIDETH/2);
    UIButton * btn0 = (UIButton *)[topView viewWithTag:10];
    UIButton * btn1 = (UIButton*)[topView viewWithTag:11];
    if (index == 0) {
        btn0.selected = YES;
        btn1.selected = NO;
    }
    else if(index==2||index == 1)
    {
        btn0.selected = NO;
        btn1.selected = YES;
    }
    
    NSLog(@"%f~~~~%f",scrollView.contentOffset.x,scrollView.contentOffset.y);
}

-(void)createLeftView
{
    LeftView = [[LisenLeftView alloc] initWithFrame:CGRectMake(0, 0, WIDETH, mainSC.frame.size.height)];
    LeftView.backgroundColor = [UIColor redColor];
    [mainSC addSubview:LeftView];
    mainSC.contentSize = CGSizeMake(WIDETH * 2, HEIGHT-50- 335);
}
-(void)createRightView
{
    RightView = [[LisenRightView alloc] initWithFrame:CGRectMake(WIDETH, 0, WIDETH, mainSC.frame.size.height )];
    RightView.backgroundColor = [UIColor colorWithWhite:0.92 alpha:1];
    RightView.coureId = [NSString stringWithFormat:@"%d",989];
    [RightView loadData];
    [mainSC addSubview:RightView];
    mainSC.contentSize = CGSizeMake(WIDETH * 2, HEIGHT-335 -50);
    
}

-(void)createNav
{
    self.navigationController.navigationController.navigationBar.translucent = NO;
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 80, 44)];
    titleLabel.text = @"课件播放";
    titleLabel.textColor =[UIColor whiteColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont boldSystemFontOfSize:20];
    self.navigationItem.titleView = titleLabel;

    
    self.navigationController.navigationBar.translucent  =NO;
    UIButton * leftButton = [MyContol createButtonWithFrame:CGRectMake(15, 15, 14, 22) ImageName:@"back.png" Target:self Action:@selector(ElectLeftClick) Title:nil];
    leftButton.titleLabel.font =[UIFont boldSystemFontOfSize:18];
    self.navigationItem.leftBarButtonItem =[[UIBarButtonItem alloc] initWithCustomView:leftButton];
    
}
-(void)ElectLeftClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)webViewDidStartLoad:(UIWebView *)webView

{
    
    [activityIndicatorView startAnimating] ;
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView

{
    
    [activityIndicatorView stopAnimating];
    
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error

{
    
    UIAlertView *alterview = [[UIAlertView alloc] initWithTitle:@"" message:[error localizedDescription]  delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
    
    [alterview show];
    
    
}

-(void)clickBtn{
    TWOViewController *viewC = [[TWOViewController alloc]init];
//    [self.navigationController pushViewController:viewC animated:YES];
    [self presentViewController:viewC animated:YES completion:Nil];
    

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//-(NSUInteger)supportedInterfaceOrientations{
//    return UIInterfaceOrientationMaskPortrait;
//}
//
//- (BOOL)shouldAutorotate
//{
//    return NO;
//}

//-(UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
//{
//    return UIInterfaceOrientationPortrait;
//}




@end
