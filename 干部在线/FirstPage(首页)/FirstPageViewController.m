//
//  FirstPageViewController.m
//  干部在线
//
//  Created by lixianjun on 14-12-29.
//  Copyright (c) 2014年 中青年. All rights reserved.
//

#import "FirstPageViewController.h"
#import "AppDelegate.h"
#import "SpecialClassCell.h"
#include "hotOrNewTableViewCell.h"
#import "hotTopicViewController.h"
#include "SpecialClassDetailViewController.h"
#include "SpecialLabelViewController.h"
#import "SpecialTopicListViewController.h"
#import "AFHTTPRequestOperationManager.h"
#import "RankingViewController.h"
#import "ImageDownManager.h"
#import "JSON.h"
#import "MJRefresh.h"
#import "FirtPageModel.h"




#import "PublicClassViewController.h"
#import "AppDelegate.h"
#import "SearchViewController.h"
#import "StudyMeterialViewController.h"
#import "Adaptation.h"
#import "NewSelectViewController.h"
#import "HotSelectViewController.h"
#import "NewViewController.h"
#import "ElectCourcrViewController.h"
#import "AppDelegate.h"


@interface FirstPageViewController ()<UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate,UIScrollViewDelegate,UIGestureRecognizerDelegate,MBProgressHUDDelegate,MJRefreshBaseViewDelegate,SDCycleScrollViewDelegate>

{
    
    MJRefreshHeaderView *header;
    MJRefreshFooterView *footer;
    int mpage;
     CGFloat height;
     CGFloat ScHeight;
    //导航页
    UIScrollView*sc;
    //小白点
    UIPageControl*page;
    //加载
    MBProgressHUD * mLoadView;
    //导航
    UIView *_view ;
    
    NSArray * imageArray;
    //最新最热选项卡
    UIView * hotAndNewViews;
    UIImageView * imageView;
    UIImageView * imageView1;
    UIImageView * imageView2;
    
    UITableView * _tableView;
    UIButton *  _hotButton;
    //headerView
    UIView * headView;
    
    
    SpecialClassCell * specialCell;
    BOOL flag;
    BOOL hotOrNewFlag;
    FirtPageModel * model;
    
    //对应最新最热界面按钮切换
    UIButton * newAndHotElectButton;
}

@property (nonatomic, strong) ImageDownManager *mDownManager;
@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,strong)NSDictionary * dic;
@property(nonatomic,strong)ImageDownManager * SpecialDownManager;
@property (nonatomic,strong)NSMutableArray * focusImageArray;
@property(nonatomic,strong)ImageDownManager * focusDownManager;

@end

@implementation FirstPageViewController
@synthesize mLoadMsg;
-(void)viewWillAppear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden = NO;
    
    
}

