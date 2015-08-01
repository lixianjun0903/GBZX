//
//  TWOViewController.m
//  RatateTest
//
//  Created by caobo on 14-7-17.
//  Copyright (c) 2014年 caobo. All rights reserved.
//

#import "TWOViewController.h"
#import "ONEViewController.h"
@interface TWOViewController ()<UIWebViewDelegate>

{

    UIView * bgview;
    
    UIWebView * webView;
    UIActivityIndicatorView *activityIndicatorView;
}
@end

@implementation TWOViewController


-(void)viewWillAppear:(BOOL)animated
{
    
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)createButton
{
    self.view.backgroundColor =[UIColor whiteColor];
    
    webView = [[UIWebView alloc] initWithFrame:CGRectMake(0,20, HEIGHT,WIDETH)];
    
    webView.delegate = self;
    
    webView.scalesPageToFit = YES;
    
    [self.view addSubview:webView];
    
    activityIndicatorView = [[UIActivityIndicatorView alloc]
                             
                             initWithFrame : CGRectMake(0.0f, 0.0f, 52.0f, 52.0f)] ;
    
    [activityIndicatorView setCenter: webView.center] ;
    
    [activityIndicatorView setActivityIndicatorViewStyle: UIActivityIndicatorViewStyleGray] ;
    
    [self.view addSubview : activityIndicatorView] ;
    
    NSURL *url =[NSURL URLWithString:@"http://zqgbzx.cn:6060/jueding/html5.html"];
    
    NSURLRequest *request =[NSURLRequest requestWithURL:url];
    
    [webView loadRequest:request];
    
    UIButton * button =[[UIButton alloc] initWithFrame:CGRectMake(0, WIDETH - 80, 80, 80)];
    //   button.backgroundColor =[UIColor redColor];
    [button addTarget:self action:@selector(bb) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(8, 25, 20, 32)];
    imageView.image =[UIImage imageNamed:@"返回.png"];
    [button addSubview:imageView];
}
-(void)bb
{

    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
//    self.navigationController.navigationBarHidden = YES;

//    [UIViewController attemptRotationToDeviceOrientation];
//    self.view.backgroundColor = [UIColor whiteColor];
//    UILabel * ddd = [[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height)];
//    ddd.text = @"测试";
//    [self.view addSubview:ddd];
    activityIndicatorView = [[UIActivityIndicatorView alloc]
                             
                             initWithFrame : CGRectMake(0.0f, 0.0f, 32.0f, 32.0f)] ;
    
    [activityIndicatorView setCenter: self.view.center] ;
    [self createButton];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


- (BOOL)shouldAutorotate
{
    return NO;
}

-(UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{  bgview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, HEIGHT, 20)];
    bgview.backgroundColor =[UIColor blackColor];
    [self.view addSubview:bgview];
    return UIInterfaceOrientationLandscapeRight;
}

-(NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskLandscapeRight;
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

@end
