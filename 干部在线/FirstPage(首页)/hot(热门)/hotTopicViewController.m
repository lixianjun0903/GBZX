//
//  hotTopicViewController.m
//  干部在线
//
//  Created by lixianjun on 14-12-30.
//  Copyright (c) 2014年 中青年. All rights reserved.
//

#import "hotTopicViewController.h"
#import "classDisplay.h"
#import "ConmentTableViewCell.h"
#import "PushTabelVewiCell.h"
#import "ImageDownManager.h"
#import "JSON.h"
#import "classDisplay.h"
#import "commentMOdel.h"
#import "PushMOdel.h"
#import "hotLeftView.h"
@interface hotTopicViewController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate,MBProgressHUDDelegate>
{  MBProgressHUD * mLoadView;
    MBProgressHUD * pushMloadView;
    NSNumber * isSelect;
    //滑动的view
    UIScrollView * _mainSC;
    
    UIImageView * topView;
    //底部的UIView
    hotLeftView * leftView;
    //顶部的uiview
    UIView * rightView;
    //动画view
    UIView * _automoView;
    UIView * smarkView;
    UIButton * smarkButton;
    //uitabview
    UITableView * _pushTableView;
    
    classDisplay * _display;
    //底部选项卡
    UIView * bottomView;
    UIButton * selectClass;
    
    UIImageView * bottomLineView;
    BOOL flag ;
    //相关推荐
    UIButton * pushButton;
    
}
@property (nonatomic, strong) ImageDownManager *pushDownManager;
@property(nonatomic,strong)ImageDownManager * displayDownManager;
@property(nonatomic,strong)ImageDownManager * electDownManager;

@property(nonatomic,strong)NSMutableArray * pushArray;
@property(nonatomic,strong)NSDictionary * dic;
@property(nonatomic,strong)NSDictionary * elecdic;

@end

