
//
//  StatictisViewController.m
//  干部在线
//
//  Created by lixianjun on 15-1-9.
//  Copyright (c) 2015年 中青年. All rights reserved.
//

#import "StatictisViewController.h"
#import "ImageDownManager.h"
#import "JSON.h"
@interface StatictisViewController ()
{
    
    UIScrollView * _SC;
    MBProgressHUD *mLoadView;
    //学习年度计划
    UILabel * titleLabel;
    //学习要求详情
    UILabel *studyDemandCoureceLabel;
    //完成时限
    UILabel * accomplishTimeLabel;
    //完成情况详情
    UILabel *accomplishDetailLabel;
    //笔记
    UILabel * noteLabel;
    //课程
    UILabel * coureLbelNumbel;
    //评论
    UILabel * commentLabel;
    //好友
    UILabel *friendLabel;
    //积分
    UILabel * countLabel;
    //排名
    UILabel * rankLabel;
    //学习时长
    UILabel * studyTimeLabel;
}
@property(nonatomic,strong)ImageDownManager * studyDemandDownManager;
@property(nonatomic,strong)ImageDownManager * accomplishDownManager;
@property(nonatomic,strong)ImageDownManager * coureNumDownManager;
@property(nonatomic,strong)NSDictionary * studyDemandDic;
@property(nonatomic,strong)NSDictionary * accomplishDic;
@property(nonatomic,strong)NSDictionary * coureNumDic;
@end

@implementation StatictisViewController
@synthesize mLoadMsg;
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor  = [UIColor colorWithRed:0.96f green:0.96f blue:0.96f alpha:1.00f];
    [self createNav];
    [self createSc];
    //头像
    [self cerateView];
    [self createDetail];
    [self studyDemandLoadData];
    [self accomplishLoadData];
    [self coureNumlaodData];
    
    // Do any additional setup after loading the view.
}

-(void)createSc
{

    _SC = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, WIDETH, HEIGHT-64)];
//    _SC.backgroundColor  = [UIColor redColor];
    [self.view addSubview:_SC];
}
#pragma mark 学习要求
-(void)studyDemandLoadData
{
    if (_studyDemandDownManager) {
        return;
    }
    [self StartLoading1];
    
    mLoadView = [[MBProgressHUD alloc] initWithView:self.view];
    if (mLoadMsg) {
        mLoadView.mode = MBProgressHUDModeCustomView;
        mLoadView.labelText = @"正在加载";
    }
    [self.view addSubview:mLoadView];
    
    [mLoadView show:YES];
    
    NSUserDefaults * user =[NSUserDefaults standardUserDefaults];
    NSString *strID = [user objectForKey:@"sutdentId"];
    NSString *  urlstr = [NSString stringWithFormat:@"%@api/statistics/getMyStudyPlan.json?studentId=%@",BASEURL,strID];
    self.studyDemandDownManager = [[ImageDownManager alloc] init];
    _studyDemandDownManager.delegate = self;
    _studyDemandDownManager.OnImageDown = @selector(OnLoadFinish1:);
    _studyDemandDownManager.OnImageFail = @selector(OnLoadFail1:);
    [_studyDemandDownManager GetImageByStr:urlstr];
    
}
- (void)OnLoadFinish1:(ImageDownManager *)sender
{
        NSString *resStr = sender.mWebStr;
    NSDictionary *dict = [resStr JSONValue];
    [self Cancel1];
    if (dict&&[dict isKindOfClass:[dict class]] &&dict.count>0) {
        self.studyDemandDic = [NSDictionary dictionaryWithDictionary:dict[@"data"]];
        [self refreshstudyDemand];
    }
}
-(void)refreshstudyDemand
{
    titleLabel.text = self.studyDemandDic[@"title"];
    studyDemandCoureceLabel.text = [NSString stringWithFormat:@"必修课（含公必修课考试）%@学时，选修课%@学习时，其中，公共科目考试%@项，%@学时",self.studyDemandDic[@"requirePeriod"],self.studyDemandDic[@"optionalPeriod"],self.studyDemandDic[@"examCourseCount"],self.studyDemandDic[@"studyPlanId"]];
    accomplishTimeLabel.text = [NSString stringWithFormat:@"完成时限：%@到2014年%@",self.studyDemandDic[@"startTime"],self.studyDemandDic[@"endTime"]];
    
}
#pragma mark 开始下载
-(void)StartLoading1
{
    
}
- (void)OnLoadFail1:(ImageDownManager *)sender {
    [self Cancel1];
}
- (void)Cancel1 {
    [mLoadView hide:YES];
    mLoadView = nil;
    SAFE_CANCEL_ARC(self.studyDemandDownManager);
    
}


