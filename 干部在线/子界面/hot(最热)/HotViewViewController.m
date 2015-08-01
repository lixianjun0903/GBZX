//
//  HotViewViewController.m
//  干部在线
//
//  Created by lixianjun on 15-1-19.
//  Copyright (c) 2015年 中青年. All rights reserved.
//

#import "HotViewViewController.h"
#import "HotTableViewCell.h"
#import "JSON.h"
#import "ImageDownManager.h"
#import "Hotmodel.h"
@interface HotViewViewController ()<UITableViewDataSource,UITableViewDelegate>

{

    UITableView * _tableView;
}
@property (nonatomic, strong) ImageDownManager *mDownManager;
@property(nonatomic,strong)NSMutableArray *dataArray;

@end

@implementation HotViewViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor =[UIColor whiteColor];
    self.dataArray = [NSMutableArray arrayWithCapacity:0];
    self.navigationController.navigationBar.translucent = NO;
    [self createVc];
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
            Hotmodel * model = [[Hotmodel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            [self.dataArray addObject:model];
        }
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
    HotTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ID"];
    if (!cell) {
        cell = [[HotTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ID"];
        cell.selectionStyle= UITableViewCellSelectionStyleNone;
    }
    [cell config:self.dataArray[indexPath.row]];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    return 100;
}
-(void)createVc
{[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 20)];
    view.backgroundColor = [UIColor blackColor];
    [self.navigationController.view addSubview:view];
    self.navigationController.navigationBar.barTintColor  = [UIColor colorWithRed:0.19f green:0.51f blue:0.93f alpha:1.00f];
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 80, 44)];
    titleLabel.text = @"最热";
    titleLabel.textColor =[UIColor whiteColor];
    titleLabel.font = [UIFont boldSystemFontOfSize:20];
    self.navigationItem.titleView = titleLabel;
    //左侧首页按钮
    UIButton * leftButton = [MyContol createButtonWithFrame:CGRectMake(5, 15, 14, 22) ImageName:@"back.png" Target:self Action:@selector(firstLeftClick) Title:nil];
    leftButton.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    self.navigationItem.leftBarButtonItem =[[UIBarButtonItem alloc] initWithCustomView:leftButton];

}
-(void)firstLeftClick
{[self dismissViewControllerAnimated:YES completion:nil];
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