-(void)dealloc
{
    _mDownManager.delegate = nil;
    _SpecialDownManager.delegate = nil;
    _focusDownManager.delegate = nil;
    [header free];
    [footer free];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.focusImageArray = [NSMutableArray arrayWithCapacity:0];
    self.focusImageArray =[NSMutableArray arrayWithCapacity:0];
    
    
    [ self makeUI];
    
        [self createScrollView];
     [self createPageControl];
        [sc addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
    
    flag = YES;
    self.view.backgroundColor = [UIColor colorWithRed:0.94f green:0.94f blue:0.94f alpha:1.00f];
    self.dataArray = [NSMutableArray arrayWithCapacity:0];
    self.focusImageArray = [NSMutableArray arrayWithCapacity:0];
    
   
    
    //导航
    [self createNavView];
    //创建tableview
    [self createTableView];
    //创建headVeiw
     [self createHeadeView];
    //中间按钮选项卡
    [self createButton];
    
    //专题课程view
    [self createSpecialView];
    //专题数据请求
    //    [self SpecialLoadData];
    //最新最热数据请求
    [self loadData];
    //    焦点图数据请求
   [self focusLoadData];

        // Do any additional setup after loading the view.
}

-(void)makeUI
{
   


if (is3_5Inch) {
    height = 480;
    ScHeight = 130;
    
}else if(is4Inch)
{
    height = 568;
    ScHeight = 140;
}
else if (is4_7Inch)
{
    
    height = 667;
    ScHeight = 150;
}else if (is5_5Inch)
{
    
    height = 736;
    ScHeight = 160;
    }

}
#pragma mark ------------引导页
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    //第一个参数 什么属性改变了  第二个参数这个属性属于哪个对象  第三个参数 变化的值 第四个参数 上下文
    NSLog(@"%@~~~~~%@",change,keyPath);
    
    page.currentPage=sc.contentOffset.x/WIDETH;
    
    if (page.currentPage==2) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            [UIView animateWithDuration:1 animations:^{
                sc.alpha=0;
            }completion:^(BOOL finished) {
                //取消对sc的观察 重要！！否则会导致程序崩溃，如果sc不在销毁，那么在dealloc一定要取消观察者
                [sc removeObserver:self forKeyPath:@"contentOffset"];
                
                [sc removeFromSuperview];
                
                [page removeFromSuperview];
            }];
            
        });
        
        
    }
    
    
}
-(void)createPageControl{
    page=[[UIPageControl alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height-30, WIDETH, 20)];
    //小白点的个数
    page.numberOfPages=3;
//   [[UIApplication sharedApplication].keyWindow addSubview:page];
    [self.tabBarController.view addSubview:page];
}
-(void)createScrollView{

    sc=[[UIScrollView alloc]initWithFrame:self.view.frame];
    sc.showsHorizontalScrollIndicator=NO;
    sc.showsVerticalScrollIndicator=NO;
    sc.pagingEnabled=YES;
    sc.contentSize=CGSizeMake(WIDETH*3, self.view.frame.size.height);
//  [[UIApplication sharedApplication].keyWindow addSubview:sc];
    [self.tabBarController.view addSubview:sc];
    for (int i=0; i<3; i++) {
        UIImageView*naImageView=[[UIImageView alloc]initWithFrame:CGRectMake(i*WIDETH, 0, WIDETH, sc.frame.size.height)];
        naImageView.image=[UIImage imageNamed:[NSString stringWithFormat:@"引导页%d.png",i+1]];
        [sc addSubview:naImageView];
    }
    
}


#pragma marl ====================创建headeView
-(void)createHeadeView
{
    
    headView =[[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDETH, 35+80+ScHeight)];
_tableView.tableHeaderView = headView;
}

#pragma mark 专题数据解析

-(void)SpecialLoadData
{
    if (_SpecialDownManager) {
        return;
    }
    
    [self StartLoading1];
    NSString * urlstr1;
    
    urlstr1 = [NSString stringWithFormat:@"%@api/topicCourse/getImportantTopicBySeq.json",BASEURL];
    self.SpecialDownManager = [[ImageDownManager alloc] init];
    _SpecialDownManager.delegate = self;
    _SpecialDownManager.OnImageDown = @selector(OnLoadFinish1:);
    _SpecialDownManager.OnImageFail = @selector(OnLoadFail1:);
    [_SpecialDownManager GetImageByStr:urlstr1];
}
- (void)OnLoadFinish1:(ImageDownManager *)sender
{
    NSString *resStr = sender.mWebStr;
    NSDictionary *dict = [resStr JSONValue];
    [self Cancel1];
    self.dic = dict[@"data"];
    if (self.dic&&[self.dic isKindOfClass:[NSDictionary class]]) {
        [self refresh];
    }
}

-(void)refresh
{
    [specialCell specialConfig:self.dic];
}
#pragma mark 开始下载
-(void)StartLoading1
{
    
}
- (void)OnLoadFail1:(ImageDownManager *)sender {
    [self Cancel1];
}
- (void)Cancel1 {
    SAFE_CANCEL_ARC(self.SpecialDownManager);
    
}