#pragma mark完成情况
-(void)accomplishLoadData
{
    if (_accomplishDownManager) {
        return;
    }
    [self StartLoading2];
    NSUserDefaults * user =[NSUserDefaults standardUserDefaults];
    NSString *strID = [user objectForKey:@"sutdentId"];
    NSString *  urlstr = [NSString stringWithFormat:@"%@api/statistics/getMyStudyPlayProgress.json?studentId=%@",BASEURL,strID];
    self.accomplishDownManager = [[ImageDownManager alloc] init];
    _accomplishDownManager.delegate = self;
    _accomplishDownManager.OnImageDown = @selector(OnLoadFinish2:);
    _accomplishDownManager.OnImageFail = @selector(OnLoadFail2:);
    [_accomplishDownManager GetImageByStr:urlstr];
    
}
- (void)OnLoadFinish2:(ImageDownManager *)sender
{
    
    NSString *resStr = sender.mWebStr;
    NSDictionary *dict = [resStr JSONValue];
    [self Cancel2];
    if (dict&&[dict isKindOfClass:[dict class]] &&dict.count>0) {
        self.accomplishDic = [NSDictionary dictionaryWithDictionary:dict[@"data"]];
        [self accomplishrefresh];
    }
}
-(void)accomplishrefresh
{
    accomplishDetailLabel.text = [NSString stringWithFormat:@"必修课（含公必修课考试）已选%@学时，完成%@学时，选修课已选%@学时，完成%@学时",self.accomplishDic[@"requirePeriod"],self.accomplishDic[@"finishedRequirePeriod"],self.accomplishDic[@"optionalPeriod"],self.accomplishDic[@"finishedOptionalPPeriod"]];
    
}
#pragma mark 开始下载
-(void)StartLoading2
{
    
}
- (void)OnLoadFail2:(ImageDownManager *)sender {
    [self Cancel2];
}
- (void)Cancel2 {
       SAFE_CANCEL_ARC(self.accomplishDownManager);
    
}

#pragma mark 课程数量统计
-(void)coureNumlaodData
{
if (_coureNumDownManager) {
    return;
}
[self StartLoading3];
    NSUserDefaults * user =[NSUserDefaults standardUserDefaults];
    NSString *strID = [user objectForKey:@"sutdentId"];
  NSString *  urlstr = [NSString stringWithFormat:@"%@api/statistics/getStudyStatistics.json?studentId=%@",BASEURL,strID];
   self.coureNumDownManager = [[ImageDownManager alloc] init];
_coureNumDownManager.delegate = self;
_coureNumDownManager.OnImageDown = @selector(OnLoadFinish3:);
_coureNumDownManager.OnImageFail = @selector(OnLoadFail3:);
[_coureNumDownManager GetImageByStr:urlstr];

}
- (void)OnLoadFinish3:(ImageDownManager *)sender
{
        NSString *resStr = sender.mWebStr;
    NSDictionary *dict = [resStr JSONValue];
    [self Cancel3];
        if (dict&&[dict isKindOfClass:[dict class]] &&dict.count>0) {
            self.coureNumDic = [NSDictionary dictionaryWithDictionary:dict[@"data"]];
            [self coureNumDownrefresh];
    }
}
-(void)coureNumDownrefresh
{//课程
    coureLbelNumbel.text =[NSString stringWithFormat:@"课程:%@门",self.coureNumDic[@"courseCounts"]];
    //评论
    commentLabel.text = [NSString stringWithFormat:@"评论:%@条",self.coureNumDic[@"commentCounts"]];
    //笔记
    noteLabel.text =[NSString stringWithFormat:@"笔记:%@条",self.coureNumDic[@"noteCounts"]];
    //好友
    friendLabel.text =[NSString stringWithFormat:@"好友:%@位",self.coureNumDic[@"friendCounts"]];
    //积分
     countLabel.text = [NSString stringWithFormat:@"积分:%@",self.coureNumDic[@"creditCounts"]];
    //排名
    rankLabel.text =[NSString stringWithFormat:@"好友排名:%@名",self.coureNumDic[@"rank"]];
    //学习时长
   studyTimeLabel.text = [NSString stringWithFormat:@"学习总时长:%@分钟",self.coureNumDic[@"learnedHour"]];

}
#pragma mark 开始下载
-(void)StartLoading3
{
    
}
- (void)OnLoadFail3:(ImageDownManager *)sender {
    [self Cancel3];
}
- (void)Cancel3 {
SAFE_CANCEL_ARC(self.coureNumDownManager);
    
}

