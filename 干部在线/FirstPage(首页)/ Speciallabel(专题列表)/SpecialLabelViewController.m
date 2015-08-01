

//
//  SpecialLabelViewController.m
//  干部在线
//
//  Created by lixianjun on 15-1-2.
//  Copyright (c) 2015年 中青年. All rights reserved.
//

#import "SpecialLabelViewController.h"
#import "SpecialTitleListView.h"
#import "JSON.h"
#import "ImageDownManager.h"

@interface SpecialLabelViewController ()

{
//SCRO
    UIScrollView * _Scro;
}
@property (nonatomic, strong) ImageDownManager *mDownManager;
@property(nonatomic,strong)NSDictionary * dic;
@end

@implementation SpecialLabelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:0.89f green:0.89f blue:0.89f alpha:1.00f];
    [self createNav];
    [self createView];
    [self loadData];
    // Do any additional setup after loading the view.
}
-(void)createNav
{
    //标题
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 80, 44)];
    titleLabel.text = @"专题列表";
    titleLabel.textColor =[UIColor whiteColor];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont systemFontOfSize:20];
    self.navigationItem.titleView = titleLabel;
    UIButton * leftButton = [MyContol createButtonWithFrame:CGRectMake(15, 15, 40, 20) ImageName:nil Target:self Action:@selector(topicListButton) Title:@"返回"];
    self.navigationItem.leftBarButtonItem =[[UIBarButtonItem alloc] initWithCustomView:leftButton];
    
}
#pragma mark  返回
-(void)topicListButton
{
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}
-(void)dealloc
{
    _mDownManager.delegate = nil;
}
-(void)loadData
{
    if (_mDownManager) {
        return;
    }
    
    [self StartLoading];
    NSString * urlstr;
    
        urlstr = [NSString stringWithFormat:@"%@api/course/getCourseListByHot.json",BASEURL];
     self.mDownManager = [[ImageDownManager alloc] init];
    _mDownManager.delegate = self;
    _mDownManager.OnImageDown = @selector(OnLoadFinish:);
    _mDownManager.OnImageFail = @selector(OnLoadFail:);
    [_mDownManager GetImageByStr:urlstr];
    
}
- (void)OnLoadFinish:(ImageDownManager *)sender
{
    NSString *resStr = sender.mWebStr;
    NSDictionary *dict = [resStr JSONValue];
    [self Cancel];
    NSDictionary *d = dict[@"data"];
    NSArray *array = d[@"data"];
    if (array&&[array isKindOfClass:[NSArray class]] &&array.count>0) {
        for (NSDictionary *dic in array) {
            
        }
        [self refresh];
    }
}
-(void)refresh
{

    SpecialTitleListView * special = [[SpecialTitleListView alloc] init];
    [special config:self.dic];
}
#pragma mark 开始下载
-(void)StartLoading
{
    
}
- (void)OnLoadFail:(ImageDownManager *)sender {
    [self Cancel];
}
- (void)Cancel {
    //[self StopLoading];
    SAFE_CANCEL_ARC(self.mDownManager);
    
}
-(void)createView
{
    _Scro  = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, WIDETH, HEIGHT - 64)];
    [self.view addSubview:_Scro];
    
    for (int i = 0; i < 10; i ++) {
        SpecialTitleListView * SpecialView = [[SpecialTitleListView alloc] initWithFrame:CGRectMake(0, 380* i, WIDETH, 360)];
      SpecialView.backgroundColor = [UIColor whiteColor];
        SpecialView.delegate =self;
        [_Scro addSubview:SpecialView];
     
    }
    _Scro.contentSize = CGSizeMake(WIDETH, 10 *250 );
    

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    self.view.backgroundColor =[UIColor whiteColor];
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