#pragma merk 最新最热
-(void)loadData
{
    
    if (_mDownManager) {
        return;
    }
    
    //    MBProgressHUD * hub = [[MBProgressHUD alloc] initWithView:self.view];
    //    [self.view addSubview:hub];
    //    hub.labelText = @"正在加载";
    //    hub.mode = MBProgressHUDModeAnnularDeterminate;
    //    [hub showAnimated:YES whileExecutingBlock:^{
    //        float progres = 0.0f;
    //        while (progres<1.0f) {
    //            progres +=0.0001f;
    //            hub.progress = progres;
    //            usleep(50000);
    //
    //        }
    //    } completionBlock:^{
    //        [hub removeFromSuperview];
    //           }];
    //
    [self StartLoading];
    mLoadView = [[MBProgressHUD alloc] initWithView:self.view];
    mLoadView.delegate = self;
    mLoadView.labelText = @"正在加载中...";
    if (mLoadMsg) {
        mLoadView.mode = MBProgressHUDModeCustomView;
    }
    mLoadView.dimBackground = YES;
    [self.view addSubview:mLoadView];
    [mLoadView show:YES];
    NSString * urlstr;
    if (flag) {
        NSLog(@"最热");
        urlstr = [NSString stringWithFormat:@"%@api/course/getCourseListByHot.json",BASEURL];
    }
    else
    {
        urlstr = [NSString stringWithFormat:@"%@api/publicCourse/getCourseListByNew.json",BASEURL];
        NSLog(@"最新");
    }
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
//        for (NSDictionary *dic in array) {
//            model = [[FirtPageModel alloc] init];
//            [model setValuesForKeysWithDictionary:dic];
//            [self.dataArray addObject:model];
//        }
//        [_tableView reloadData];
//        
//    }
        
    if (mpage==0) {
        [self.dataArray removeAllObjects];
    }
//    [self.dataArray addObjectsFromArray:array];
        for (NSDictionary *dic in array) {
            model = [[FirtPageModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            [self.dataArray addObject:model];
        }
        [_tableView reloadData];
    mpage ++;
//    [_tableView reloadData];
    
}
else
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = @"加载完成";
    hud.margin = 10.f;
    hud.yOffset = 150.f;
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:1.5];
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

#pragma mark 专题UI
-(void)createSpecialView
{
    //    //专题界面
    //    specialCell = [[SpecialClassCell alloc] initWithFrame:CGRectMake(0,-160, WIDETH,122)];
    //    specialCell.backgroundColor =[UIColor whiteColor];
    //    [_tableView addSubview:specialCell];
    //
    //    specialCell.userInteractionEnabled = YES;
    //    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGester)];
    //    [specialCell addGestureRecognizer:tap];
    //背景暗条
    //    UIView * backView = [[UIView alloc] initWithFrame:CGRectMake(0, -38, WIDETH, 10)];
    //
    //  backView.backgroundColor =[UIColor colorWithRed:0.94f green:0.94f blue:0.94f alpha:1.00f];
    //    [_tableView addSubview:backView];
    //最新最热选项卡
    hotAndNewViews = [[UIView alloc] initWithFrame:CGRectMake(0,ScHeight+80, WIDETH, 35)];
    hotAndNewViews.backgroundColor = [UIColor whiteColor];
    
  [headView addSubview:hotAndNewViews];
    //背景Viwew
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(15, 35, WIDETH -25, 0.8)];
    view.backgroundColor = [UIColor colorWithRed:0.84f green:0.84f blue:0.84f alpha:1.00f];
    [hotAndNewViews addSubview:view];
    //对应最新最热界面按钮切换
    
    newAndHotElectButton = [[UIButton alloc] initWithFrame:CGRectMake(WIDETH-  60, 0,60, 35)];
    //   newAndHotElectButton.backgroundColor = [UIColor redColor];
    [newAndHotElectButton addTarget:self action:@selector(newButton) forControlEvents:UIControlEventTouchUpInside];
    [hotAndNewViews addSubview:newAndHotElectButton];
    UIImageView *newAndHotElectView = [[UIImageView alloc] initWithFrame:CGRectMake(38, 10, 11, 15)];
    newAndHotElectView.image = [UIImage imageNamed:@"最新最热进入箭头.png"];
    [newAndHotElectButton addSubview:newAndHotElectView];
    UILabel * newAndHotElectLabel =[[UILabel alloc] initWithFrame:CGRectMake(5, 5, 40, 25)];
    newAndHotElectLabel.text = @"更多";
    newAndHotElectLabel.font = [UIFont systemFontOfSize:14];
    newAndHotElectLabel.textColor =[UIColor colorWithRed:0.13f green:0.4f blue:0.91 alpha:1.00f];
    [newAndHotElectButton addSubview:newAndHotElectLabel];
    
        //最新最热选项卡
    NSArray * titleArray = @[@"最热",@"最新"];
    for (int i=0; i < titleArray.count ; i++) {
        UIButton * button = [MyContol createButtonWithFrame:CGRectMake(10+ i * 65,0, 55, 40) ImageName:nil Target:self Action:@selector(buttonClick:) Title:titleArray[i]];
        button.titleLabel.textColor = [UIColor grayColor];
//       button.titleLabel.textColor = [UIColor colorWithRed:0.3 green:0.34 blue:0.3 alpha:1];
               button.titleLabel.font = [UIFont systemFontOfSize:17];
        button.tag = 10+i;
        if (i==0) {
            button.selected = YES;
            hotOrNewFlag =YES;
        }
        //正常的颜色
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        //选中的颜色
        [button setTitleColor:[UIColor colorWithRed:0.13f green:0.4f blue:0.91 alpha:1.00f]
 forState:UIControlStateSelected];
        [hotAndNewViews addSubview:button];
    }
    // 分割线
    UIImageView*  lineImageView  = [MyContol createImageViewWithFrame:CGRectMake(67, 10, 2, 20) ImageName:nil];
    lineImageView.image = [UIImage imageNamed:@"分隔条.png"];
    [hotAndNewViews addSubview:lineImageView];
    
}
-(void)buttonClick:(UIButton *)sender
{
    for (UIView *view in hotAndNewViews.subviews)
        
    {
        if ([view isKindOfClass:[UIButton class]]) {
            UIButton * btn = (UIButton*)view;
            btn.selected = NO;
        }
        else
        {
            sender.selected = YES;
        }
    }
    
    if (sender.tag == 10) {
        flag = YES;
        [self.dataArray removeAllObjects];
        [self loadData];
        hotOrNewFlag  = YES;
        //        newAndHotElectButton.backgroundColor = [UIColor redColor];
        NSLog(@" 最热");
        
    }
    else if (sender.tag ==11) {
        flag = NO;
        [self.dataArray removeAllObjects];
        [self loadData];
        NSLog(@"最新");
        hotOrNewFlag = NO;
        
    }
    
}