@implementation hotTopicViewController
@synthesize mLoadMsg;
@synthesize pushMLoadMsg;
- (void)viewDidLoad {
    [super viewDidLoad];
    self.pushArray = [NSMutableArray arrayWithCapacity:0];
    self.view.backgroundColor = [UIColor whiteColor];
    [self createMainSC];
    [self createNav];
    [self createView];
    
    [self createPushView];
    [self createNavButtonView];
    [self createCommentView];
    
    [self loadDataDisplay];
    flag =  YES;
    
    [self PushLoadData];
    
    
    
    // Do any additional setup after loading the view.
}
-(void)dealloc
{
    self.pushDownManager.delegate =  nil;
    self.displayDownManager.delegate = nil;
}
#pragma mark 展示数据请求
-(void)loadDataDisplay
{
    if (_displayDownManager) {
        return;
    }
    
    mLoadView = [[MBProgressHUD alloc] initWithView:self.view];
    mLoadView.delegate = self;
    mLoadView.labelText = @"正在加载中...";
    //    mLoadView.color = [UIColor grayColor];
    if (mLoadMsg) {
        mLoadView.mode = MBProgressHUDModeCustomView;
    }
    mLoadView.dimBackground = YES;
    [self.view addSubview:mLoadView];
    [mLoadView show:YES];
    
    NSUserDefaults * user =[NSUserDefaults standardUserDefaults];
    NSString * stuID = [user objectForKey:@"sutdentId"];
    
    NSString * displayUrlstr;
    if (!stuID) {
        displayUrlstr = [NSString stringWithFormat:@"%@api/course/getCourseById.json?courseId=%@",BASEURL,self.courceId];
    }
    else{
        displayUrlstr = [NSString stringWithFormat:@"%@api/course/getCourseById.json?courseId=%@&studentId=%@",BASEURL,self.courceId,stuID];
    }
    self.displayDownManager = [[ImageDownManager alloc] init];
    _displayDownManager.delegate = self;
    _displayDownManager.OnImageDown = @selector(OnLoadFinish1:);
    _displayDownManager.OnImageFail = @selector(OnLoadFail1:);
    [_displayDownManager GetImageByStr:displayUrlstr];
    
}
- (void)OnLoadFinish1:(ImageDownManager *)sender
{
    NSString *resStr = sender.mWebStr;
    NSDictionary *dict = [resStr JSONValue];
    [self Cancel1];
    self.dic = dict[@"data"];
    if (self.dic&&[self.dic isKindOfClass:[NSDictionary class]]) {
        [self refresh];
        [self refreshElectView];
    }
}
-(void)refresh
{
    
    [_display config:self.dic];
    
}
- (void)OnLoadFail1:(ImageDownManager *)sender {
    [self Cancel1];
}
- (void)Cancel1 {
    //[self StopLoading];
    [mLoadView hide:YES];
    mLoadView = nil;
    
    SAFE_CANCEL_ARC(self.displayDownManager);
    
}
#pragma mark  推荐数据请求
-(void)PushLoadData
{    if (_pushDownManager) {
    return;
}
    [self StartLoading2];
        pushMloadView = [[MBProgressHUD alloc] initWithView:self.view];
        pushMloadView.delegate = self;
        pushMloadView.labelText = @"正在加载中...";
        pushMloadView.color = [UIColor grayColor];
        if (pushMLoadMsg) {
            pushMloadView.mode = MBProgressHUDModeCustomView;
        }
        pushMloadView.dimBackground = YES;
        [self.view addSubview:pushMloadView];
        [pushMloadView show:YES];
    NSString * urlstr2;
    urlstr2 = [NSString stringWithFormat:@"%@api/course/getRecommendCourseList.json?courseId=%@",BASEURL,self.courceId];
    
    self.pushDownManager = [[ImageDownManager alloc] init];
    _pushDownManager.delegate = self;
    _pushDownManager.OnImageDown = @selector(OnLoadFinish2:);
    _pushDownManager.OnImageFail = @selector(OnLoadFail2:);
    [_pushDownManager GetImageByStr:urlstr2];
    
}
- (void)OnLoadFinish2:(ImageDownManager *)sender
{
    NSString *resStr = sender.mWebStr;
    NSDictionary *dict = [resStr JSONValue];
    [self Cancel2];
    NSDictionary * dics = dict[@"data"];
    NSArray * array = dics[@"data"];
    
    if (array&&[array isKindOfClass:[NSArray class]] &&array.count>0) {
        for (NSDictionary *dic in array) {
            PushMOdel * model = [[PushMOdel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            [self.pushArray addObject:model];
        }
        
        [_pushTableView reloadData];
    }
}

#pragma mark 开始下载
-(void)StartLoading2
{
    NSLog(@"开始下载中");
}
- (void)OnLoadFail2:(ImageDownManager *)sender {
    [self Cancel2];
}
- (void)Cancel2 {
    _pushDownManager.delegate = nil;
        [pushMloadView hide:YES];
        pushMloadView = nil;
    SAFE_CANCEL_ARC(self.pushDownManager);
    
}
#pragma mark 创建Miansc
-(void)createMainSC
{    _mainSC = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 230, WIDETH, HEIGHT-230-50 -64)];
    _mainSC.delegate  =self;
    _mainSC.showsHorizontalScrollIndicator = NO;
    _mainSC.contentSize = CGSizeMake(WIDETH*2, _mainSC.frame.size.height);
    _mainSC.pagingEnabled = YES;
    [self.view addSubview:_mainSC];
    
}
-(void)createNavButtonView
{
    topView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 170, WIDETH, 50)];
    topView.image = [UIImage imageNamed:@""];
    topView.layer.borderWidth = 0.5;
    topView.layer.borderColor = [UIColor colorWithRed:0.89f green:0.89f blue:0.89f alpha:1.00f].CGColor;
    topView.userInteractionEnabled =YES;
    [self.view addSubview:topView];
    //评论
    UIButton * commentButton = [MyContol createButtonWithFrame:CGRectMake(0, 0, WIDETH/2.0, 50) ImageName:nil Target:self Action:@selector(commentClick:) Title:@"评论"];
    [commentButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [commentButton setTitleColor:[UIColor colorWithRed:0.13f green:0.4f blue:0.91 alpha:1.00f] forState:UIControlStateSelected];
    commentButton.tag = 10;
    commentButton.titleLabel.font = [UIFont systemFontOfSize:20];
    commentButton.selected = YES;
    [topView addSubview:commentButton];
    
    //相关推荐
    pushButton = [MyContol createButtonWithFrame:CGRectMake(WIDETH/2.0, 0, WIDETH/2.0,50) ImageName:nil Target:self Action:@selector(commentClick:) Title:@"相关推荐"]
    ;
    [pushButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [pushButton setTitleColor:[UIColor colorWithRed:0.13f green:0.4f blue:0.91 alpha:1.00f]forState:UIControlStateSelected];
    pushButton.tag = 11;
    pushButton.titleLabel.font = [UIFont systemFontOfSize:20];
    [topView addSubview:pushButton];
    bottomLineView = [MyContol createImageViewWithFrame:CGRectMake((WIDETH /2- 120)/2, 47, 120, 3) ImageName:@"矩形 10.png"];
    bottomLineView.tag = 100;
    [topView addSubview:bottomLineView];
}
-(void)commentClick:(UIButton*)sender
{
    float index = sender.tag - 10;
    NSLog(@"%f",index);
    UIButton * btn0 = (UIButton *)[topView viewWithTag:10];
    UIButton * btn1 = (UIButton*)[topView viewWithTag:11];
    NSArray * tempArray = @[btn0,btn1];
    
    for (UIButton * btn in tempArray) {
        if (btn.tag - 10 == index) {
            btn.selected = YES;
        }else
        {
            btn.selected = NO;
        }
    }
    UIImageView *bottomLineViews = (UIImageView*)[topView viewWithTag:100];
    [UIView animateWithDuration:0.3 animations:^{
        bottomLineViews.frame = CGRectMake(WIDETH/2 * index + (WIDETH/2 - 120)/2, 47, 120, 3);
        _mainSC.contentOffset =CGPointMake(index*WIDETH, 0);
    }];
    
}
#pragma mark实现协议的方法
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGPoint point = scrollView.contentOffset;
    bottomLineView.frame = CGRectMake((WIDETH /2- 120)/2+point.x/2, 47, 120, 3);
    
    int index = (int)point.x/(WIDETH/2);
    UIButton * btn0 = (UIButton *)[topView viewWithTag:10];
    UIButton * btn1 = (UIButton*)[topView viewWithTag:11];
    if (index == 0) {
        btn0.selected = YES;
        btn1.selected = NO;
    }
    else if(index==2||index == 1)
    {
        btn0.selected = NO;
        btn1.selected = YES;
    }
    
    NSLog(@"%f~~~~%f",scrollView.contentOffset.x,scrollView.contentOffset.y);
}