-(void)createDetail
{
    //学习要求view
    UIView * studyDemandView = [[UIView alloc] initWithFrame:CGRectMake(0, 225-64, WIDETH, 120)];
    studyDemandView.backgroundColor = [UIColor whiteColor];
    [_SC addSubview:studyDemandView];    //学习年度计划
    titleLabel = [MyContol createLabelWithFrame:CGRectMake(studyDemandView.frame
                                                                     .size.width /2.0- 90, 0, 190, 25) Font:19 Text:@"2014专业技术人才统计"];
    titleLabel.font  = [UIFont boldSystemFontOfSize:19];
    [studyDemandView addSubview:titleLabel];
    //学习要求
     UILabel * studyTitleLabel = [MyContol createLabelWithFrame:CGRectMake(15, 25, 100, 20) Font:17 Text:@"学习要求"];
    studyTitleLabel.textColor = [UIColor colorWithRed:0.3 green:0.34 blue:0.3 alpha:1];
    studyTitleLabel.font =[UIFont boldSystemFontOfSize:14];
    [studyDemandView addSubview:studyTitleLabel];
    //学习要求详情
   studyDemandCoureceLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 45, WIDETH-20, 56)];
    studyDemandCoureceLabel.text = @"必修课（含公必修课考试）37学时，选修课25学习时，其中，公共科目考试1一项，30学时";
    studyDemandCoureceLabel.numberOfLines = 0;
    studyDemandCoureceLabel.font = [UIFont systemFontOfSize:14];
    studyDemandCoureceLabel.textColor =[UIColor grayColor];
       [studyDemandView addSubview:studyDemandCoureceLabel];
    //完成时限
    accomplishTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 95, WIDETH-20, 20)];
    accomplishTimeLabel.text = @"完成时限：2014年4月10日到2014年12月31日";
    //accomplishTimeLabel.backgroundColor =[UIColor redColor];
    accomplishTimeLabel.textColor = [UIColor grayColor];
    accomplishTimeLabel.font = [UIFont systemFontOfSize:14];
    [studyDemandView addSubview:accomplishTimeLabel];
    
    //完成情况
    UIView * accomplishcircomentsView =[[UIView alloc]initWithFrame:CGRectMake(0, 350-64, WIDETH, 82) ];
   accomplishcircomentsView.backgroundColor = [UIColor whiteColor];
    [_SC addSubview:accomplishcircomentsView];
    UILabel *accomplishcircomentsLabel =[[UILabel alloc] initWithFrame:CGRectMake(15, 10, WIDETH-30, 20)];
    
    accomplishcircomentsLabel.text =@"完成情况";
    accomplishcircomentsLabel.font = [UIFont boldSystemFontOfSize:17];
    accomplishcircomentsLabel.textColor = [UIColor colorWithRed:0.3 green:0.34 blue:0.3 alpha:1];
    [accomplishcircomentsView addSubview:accomplishcircomentsLabel];
    //完成情况详情
    accomplishDetailLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 35, WIDETH - 30, 50)];
    accomplishDetailLabel.text = @"必修课（含公必修课考试）已选87学时，完成12学时，选修课已选23学时，完成0学时";
    accomplishDetailLabel.numberOfLines = 0;
    accomplishDetailLabel.font = [UIFont systemFontOfSize:14];
    accomplishDetailLabel.textColor = [UIColor grayColor];
    [accomplishcircomentsView addSubview:accomplishDetailLabel];
   
    //学习课程统计View
    UIView * courceNumView = [[UIView alloc] initWithFrame:CGRectMake(0, 440-64, WIDETH, 120)];
   courceNumView.backgroundColor =[UIColor whiteColor];
    [_SC addSubview:courceNumView];
    //课程
     coureLbelNumbel = [MyContol createLabelWithFrame:CGRectMake(15, 5, 150, 20) Font:14 Text:@"课程：35门"];
    coureLbelNumbel.textColor =[UIColor grayColor];
    [courceNumView addSubview:coureLbelNumbel];
    //评论
     commentLabel = [MyContol createLabelWithFrame:CGRectMake(WIDETH  /2.0, 5, 150, 20) Font:14 Text:@"评论：50条"];
    commentLabel.textColor =[UIColor grayColor];
    [courceNumView addSubview:commentLabel];
    //笔记
     noteLabel = [MyContol createLabelWithFrame:CGRectMake(15, 30, 150, 20) Font:15 Text:@"笔记:35条"];
    noteLabel.textColor = [UIColor grayColor];
    [courceNumView addSubview:noteLabel];
    //好友
    friendLabel = [MyContol createLabelWithFrame:CGRectMake( WIDETH/2.0, 30,120, 20) Font:14 Text:@"好友：34个"];
    friendLabel.textColor =[UIColor grayColor];
    [courceNumView addSubview:friendLabel];
    //积分
     countLabel = [MyContol createLabelWithFrame:CGRectMake(15, 55, 150, 20) Font:14 Text:@"积分：500"];
    countLabel.textColor =[UIColor grayColor];
    [courceNumView addSubview:countLabel];