-(void)newButton
{
    if (hotOrNewFlag == YES) {
        
        HotSelectViewController * hot = [[HotSelectViewController alloc] init];
        hot.hidesBottomBarWhenPushed =   YES;
        [self.navigationController pushViewController:hot animated:YES];
    }else if (hotOrNewFlag == NO)
    {
        NewViewController * new = [[NewViewController alloc] init];
        new.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:new animated:YES];
        
    }
    
    
}
//-(void)buttonClick:(UIButton*)sender
//{
//
//    float index = sender.tag - 10;
//    NSLog(@"%f",index);
//    UIButton * btn0 = (UIButton *)[specialCell viewWithTag:10];
//    UIButton * btn1 = (UIButton*)[specialCell viewWithTag:11];
//    NSArray * tempArray = @[btn0,btn1];
//
//    for (UIButton * btn in tempArray) {
//        if (btn.tag - 10 == index) {
//            btn.selected = YES;
//            NSLog(@"最热");
//
//        }else
//        {
//            btn.selected = NO;
//            NSLog(@"最新");
//
//        }
//    }
//
//   }
-(void)createTableView
{
    _tableView  = [[UITableView alloc] initWithFrame:CGRectMake(0,0, WIDETH, HEIGHT ) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.backgroundColor =  [UIColor colorWithRed:0.94f green:0.94f blue:0.94f alpha:1.00f];
//    _tableView.contentInset = UIEdgeInsetsMake(35+80+ScHeight, 0, 0, 0);
    [self.view addSubview:_tableView];
    //刷新
    header = [MJRefreshHeaderView header];
    header.scrollView = _tableView;
    header.delegate = self;
    footer = [MJRefreshFooterView footer];
    footer.scrollView = _tableView;
    footer.delegate = self;
    
}
-(void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView
{
    if (refreshView == header) {
        mpage =0;
        [self loadData];
    }
    else if (refreshView == footer)
    {
        [self loadData];
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if(self.dataArray.count == 0)
    {
        return 3;
    }
    return self.dataArray.count;
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{    hotOrNewTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ID"];
    if (!cell) {
        cell = [[hotOrNewTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ID"];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.selectionStyle =UITableViewCellSelectionStyleNone;
    }
    if(self.dataArray.count == 0)
    {
        [cell config: nil];
    }else
    {
        [cell config: self.dataArray[indexPath.row]];
    }
    
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 125;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    hotTopicViewController * hotVc = [[hotTopicViewController alloc] init];
    hotVc.hidesBottomBarWhenPushed = YES;
    if (self.dataArray.count==0) {
        hotVc.courceId = nil;
    }
    else
    {
        FirtPageModel * firstModel  = self.dataArray[indexPath.row];
        
        hotVc.courceId = firstModel.courseId;
    }
    [self.navigationController pushViewController:hotVc animated:YES];
}
#pragma mark 实现专题课程
-(void)tapGester

{
    SpecialClassDetailViewController * specialVc = [[SpecialClassDetailViewController alloc] init];
    specialVc.hidesBottomBarWhenPushed = YES;
    specialVc.topicID = [NSString stringWithFormat:@"%@",self.dic[@"topicId"]];
    [self.navigationController pushViewController:specialVc animated:YES];
}
#pragma mark  创建中间按钮的选项
-(void)createButton
{
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, ScHeight, WIDETH,75)];
    view.backgroundColor =[UIColor whiteColor];
    
   [headView addSubview:view];
    NSArray *  titleArray =@[@"公开课",@"课程超市",@"排行榜",@"学习资料"];
    NSArray * buttonImageArray = @[@"公开课my.png",@"专题培训my.png",@"奖杯my.png",@"学习资料my.png"];
    
    for (int i = 0; i < titleArray.count; i++) {
        UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(10 + (WIDETH  -20)/ 4.0 *i,0, (WIDETH  -20)/ 4.0-5, 75)];
        //        button.backgroundColor =[UIColor redColor];
        [view addSubview:button];
        [button addTarget:self action:@selector(PageButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = 100+ i;
        //button添加图片
        UIImageView * selectImageView = [[UIImageView alloc] initWithFrame:CGRectMake((button.frame.size.width - 50) /2.0, 5, 46, 46)];
        selectImageView.image = [UIImage imageNamed:buttonImageArray[i]];
        [button addSubview:selectImageView];
        //给Button添加选项卡
        UILabel * lable = [MyContol createLabelWithFrame:CGRectMake(0, 53, button.frame.size.width, 16) Font:14 Text:titleArray[i]];
        //        lable.font = [UIFont boldSystemFontOfSize:13];
        //       lable.backgroundColor = [UIColor greenColor];
        lable.textColor = [UIColor colorWithRed:0.3 green:0.34 blue:0.3 alpha:1];
        lable.font = [UIFont systemFontOfSize:14];

        lable.textAlignment = NSTextAlignmentCenter;
        [button addSubview:lable];
    }
    
}
-(void)PageButtonClick:(UIButton*)sender
{
    switch (sender.tag) {
        case 100:
        {
            PublicClassViewController * public = [[PublicClassViewController alloc] init];
            public.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:public animated:YES];
            NSLog(@"公开课");
        }
            break;
        case 101:
        {
            NSLog(@"课程超市");
            //            SpecialTopicListViewController  * vc = [[SpecialTopicListViewController alloc] init];
            ElectCourcrViewController * elect = [[ElectCourcrViewController alloc] init];
            elect.hidesBottomBarWhenPushed = YES;
            [self.navigationController  pushViewController:elect animated:YES];
        }
            break; case 102:
        {
            RankingViewController * rank = [[RankingViewController alloc] init];
            // UINavigationController * rankNav = [[UINavigationController alloc] initWithRootViewController:rank];
            rank.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:rank animated:YES];
            NSLog(@"排行榜");
        }
            break;
        case 103:
        {
            StudyMeterialViewController * meterial = [[StudyMeterialViewController alloc] init];
            meterial.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:meterial animated:YES];
             NSLog(@"学习资料");
        }
           
            break;
        default:
            break;
    }
    
}
#pragma mark 导航页
-(void)createNavView
{
    self.navigationController.navigationBar.translucent = NO;
    //修改状态栏的颜色
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 20)];
    view.backgroundColor = [UIColor blackColor];
    
//    [self.navigationController.view addSubview:view];
    UIApplication * app = [UIApplication sharedApplication];
    AppDelegate * delegate = (AppDelegate*)app.delegate;
    [delegate.window addSubview:view];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.19f green:0.51f blue:0.93f alpha:1.00f];
    //修改状态栏的颜色
    //    if (iOS7) {
    //        [self.navigationController.navigationBar
    //
    //         setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:0.19f green:0.51f blue:0.94f alpha:1.00f],NSFontAttributeName:[UIFont boldSystemFontOfSize:20]}];
    //    }else{
    //        [self.navigationController.navigationBar setTitleTextAttributes:@{UITextAttributeTextColor: [UIColor colorWithRed:0.19f green:0.51f blue:0.94f alpha:1.00f],UITextAttributeFont : [UIFont boldSystemFontOfSize:20]}];
    //    }
    //导入过去侯就不会出现back
    //self.navigationItem.title = @"";
    //    self.title = @"我的首页";
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 80, 44)];
    titleLabel.text = @"我的首页";
    titleLabel.textColor =[UIColor whiteColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont boldSystemFontOfSize:20];
    self.navigationItem.titleView = titleLabel;
    //左侧首页按钮
    UIButton * leftButton = [MyContol createButtonWithFrame:CGRectMake(15, 15, 20, 20) ImageName:@"home_icon.png" Target:self Action:@selector(firstLeftClick) Title:nil];
    self.navigationItem.leftBarButtonItem =[[UIBarButtonItem alloc] initWithCustomView:leftButton];
    
    UIButton * searchButton = [MyContol createButtonWithFrame:CGRectMake(0, 0, 22, 22) ImageName:@"搜索框.png" Target:self Action:@selector(searchButton) Title:nil];
    self.navigationItem.rightBarButtonItem =[[UIBarButtonItem alloc] initWithCustomView:searchButton];
    
}
#pragma mark  搜索
-(void)searchButton
{
    SearchViewController * search = [[SearchViewController alloc] init];
    [self.navigationController pushViewController:search animated:NO];
}

