//
//  MyFileViewController.m
//  干部在线
//
//  Created by lixianjun on 15-1-9.
//  Copyright (c) 2015年 中青年. All rights reserved.
//

#import "MyFileViewController.h"
#import "MyClassTableViewCell.h"
#import "ImageDownManager.h"
#import "JSON.h"
@interface MyFileViewController ()<UITableViewDataSource,UITableViewDelegate>

{ MBProgressHUD * mLoadView;
    //导航选项卡
    UIView  * botomView;
    UITableView * _tabelView;
    //更多年份选项
    UIButton * yearsButton ;
    UIView *yearView;
    NSString *year;
}
@property(nonatomic,strong)ImageDownManager *mDownManager;
@property(nonatomic,strong)NSMutableArray *dataArray;
@end

@implementation MyFileViewController
@synthesize mLoadMsg;
- (void)viewDidLoad {
    [super viewDidLoad];
   // year = @"2014";
    year = 0;
    self.view.backgroundColor = [UIColor whiteColor];
    [super viewDidLoad];
      [self createNav];
    [self createView];
    [self createTabelView];
    [self loadData];
    // Do any additional setup after loading the view.
}
-(void)createTabelView{
    
    _tabelView = [[UITableView alloc] initWithFrame:CGRectMake(0,  50  , WIDETH, HEIGHT - 114 - 49) style:UITableViewStylePlain];
    _tabelView.delegate = self;
    _tabelView.dataSource=  self;
//    _tabelView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    _tabelView.backgroundColor =  [UIColor whiteColor];
    
    [self.view addSubview:_tabelView];
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   return self.dataArray.count;
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    MyClassTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ID"];
    if (!cell) {
        cell = [[MyClassTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ID"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
//     LearnPressImageVeiw.frame = CGRectMake(190, 98, 80/3, 6);
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 130;
}
-(void)createView
{
    botomView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDETH, 50)];
    //botomView.backgroundColor = [UIColor whiteColor];
    botomView.layer.borderWidth = 0.31;
    botomView.layer.borderColor = [UIColor colorWithRed:0.94f green:0.94f blue:0.94f alpha:1.00f].CGColor;
    [self.view addSubview:botomView];
    NSArray  * coureceElectLabel = @[@"2014",@"2013",@"2012"];
    for (int i = 0; i < coureceElectLabel.count; i ++) {
        UIButton  * electButton = [MyContol createButtonWithFrame:CGRectMake(20 + WIDETH/3.0 * i, 15, WIDETH/3.0 - 30, 20) ImageName:nil Target:self Action:@selector(buttonClick:) Title:coureceElectLabel[i]];
        electButton.tag = 10+i;
        //正常的颜色
        [electButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        //选中的颜色
        [electButton setTitleColor:[UIColor blueColor] forState:UIControlStateSelected];
        [botomView addSubview:electButton];
    }
    UIImageView * bottomLineView = [MyContol createImageViewWithFrame:CGRectMake(2, 47, WIDETH/3.0-4, 3) ImageName:@"矩形 10.png"];
    bottomLineView.tag = 100;
    [botomView addSubview:bottomLineView];
}
#pragma 选项卡
-(void)buttonClick:(UIButton*)sender
{
    float index = sender.tag - 10;
    
    for (UIView *view in botomView.subviews)
        
    {
        if ([view isKindOfClass:[UIButton class]]) {
            UIButton * btn = (UIButton*)view;
            btn.selected = NO;
        }
        sender.selected = YES;
        
    }
    UIImageView *bottomLineView = (UIImageView*)[botomView viewWithTag:100];
    [UIView animateWithDuration:0.3 animations:^{
        bottomLineView.frame = CGRectMake(2+WIDETH/3 * index , 47,WIDETH/3.0, 3);
    }];
    
    if (index == 0)
    {
        NSLog(@"2014");
        year = @"2014";
        [self loadData];
    }
    if (index == 1)
    {
        NSLog(@"2013");
    }
    if (index ==2)
    {
        NSLog(@"2012");
    }
}
-(void)createNav
{
//  //标题
//    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 80, 44)];
//    titleLabel.text = @"归档课程";
//    self.navigationItem.titleView = titleLabel;
//
//    //更多年份记录选项
//    UIButton * recordMoreButton = [[UIButton alloc] initWithFrame:CGRectMake(WIDETH - 21, 0, 21, 44)];
//    [recordMoreButton addTarget:self action:@selector(moreButtonClick) forControlEvents:UIControlEventTouchUpInside];
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:recordMoreButton];
//    
//    UIImageView * moreYearImageView  = [[UIImageView alloc] initWithFrame:CGRectMake(17, 10, 3, 22)];
//    moreYearImageView.image = [UIImage imageNamed:@"更多.png"];
//    [recordMoreButton addSubview:moreYearImageView];
    
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.10f green:0.47f blue:0.73f alpha:1.00f];
    //修改状态栏的颜色
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 20)];
    view.backgroundColor = [UIColor blackColor];
    [self.navigationController.view addSubview:view];
    //    UIApplication * app = [UIApplication sharedApplication];
    //    AppDelegate * delegate = (AppDelegate*)app.delegate;
    //   [delegate.window addSubview:view];
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 80, 44)];
    titleLabel.text = @"我的归档";
    titleLabel.textColor =[UIColor whiteColor];
    titleLabel.font = [UIFont systemFontOfSize:20];
    self.navigationItem.titleView = titleLabel;
    //左侧首页按钮
    UIButton * leftButton = [MyContol createButtonWithFrame:CGRectMake(5, 15, 14, 22) ImageName:@"登陆返回.png" Target:self Action:@selector(recenLeftClick) Title:nil];
    self.navigationItem.leftBarButtonItem =[[UIBarButtonItem alloc] initWithCustomView:leftButton];
    
}
-(void)recenLeftClick
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark 更多选项卡
-(void)moreButtonClick
{
    NSLog(@"更多年份记录");
    NSArray  * yearsArray = @[@"2011",@"2010",@"2009",@"2008",@"2007"];
    if (yearView == nil) {
        yearView = [[UIView alloc]initWithFrame:CGRectMake(WIDETH, 0, 0, 0)];
        [self.view addSubview:yearView];
    }
    [UIView animateWithDuration:0.5 animations:^{
        yearView.frame = CGRectMake(WIDETH-80, 0, 78, 200);
        for (int i= 0; i<yearsArray.count; i++) {
            UIButton *btn = [MyContol createButtonWithFrame:CGRectMake(0, i * 40, 78, 40) ImageName:nil Target:self Action:@selector(selectClick:) Title:yearsArray[i]];
            btn.backgroundColor =[UIColor whiteColor];
            btn.tag = 10 + i;
            btn.layer.borderWidth = 0.5;
            btn.layer.backgroundColor = [UIColor colorWithRed:0.89f green:0.89f blue:0.89f alpha:1.00f].CGColor;
            [yearView addSubview:btn];
        }
    }];
}
#pragma mark 我的年份学习记录
-(void)selectClick:(UIButton*)sender
{
    float index = sender.tag - 10;
    NSArray  * yearsArray = @[@"2011",@"2010",@"2009",@"2008",@"2007"];
    year = yearsArray[sender.tag-10];
    [self loadData];
    NSLog(@"年份%f",index);
    [UIView animateWithDuration:0.5 animations:^{
        yearView.frame =CGRectMake(WIDETH-80, 200, 0, 0);
    } completion:^(BOOL finished) {
        if (finished) {
            for (UIView *view in yearView.subviews) {
                [view removeFromSuperview];
            }
            [yearView removeFromSuperview];
            yearView = nil;
        }
    }];
}
-(void)dealloc
{

    self.mDownManager  = nil;
}
#pragma mark   加载数据
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
