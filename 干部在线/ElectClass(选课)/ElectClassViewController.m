//
//  ElectClassViewController.m
//  干部在线
//
//  Created by lixianjun on 14-12-29.
//  Copyright (c) 2014年 中青年. All rights reserved.
//

#import "ElectClassViewController.h"
#import "AppDelegate.h"
#import "ClassEveryViewController.h"
#import "ElectCourceTableViewCell.h"
#import "ElectCoureView.h"
#import "ImageDownManager.h"
#import "JSON.h"
#import "ElectCoureRequest.h"

@interface ElectClassViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    MBProgressHUD * mLoadView;

}
@property (nonatomic, strong) ImageDownManager *mDownManager;
@property(nonatomic,strong)NSMutableArray *dataArray;
@property (nonatomic,strong)AFRequestState * state;
@end


@implementation ElectClassViewController
@synthesize mLoadMsg;
- (void)viewDidLoad {
    [super viewDidLoad];
    [self createNav];
    self.view.backgroundColor = [UIColor whiteColor];
        [self createTableView];
        [self loadData];
        // Do any additional setup after loading the view.
}
//-(void)loadData
//{
//    
////    +(AFRequestState*)getElectCoureRequest:(void(^)(NSArray*electDic))succ
//        _state = [ElectCoureRequest getElectCoureRequest:^(NSArray *electDic) {
//
//    }];
//    _state= [ElectCoureRequest getElectCoureRequest:^(NSArray *electDic) {
//        <#code#>
//    }];
//}
//-(void)viewWillAppear:(BOOL)animated
//{
//    [super viewWillAppear:YES];
//    self.navigationController.navigationBar.translucent = NO;
//    //self.navigationController.navigationBar.barTintColor = [UIColor blackColor];
//    UIView * view1 =[[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDETH, 20)];
//    view1.backgroundColor =[UIColor blackColor];
//  //[self.navigationController.navigationBar addSubview:view1];
//    [self.navigationController.view addSubview:view1];
//    
//    //修改状态栏的颜色
//    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
//    
//    

//    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.10f green:0.47f blue:0.73f alpha:1.00f];
    //修改状态栏的颜色
//    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
//    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 20)];
//    view.backgroundColor = [UIColor blackColor];
//    UIApplication * app = [UIApplication sharedApplication];
//    AppDelegate * delegate = (AppDelegate*)app.delegate;
//    [delegate.window addSubview:view];
//}
-(void)dealloc
{
    self.mDownManager = nil;

}
-(void)loadData
{
    if (_mDownManager) {
        return;
    }
    
    [self StartLoading];
    mLoadView = [[MBProgressHUD alloc] initWithView:self.view];
    mLoadView.labelText = @"拼命加载中，请稍后";
    if (mLoadMsg) {
        mLoadView.mode = MBProgressHUDModeCustomView;
        
    }
    [self.view addSubview:mLoadView];
    
    [mLoadView show:YES];
    NSString * urlstr;
    
    urlstr = [NSString stringWithFormat:@"%@api/course/getCourseCategoryList.json",BASEURL];
    self.mDownManager = [[ImageDownManager alloc] init];
    _mDownManager.delegate = self;
    _mDownManager.OnImageDown = @selector(OnLoadFinish:);
    _mDownManager.OnImageFail = @selector(OnLoadFail:);
    [_mDownManager GetImageByStr:urlstr];
    
}
- (void)OnLoadFinish:(ImageDownManager *)sender
{
    self.dataArray = [NSMutableArray arrayWithCapacity:0];
    NSString *resStr = sender.mWebStr;
    NSDictionary *dict = [resStr JSONValue];
    [self Cancel];
    NSArray *array = dict[@"data"];
    if (array&&[array isKindOfClass:[NSArray class]] &&array.count>0)
    {
        [self.dataArray addObjectsFromArray:array];
            
        
        [_tableView reloadData];
        
    }
}

#pragma mark 开始下载
-(void)StartLoading
{
    
}
- (void)OnLoadFail:(ImageDownManager *)sender {
    [self Cancel];
}
- (void)Cancel {
    [mLoadView hide:YES];
    mLoadView = nil;
        SAFE_CANCEL_ARC(self.mDownManager);
    
}
//
-(void)createNav
{
    
//    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
//    
//    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.10f green:0.47f blue:0.73f alpha:1.00f];
//    
//    UIView * view1 =[[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDETH, 20)];
//    view1.backgroundColor =[UIColor blackColor];
//    //[self.navigationController.navigationBar addSubview:view1];
//    [self.navigationController.view addSubview:view1];

    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.19f green:0.51f blue:0.93f alpha:1.00f];
    self.navigationController.navigationBar.translucent = NO;
    //    self.title = @"我的首页";
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 80, 44)];
    titleLabel.text = @"课程列表";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font =[UIFont boldSystemFontOfSize:20];
    titleLabel.textColor =[UIColor whiteColor];
    self.navigationItem.titleView = titleLabel;
//    //左侧首页按钮
//    UIButton * leftButton = [MyContol createButtonWithFrame:CGRectMake(15, 15, 20, 20) ImageName:@"home_icon.png" Target:self Action:@selector(ElectLeftClick) Title:nil];
//    self.navigationItem.leftBarButtonItem =[[UIBarButtonItem alloc] initWithCustomView:leftButton];
}
//-(void)ElectLeftClick
//{
//    NSLog(@"选课左侧按钮");
//}
-(void)createTableView
{
    _tableView  = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDETH, HEIGHT-49-5) style:UITableViewStyleGrouped];
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.showsVerticalScrollIndicator= NO;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    //    _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    _tableView.backgroundColor =  [UIColor whiteColor];
    [self.view addSubview:_tableView];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataArray.count;
}



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return ((NSArray *)(self.dataArray[section][@"parentCategory"])).count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ElectCourceTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ID"];
    if (!cell) {
        cell = [[ElectCourceTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ID"];
        
    }
    
    NSDictionary * dic = self.dataArray[indexPath.section][@"parentCategory"][indexPath.row];
    [cell config:dic];
    
    
    return cell;
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    ElectCoureView * headView = [[ElectCoureView alloc] initWithFrame:CGRectMake(0, 0, WIDETH, 40)];
    NSDictionary * dic = self.dataArray[section];
    [headView config:dic];
    headView.backgroundColor = [UIColor colorWithRed:0.94f green:0.94f blue:0.94f alpha:1.00f];
    return headView;
}
//设置每一组的标题(一级分类名)

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.000000001;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ClassEveryViewController * vc = [[ClassEveryViewController alloc] init];
    vc.cagoryID = [NSString stringWithFormat:@"%@",self.dataArray[indexPath.section][@"parentCategory"][indexPath.row][@"childCategoryId"]];
  vc.title = self.dataArray[indexPath.section][@"parentCategory"][indexPath.row][@"childCategoryName"];
    vc.hidesBottomBarWhenPushed =  YES;
    [self.navigationController pushViewController:vc animated:YES];
    
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