#pragma mark 左按钮点击事件
-(void)firstLeftClick
{
    AppDelegate *delegate=(AppDelegate*)[[UIApplication sharedApplication]delegate];
    YRSideViewController * sideViewController=[delegate sideViewController];
    [sideViewController showLeftViewController:true];
    
       NSLog(@"我的首页左侧按钮点击事件");
    
}
#pragma mark 焦点图解析
-(void)focusLoadData
{
    if (_focusDownManager) {
        return;
    }
    
    [self StartLoading3];
    NSString * urlstr;
    
    urlstr = [NSString stringWithFormat:@"%@api/information/getFocusImg.json",BASEURL];
    self.focusDownManager = [[ImageDownManager alloc] init];
    _focusDownManager.delegate = self;
    _focusDownManager.OnImageDown = @selector(OnLoadFinish3:);
    _focusDownManager.OnImageFail = @selector(OnLoadFail3:);
    [_focusDownManager GetImageByStr:urlstr];
}
- (void)OnLoadFinish3:(ImageDownManager *)sender
{
    
    NSString *resStr = sender.mWebStr;
    NSDictionary *dict = [resStr JSONValue];
    [self Cancel3];
    NSArray * array1 = dict[@"data"];
    if ( array1&&[ array1 isKindOfClass:[NSArray class]] && array1.count>0) {
        for (NSDictionary * dic in array1) {
            [self.focusImageArray addObject:dic];
        }
        [self focusRefreh];
    }
}

