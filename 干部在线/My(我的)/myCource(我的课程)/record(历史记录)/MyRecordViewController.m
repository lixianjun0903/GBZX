
//
//  MyRecordViewController.m
//  干部在线
//
//  Created by lixianjun on 15-1-9.
//  Copyright (c) 2015年 中青年. All rights reserved.
//

#import "MyRecordViewController.h"
#import "MyClassTableViewCell.h"
#import "LisenCourceViewController.h"
#import "JSON.h"
#import "ImageDownManager.h"
#import "MyClassModel.h"
#import "MyReordTableViewCell.h"
@interface MyRecordViewController ()<UITableViewDataSource,UITableViewDelegate>
{
  
//导航选项卡
    UIView  * botomView;
    UITableView * _tabelView;
    //更多年份选项
    UIButton * yearsButton ;
}
@property (nonatomic, strong) ImageDownManager *mDownManager;
@property(nonatomic,strong)NSMutableArray *dataArray;
@end

@implementation MyRecordViewController
@synthesize mLoadMsg;
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =[UIColor whiteColor];
    [self createNav];
    [self createTabelView];
    [self loadData];
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
}

-(void)dealloc
{
    self.mDownManager.delegate = nil;
}
#pragma merk 数据请求
-(void)loadData
{
    if (_mDownManager) {
        return;
    }
    if (mLoadView) {
        return;
    }
    mLoadView = [[MBProgressHUD alloc] initWithView:self.view];
    if (mLoadMsg) {
        mLoadView.mode = MBProgressHUDModeCustomView;
        mLoadView.labelText = @"正在加载";
    }
    [self.view addSubview:mLoadView];
    
    [mLoadView show:YES];
    
    [self StartLoading];
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    NSString *strID = [user objectForKey:@"sutdentId"];
    NSString * urlstr = [NSString stringWithFormat:@"%@api/student/getMyRequiredCourseList.json?studentId=%@",BASEURL,strID];
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
    NSArray *array= dict[@"data"];
    if (array&&[array isKindOfClass:[NSArray class]] &&array.count>0) {
        for (NSDictionary *dic in array) {
            MyClassModel * model = [[MyClassModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            [self.dataArray addObject:model];
        }
        [_tabelView reloadData];
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
    titleLabel.text = @"最近播放";
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
}
-(void)createTabelView{

    _tabelView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0 , WIDETH, HEIGHT-49-15) style:UITableViewStylePlain];
    _tabelView.delegate = self;
    _tabelView.dataSource=  self;
    _tabelView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    _tabelView.opaque = NO;
    [self.view addSubview:_tabelView];
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    MyReordTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ID"];
    if (!cell) {
        cell = [[MyReordTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ID"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    [cell myClassCofig:self.dataArray[indexPath.row]];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 110;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LisenCourceViewController * lisen =[[LisenCourceViewController alloc] init];
    MyClassModel * model =self.dataArray[indexPath.row];
    lisen.coureID = [NSString stringWithFormat:@"%@",model.courseId];
    lisen.courceTitle = model.title;
    [self.navigationController pushViewController:lisen animated:YES];

}
-(void)backClick
{
    [self.navigationController popViewControllerAnimated:YES];
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
