//
//  PublicHtlm5ViewController.m
//  干部在线
//
//  Created by lixianjun on 15-3-21.
//  Copyright (c) 2015年 中青年. All rights reserved.
//

#import "PublicHtlm5ViewController.h"

@interface PublicHtlm5ViewController ()<UIWebViewDelegate>

{
    UIWebView * webView;
    UIActivityIndicatorView *activityIndicatorView;
}
@end

@implementation PublicHtlm5ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createNav];
    self.view.backgroundColor =[UIColor whiteColor];
    webView = [[UIWebView alloc] initWithFrame:CGRectMake(0,0, WIDETH,320)];
    
    webView.delegate = self;
    
    webView.scalesPageToFit = YES;
    
    [self.view addSubview:webView];
    
    activityIndicatorView = [[UIActivityIndicatorView alloc]
                             
                             initWithFrame : CGRectMake(0.0f, 0.0f, 32.0f, 32.0f)] ;
    
    [activityIndicatorView setCenter: self.view.center] ;
    
    [activityIndicatorView setActivityIndicatorViewStyle: UIActivityIndicatorViewStyleGray] ;
    
    [self.view addSubview : activityIndicatorView] ;
    
    NSURL *url =[NSURL URLWithString:@"http://www.zqgbzx.cn:7070"];
    
    NSURLRequest *request =[NSURLRequest requestWithURL:url];
    
    [webView loadRequest:request];
    
    // Do any additional setup after loading the view.
}
-(void)createNav
{
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