//-(void)focusRefreh
//{
//    //NSArray * imageArrays =@[@"专题.png",@"kecheng.png",@"course_bg.png"];
//    
//    float  focusCount = self.focusImageArray.count;
//    for (int i = 0; i < focusCount; i++) {
//        imageView = (UIImageView *)[_sc viewWithTag:1000 + i];
//        
//        [imageView sd_setImageWithURL:[NSURL URLWithString:self.focusImageArray[i][@"imgUrl"]]placeholderImage:[UIImage imageNamed:imageArray[i]]];
//        //设置第一张图片显示zui后一张
//        [imageView1 sd_setImageWithURL:[NSURL URLWithString:self.focusImageArray[2][@"imgUrl"]] placeholderImage:[UIImage imageNamed:imageArray[2]]];
//        //设置最后一张显示第一张
//        [imageView2 sd_setImageWithURL:[NSURL URLWithString:self.focusImageArray[0][@"imgUrl"]] placeholderImage:[UIImage imageNamed:imageArray[0]]];
//    }
//}
//
#pragma mark 开始下载
-(void)StartLoading3
{
    
}
- (void)OnLoadFail3:(ImageDownManager *)sender {
    [self Cancel3];
}
- (void)Cancel3 {
    SAFE_CANCEL_ARC(self.focusDownManager);
    
}