//排名
     rankLabel =[MyContol createLabelWithFrame:CGRectMake(WIDETH/2.0, 55, 150, 20) Font:14 Text:@"好友排名：200"];
    rankLabel.textColor =[UIColor grayColor];
    [courceNumView addSubview:rankLabel];
    //学习时长
     studyTimeLabel = [MyContol createLabelWithFrame:CGRectMake(15, 80, 200, 20) Font:15 Text:@"学习总的时长：300分钟"];
    studyTimeLabel.textColor = [UIColor grayColor];
    [courceNumView addSubview:studyTimeLabel];
    
    
    
    _SC.contentSize = CGSizeMake(WIDETH, 120+120+90+160+120);
    
}
#pragma mark 创建view
-(void)cerateView
{
    UIImageView * backGroundImageView =[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, WIDETH, 160)];
    backGroundImageView.image =[UIImage imageNamed:@"图层 30.png"];
    [_SC addSubview:backGroundImageView];
    //头像
    UIButton * titleButton = [MyContol createButtonWithFrame:CGRectMake(WIDETH/2.0 -35, backGroundImageView .frame.size.height / 2.0 - 35, 70, 70) ImageName:@"yh_icon_头像.png" Target:self Action:@selector(titleStatisClick) Title:nil];
    [backGroundImageView addSubview:titleButton];
}
-(void)titleStatisClick
{
    NSLog(@"我的统计");
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
    
    UILabel *NavtitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 80, 44)];
    NavtitleLabel.text = @"学习统计";
    NavtitleLabel.textColor =[UIColor whiteColor];
    NavtitleLabel.textAlignment = NSTextAlignmentCenter;
    NavtitleLabel.font = [UIFont boldSystemFontOfSize:20];
    self.navigationItem.titleView = NavtitleLabel;
    UIButton * leftButton = [MyContol createButtonWithFrame:CGRectMake(5, 15, 14, 22) ImageName:@"back.png" Target:self Action:@selector(StaticsLeftClick) Title:nil];
    leftButton.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    self.navigationItem.leftBarButtonItem =[[UIBarButtonItem alloc] initWithCustomView:leftButton];
    _SC.contentSize = CGSizeMake(WIDETH, 120+ 120 + 90+160);
}
-(void)StaticsLeftClick
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
