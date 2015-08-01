//
//  HotSelectViewController.m
//  干部在线
//
//  Created by lixianjun on 15-3-9.
//  Copyright (c) 2015年 中青年. All rights reserved.
//

#import "HotSelectViewController.h"
#import "JSON.h"
#import "ImageDownManager.h"
#import "HotSelecModel.h"
#import "HotSelectTableViewCell.h"
@interface HotSelectViewController ()<UITableViewDataSource,UITableViewDelegate,MBProgressHUDDelegate>

{   MBProgressHUD * mLoadView;
    UITableView  * _tableView;
}
@property (nonatomic, strong) ImageDownManager *mDownManager;
@property(nonatomic,strong)NSMutableArray *dataArray;

@end

@implementation HotSelectViewController
@synthesize mLoadMsg;
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =[UIColor whiteColor];
    self.dataArray =[NSMutableArray arrayWithCapacity:0];
//    self.navigationController.navigationBar.translucent = NO;
    [self createNav];
    [self createTableView];
    [self  loadData];

    // Do any additional setup after loading the view.
}
-(void)loadData
{
    if (_mDownManager) {
        return;
    }
    
    [self StartLoading];
    NSString * urlstr;
    urlstr = [NSString stringWithFormat:@"%@api/course/getCourseListByNew.json",BASEURL];
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
            HotSelecModel * model = [[HotSelecModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            [self.dataArray addObject:model];
        }
        [_tableView reloadData];
        
    }
}

#pragma mark 开始下载
-(void)StartLoading
{
    mLoadView = [[MBProgressHUD alloc] initWithView:self.view];
    mLoadView.delegate = self;
    mLoadView.labelText = @"拼命加载中，请稍后";
    if (mLoadMsg) {
        mLoadView.mode = MBProgressHUDModeCustomView;
    }
    mLoadView.dimBackground = YES;
    [self.view addSubview:mLoadView];
    [mLoadView show:YES];
}
- (void)OnLoadFail:(ImageDownManager *)sender {
    [self Cancel];
}
- (void)Cancel {
    [mLoadView hide:YES];
    mLoadView = nil;
    self.mDownManager.delegate = nil;
    SAFE_CANCEL_ARC(self.mDownManager);
    
}

-(void)dealloc
{
    _mDownManager.delegate = nil;
}

-(void)createTableView
{
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDETH, HEIGHT-64) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource=  self;
    [self.view addSubview:_tableView];
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HotSelectTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ID"];
    if (!cell) {
        cell = [[HotSelectTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ID"];
        cell.selectionStyle= UITableViewCellSelectionStyleNone;
    }
    [cell config:self.dataArray[indexPath.row]];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 115;
}

-(void)createNav
{
    self.title = @"最热";
    //修改状态栏的颜色
        if (iOS7) {
            [self.navigationController.navigationBar
    
             setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont boldSystemFontOfSize:20]}];
        }else{
            [self.navigationController.navigationBar setTitleTextAttributes:@{UITextAttributeTextColor: [UIColor whiteColor],UITextAttributeFont : [UIFont boldSystemFontOfSize:20]}];
        }
    //左侧首页按钮
    UIButton * leftButton = [MyContol createButtonWithFrame:CGRectMake(5, 15, 14, 22) ImageName:@"back.png" Target:self Action:@selector(HotLeftClick) Title:nil];
    leftButton.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    self.navigationItem.leftBarButtonItem =[[UIBarButtonItem alloc] initWithCustomView:leftButton];
}
-(void)HotLeftClick
{
    [self.navigationController popToRootViewControllerAnimated:YES];
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