#pragma mark --导航页焦点图
-(void)focusRefreh
{
NSArray *images = @[[UIImage imageNamed:@"焦点图1.jpg"],
                        [UIImage imageNamed:@"焦点图2.jpg"],
                        [UIImage imageNamed:@"焦点图3.jpg"]
                    ];
//    NSMutableArray * imageArray1 = [NSMutableArray arrayWithCapacity:0];
//   
//    int count = (int)self.focusImageArray.count;
//    for (int i = 0 ; i < count; i++) {
//        [self.imageView sd_setImageWithURL:[NSURL URLWithString:self.focusImageArray[i][@"imgUrl"]]];
//        
//        
//        
//        [imageArray1 addObject:self.imageView.image];
//    }
//    
    
    NSArray *titles = @[@"干部在线",
                        @"干部在线",
                        @"干部在线"
                        ];
    
    
       // 创建带标题的图片轮播器
    SDCycleScrollView *cycleScrollView2 = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0,0, WIDETH,ScHeight) imagesGroup:images];
    cycleScrollView2.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
    cycleScrollView2.delegate = self;
    cycleScrollView2.titlesGroup = titles;
//    _tableView.tableHeaderView = cycleScrollView2;
       [headView addSubview:cycleScrollView2];
    
//    //创建sc
//    _sc  = [[UIScrollView alloc] initWithFrame:CGRectMake(0,-(35+80+ScHeight), WIDETH,ScHeight)];
//   
//    _sc.showsHorizontalScrollIndicator = NO;
//    _sc.showsVerticalScrollIndicator=NO;
//    _sc.pagingEnabled=YES;
//    _sc.delegate = self;
//    _sc.contentSize = CGSizeMake(WIDETH * 5, 145 - 64);
//    [_tableView addSubview:_sc];
}
#pragma mark - SDCycleScrollViewDelegate

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    NSLog(@"---点击了第%d张图片", (int)index);
}
//-(void)createImageView
//{
//    //创建图片
//    imageArray =@[@"焦点图1.jpg",@"焦点图2.jpg",@"焦点图3.jpg"];
//    for (int i =0; i < imageArray.count; i++) {
//        imageView  = [[UIImageView alloc] initWithFrame:CGRectMake(WIDETH+ WIDETH* i , 0, WIDETH, ScHeight)];
//        imageView.tag = 1000+i ;
//        imageView.image = [UIImage imageNamed:imageArray [i]];
//        [_sc addSubview:imageView];
//    }
//    //设置第一张图片显示最后一张图片
//    imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, WIDETH, ScHeight)];
//    imageView1.image = [UIImage  imageNamed:imageArray[2]];
//    [_sc addSubview:imageView1];
//    //设置最后一张显示第一张
//    imageView2 = [[UIImageView alloc] initWithFrame:CGRectMake(WIDETH * 4, 0, WIDETH, ScHeight)];
//    imageView2.image = [UIImage imageNamed:imageArray[0]];
//    [_sc addSubview:imageView2];
//    //设置sc的偏移量
//    _sc.contentOffset=CGPointMake(WIDETH, 0);
//    
//    // 创建原点
//    _pageControl  = [[UIPageControl alloc] initWithFrame:CGRectMake(WIDETH - 80, 130, 60, 20)];
//        _pageControl.backgroundColor = [UIColor redColor];
//    _pageControl.currentPage = 0;
//    _pageControl.numberOfPages = 3;
//    [_sc addSubview:_pageControl];
//}
//#pragma mark  定时器每隔两秒进行一次
//-(void)createTimer
//{
//    [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(nextClick) userInfo:nil repeats:YES];
//}
//
//-(void)nextClick{
//    
//    [UIView animateWithDuration:0.4 animations:^{
//        
//        _sc.contentOffset=CGPointMake(_sc.contentOffset.x+WIDETH, 0);
//        _pageControl.currentPage +=1;
//        
//    }completion:^(BOOL finished) {
//        
//        if (_sc.contentOffset.x==WIDETH*4) {
//            _sc.contentOffset=CGPointMake(WIDETH, 0);
//            _pageControl.currentPage = 0;
//        }
//    }];
//}
//#pragma mark  实现协议的方法
//-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
//{
//    if (_sc.contentOffset.x==0) {
//        //当显示为第一页的时候，我们需要设置为倒数第二页
//        _sc.contentOffset=CGPointMake(WIDETH*3, 0);
//    }
//    if (_sc.contentOffset.x==WIDETH*4) {
//        _sc.contentOffset=CGPointMake(WIDETH, 0);
//    }
//    
//}
//
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
