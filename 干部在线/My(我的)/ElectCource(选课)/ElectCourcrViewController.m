//
//  ElectCourcrViewController.m
//  干部在线
//
//  Created by lixianjun on 15-1-9.
//  Copyright (c) 2015年 中青年. All rights reserved.
//

#import "ElectCourcrViewController.h"
#import "ImageDownManager.h"
#import "JSON.h"
#import "ElectCourceTableViewCell.h"
#import "ElectCoureView.h"
#import "ClassEveryViewController.h"
@interface ElectCourcrViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    //用来保存所有分类信息的数组
    NSMutableArray * _categoryArray;
    //用来显示分类信息的表格视图
    UITableView * _tableView;
    
    
}
@property (nonatomic, strong) ImageDownManager *mDownManager;
@property(nonatomic,strong)NSMutableArray *dataArray;

@end

@implementation ElectCourcrViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createNav];
    self.view.backgroundColor =[UIColor whiteColor];
    [self createTableView];
    [self loadData];
    // Do any additional setup after loading the view.
}
-(void)createNav
{
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
    titleLabel.text = @"课程列表";
    titleLabel.textColor =[UIColor whiteColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont boldSystemFontOfSize:20];
    self.navigationItem.titleView = titleLabel;
    //左侧按钮
    UIButton * leftButton = [MyContol createButtonWithFrame:CGRectMake(5, 15, 14, 22) ImageName:@"back.png" Target:self Action:@selector(numBerjectLeftClick) Title:nil];
    self.navigationItem.leftBarButtonItem =[[UIBarButtonItem alloc] initWithCustomView:leftButton];
}

-(void)numBerjectLeftClick
{
    if (self.myRecord ) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

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
    SAFE_CANCEL_ARC(self.mDownManager);
    
}
//
//-(void)createNav
//{
//    self.navigationController.navigationBar.translucent = NO;
//    //    self.title = @"我的首页";
//    
//    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 80, 44)];
//    titleLabel.text = @"课程列表";
//    self.navigationItem.titleView = titleLabel;
//    //左侧首页按钮
//    UIButton * leftButton = [MyContol createButtonWithFrame:CGRectMake(15, 15, 20, 20) ImageName:@"首页 拷贝.png" Target:self Action:@selector(ElectLeftClick) Title:nil];
//    self.navigationItem.leftBarButtonItem =[[UIBarButtonItem alloc] initWithCustomView:leftButton];
//}
-(void)ElectLeftClick
{
    NSLog(@"选课左侧按钮");
}
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
    vc.hidesBottomBarWhenPushed = YES;
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