-(void)createCommentView

{
    leftView = [[hotLeftView alloc] initWithFrame:CGRectMake(0, 0, WIDETH, _mainSC.frame.size.height)];
    leftView.coreID = self.courceId;
    [leftView commentloadData];
    [_mainSC addSubview:leftView];
    
    
}
#pragma mark 相关推荐
-(void)createPushView
{
    rightView = [[UIView alloc] initWithFrame:CGRectMake(WIDETH, 0, WIDETH, _mainSC.frame.size.height)];
    rightView.backgroundColor = [UIColor colorWithWhite:0.92 alpha:1];
    [_mainSC addSubview:rightView];
    _pushTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, WIDETH, rightView.frame.size.height) style:UITableViewStylePlain];
    _pushTableView.delegate = self;
    _pushTableView.dataSource = self;
    [rightView addSubview:_pushTableView];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.pushArray.count;
    
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PushTabelVewiCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ID"];
    if (!cell) {
        cell = [[PushTabelVewiCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ID"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    [cell config:self.pushArray[indexPath.row]];
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 130;
}
-(void)createView
{    _display = [[classDisplay alloc] initWithFrame:CGRectMake(0, 0, WIDETH, 170)];
//  _display.backgroundColor = [UIColor redColor];
    [self.view addSubview:_display];
    //底部选课卡
    bottomView = [[UIView alloc] initWithFrame:CGRectMake(0,HEIGHT - 50-64,WIDETH,50)];
    bottomView.backgroundColor = [UIColor colorWithRed:81/255.0 green:183/255.0 blue:235/255.0 alpha:1];
    [self.view addSubview:bottomView];
    selectClass = [MyContol createButtonWithFrame:CGRectMake(bottomView.frame.size.width/2.0 -30, 5, 60,HEIGHT* 45.0/667) ImageName:nil Target:self Action:@selector(slelectClass:) Title:@"选课"];
    selectClass.titleLabel.font = [UIFont systemFontOfSize:30];
    selectClass.selected = NO;
    //未选
    [selectClass setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    //已经选了
    [selectClass setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    [selectClass setTitle:@"已选" forState:UIControlStateSelected];
    [bottomView addSubview:selectClass];
    
}
-(void)refreshElectView
{
    
    if ([self.dic[@"isSelect"] isEqual:[NSNumber numberWithInt:1]]||[isSelect isEqual:[NSNumber numberWithInt:1]]) {
        selectClass.selected = YES;
    }else
    {
        
        selectClass.selected = NO;
    }
    
    
}
#pragma mark 选课
-(void)slelectClass:(UIButton*)sender
{ NSUserDefaults * user =[NSUserDefaults standardUserDefaults];
    NSString * stuID = [user objectForKey:@"sutdentId"];
    if (!stuID) {
        NSLog(@"你还没有登陆");
        MBProgressHUD* reginLoadView = [[MBProgressHUD alloc] initWithView:self.view];
        [self.view addSubview:reginLoadView];
        
        reginLoadView.mode = MBProgressHUDModeCustomView;
        reginLoadView.labelText = @"亲,你还没有登陆哟";
        [reginLoadView show:YES];
        [reginLoadView hide:YES afterDelay:1];
        reginLoadView = nil;
    }else if (sender.selected)
    {
        
        MBProgressHUD* reginLoadView = [[MBProgressHUD alloc] initWithView:self.view];
        [self.view addSubview:reginLoadView];
        
        reginLoadView.mode = MBProgressHUDModeCustomView;
        reginLoadView.labelText = @"该课程已经选过了";
        [reginLoadView show:YES];
        [reginLoadView hide:YES afterDelay:1];
        reginLoadView = nil;
    }else
    {
        [self elecLodData];
        
        NSLog(@"选课");
    }
}
-(void)elecLodData
{
    
    if (_electDownManager) {
        return;
    }
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *stuID = [user objectForKey:@"sutdentId"];
    
    NSString * urlstr = [NSString stringWithFormat:@"%@api/operateCourse/selectCourse.json?courseId=%@&studentId=%@",BASEURL,self.courceId,stuID];
    
    self.electDownManager = [[ImageDownManager alloc] init];
    _electDownManager.delegate = self;
    _electDownManager.OnImageDown = @selector(OnLoadFinish3:);
    _electDownManager.OnImageFail = @selector(OnLoadFail3:);
    [_electDownManager GetImageByStr:urlstr];
}
- (void)OnLoadFinish3:(ImageDownManager *)sender
{
    NSString *resStr = sender.mWebStr;
    NSDictionary *dict = [resStr JSONValue];
    [self Cancel3];
    
    if (dict&&[dict isKindOfClass:[NSDictionary class]] &&dict.count>0) {
        if ([dict[@"error_code"] isEqualToString:@"0"]) {
            NSLog(@"选课成功了");
            MBProgressHUD* reginLoadView = [[MBProgressHUD alloc] initWithView:self.view];
            [self.view addSubview:reginLoadView];
            
            reginLoadView.mode = MBProgressHUDModeCustomView;
            reginLoadView.labelText = @"选课成功了";
            [reginLoadView show:YES];
            [reginLoadView hide:YES afterDelay:1];
            reginLoadView = nil;
            
            NSLog(@"%@",dict[@"msg"]);
            isSelect = [NSNumber numberWithInt:1];
            
            [self refreshElectView];
            
            
        }
        else
        {
            MBProgressHUD* reginLoadView = [[MBProgressHUD alloc] initWithView:self.view];
            [self.view addSubview:reginLoadView];
            
            reginLoadView.mode = MBProgressHUDModeCustomView;
            reginLoadView.labelText = dict[@"msg"];
            [reginLoadView show:YES];
            [reginLoadView hide:YES afterDelay:1];
            reginLoadView = nil;
            
            NSLog(@"%@",dict[@"msg"]);
        }
    }
}

#pragma mark 开始下载
- (void)OnLoadFail3:(ImageDownManager *)sender
{
    [self Cancel3];
}
- (void)Cancel3 {
    //[self StopLoading];
    SAFE_CANCEL_ARC(self.electDownManager);
    
}




-(void)createNav
{
    //    self.title = @"我的首页";
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 80, 44)];
    titleLabel.text = @"课程展示";
    titleLabel.textColor =[UIColor whiteColor];
    titleLabel.font =[UIFont boldSystemFontOfSize:20];
    self.navigationItem.titleView = titleLabel;
    //左侧首页按钮
    UIButton * leftButton = [MyContol createButtonWithFrame:CGRectMake(15, 15, 14, 22) ImageName:@"back.png" Target:self Action:@selector(hotClassLeftClick) Title:nil];
    leftButton.titleLabel.font = [UIFont boldSystemFontOfSize:19];
    self.navigationItem.leftBarButtonItem =[[UIBarButtonItem alloc] initWithCustomView:leftButton];
    
}
#pragma mark --返回
-(void)hotClassLeftClick
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
