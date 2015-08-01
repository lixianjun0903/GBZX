//
//  ChildrenPublicLisenTableViewController.m
//  干部在线
//
//  Created by lixianjun on 15-2-2.
//  Copyright (c) 2015年 中青年. All rights reserved.
//

#import "ChildrenPublicLisenTableViewController.h"
#import "LTPlayerSDK.h"
#import "JSON.h"
#import "AppDelegate.h"
#import "ImageDownManager.h"
#import "ChildenLeftLisenView.h"
#import "ChildenRightLisenView.h"
@interface ChildrenPublicLisenTableViewController ()<LTPlayerDelegate,UIScrollViewDelegate>
{
    //评论和推荐
    UIImageView * bottomLineView;
    UIImageView * topView;
    //scroView
    UIScrollView * mainSC;
    //左右view
    ChildenLeftLisenView * LeftView;
    ChildenRightLisenView * RightView;
    
    //最新最热选项卡
    
    UIView * backgroundView;
    UITableView * _tabelView;
    
    UIView * navView;
  }

@property (nonatomic,assign) BOOL m_bScreen;
@property(nonatomic,strong)ImageDownManager *pulicLisenDownManager;
@property(nonatomic,strong)NSDictionary *lisenDic;
@end

@implementation ChildrenPublicLisenTableViewController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    UIApplication * app = [UIApplication sharedApplication];
    AppDelegate * delegate = (AppDelegate *)app.delegate;
    delegate.ori_flag = 1;
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    [LTPlayerSDK dismiss:YES];
    
    UIApplication * app = [UIApplication sharedApplication];
    AppDelegate * delegate = (AppDelegate *)app.delegate;
    delegate.ori_flag = 0;
    //    self.navigationController.navigationBarHidden  = NO;
    //    [navView removeFromSuperview];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //隐藏导航
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    self.view.backgroundColor =[UIColor whiteColor];
    [self createCommentAndPushView];
    [self createMainSC];
    [self createLeftView];
    [self createRightView];
    //底部选项卡
    [self createBottomView];
    [self loadData];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // 启动PlayerService
        [LTPlayerSDK startPlayerService];
    });
    

    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
-(void)dealloc
{
    _pulicLisenDownManager.delegate = self;
}
-(void)loadData
{
    if (_pulicLisenDownManager) {
        return;
    }
    
    [self StartLoading];
    
    NSString * urlstr = [NSString stringWithFormat:@"%@api/operateCourse/listenCourse.json?courseId=%@&isPublic=%@",BASEURL,self.coureID,[NSString stringWithFormat:@"%d",1]];
    
    self.pulicLisenDownManager = [[ImageDownManager alloc] init];
    _pulicLisenDownManager.delegate = self;
    _pulicLisenDownManager.OnImageDown = @selector(OnLoadFinish:);
    _pulicLisenDownManager.OnImageFail = @selector(OnLoadFail:);
    [_pulicLisenDownManager GetImageByStr:urlstr];
    
}
- (void)OnLoadFinish:(ImageDownManager *)sender
{
    NSString *resStr = sender.mWebStr;
    NSDictionary *dict = [resStr JSONValue];
    [self Cancel];
    
    if (dict && [dict isKindOfClass:[NSDictionary class]])
    {
        self.lisenDic = dict[@"data"];
        
        [self lisenDownload];
    }
    
}
-(void)lisenDownload
{
    
    UIView *view = [LTPlayerSDK getPlayerView];
    [LTPlayerSDK setPlayerViewFrame:CGRectMake(0, 21, WIDETH, 180)];
    [LTPlayerSDK setMoviePlayerShowStyle:LTMoviePlayerShowStyleCustomSize];
    [self.view addSubview:view];
    NSLog(@"%@",[LTPlayerSDK getLTPlayerSDKVersion]);
    
    NSString * userUnique = self.lisenDic[@"userUnique"];
    NSString * videoUnique  = self.lisenDic[@"videoUnique"];
    [LTPlayerSDK showWithUserUnique:userUnique
                        videoUnique:videoUnique
                          videoName:self.coureTitle
                          payerName:@"我的中国梦"
                          checkCode:@""
                                 ap:NO
                   inViewController:self
                     playerDelegate:self];
}
#pragma mark 开始下载
-(void)StartLoading
{
    
}
- (void)OnLoadFail:(ImageDownManager *)sender
{
    [self Cancel];
}
- (void)Cancel {
    
    SAFE_CANCEL_ARC(self.pulicLisenDownManager);
    
}
/*************************************************************/
- (void)viewWillLayoutSubviews {
    if (UIDeviceOrientationIsLandscape([UIDevice currentDevice].orientation)) {
        _m_bScreen = NO;
        //    navView.hidden = YES;
        //        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:NO];
        //                [self.navigationController setNavigationBarHidden:YES animated:YES];
        navView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDETH, 20)];
        navView.backgroundColor = [UIColor blackColor];
        [self.navigationController.view addSubview:navView];
        [LTPlayerSDK setPlayerViewFrame:CGRectMake(0, 0, WIDETH, HEIGHT)];
        [LTPlayerSDK setMoviePlayerShowStyle:LTMoviePlayerShowStyleFullScreen];
        
    }else{
        navView.hidden = NO;
        _m_bScreen = YES;
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
        
        [LTPlayerSDK setPlayerViewFrame:CGRectMake(0, 21, WIDETH, 220)];
        [LTPlayerSDK setMoviePlayerShowStyle:LTMoviePlayerShowStyleCustomSize];
    }
}
- (void) LTPlayerViewFullBtnClickEvent
{
    if ([[UIDevice currentDevice] respondsToSelector:@selector(setOrientation:)])
    {
        NSNumber *num = [[NSNumber alloc] initWithInt:(_m_bScreen?UIInterfaceOrientationLandscapeRight:UIInterfaceOrientationPortrait)];
        [[UIDevice currentDevice]performSelector:@selector(setOrientation:) withObject:(id)num];
        [UIViewController attemptRotationToDeviceOrientation];
    }
    SEL selector=NSSelectorFromString(@"setOrientation:");
    NSInvocation *invocation =[NSInvocation invocationWithMethodSignature:[UIDevice instanceMethodSignatureForSelector:selector]];
    [invocation setSelector:selector];
    [invocation setTarget:[UIDevice currentDevice]];
    int val = _m_bScreen?UIInterfaceOrientationLandscapeRight:UIInterfaceOrientationPortrait;
    [invocation setArgument:&val atIndex:2];
    [invocation invoke];
    
}
- (void) LTPlayerViewTopBackBtnClickEvent {
    
    [self LTPlayerViewFullBtnClickEvent];
}
// 视频开始播放
- (void)LTPlayerStartToPlay
{
    
    //   [LTPlayerSDK setMoviePlayerPlayeBackTime:1600];
    //   long int length =  [LTPlayerSDK LTPlayerGetVideoDuration];
    NSLog(@"开始播放");
    //[self createTimer];
}
// 视频播放失败
- (void)LTPlayerFailed
{
    NSLog(@"播放失败");
}
// 播放完成
- (void)LTPlayerDidFinishedWithUserUnique:(NSString *)userUnique
                              videoUnique:(NSString *)videoUnique
                                videoName:(NSString *)videoName
                                       ap:(BOOL)ap
{
    NSLog(@"视频播放完成");
    //播放完成的时候自动返回到CustomSize
    [self LTPlayerViewTopBackBtnClickEvent];
    
}
#pragma mark 设置播放器器的时间
-(NSTimeInterval)LTPlayerGetCurrentPlaybackTime:(NSString *)vid
{
    return 0;
    //      return (long)lastLearnedHour;
    
}

//***************************************************************************/
-(void)createCommentAndPushView{
    
    topView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 243, WIDETH, 50)];
    topView.image = [UIImage imageNamed:@""];
    // topView.backgroundColor = [UIColor grayColor];
    topView.layer.borderWidth = 0.8;
    topView.layer.borderColor = [UIColor colorWithRed:0.84f green:0.84f blue:0.84f alpha:1.00f].CGColor;
    topView.userInteractionEnabled =YES;
    [self.view addSubview:topView];
    
    //评论
    UIButton * commentButton = [MyContol createButtonWithFrame:CGRectMake(0, 0, WIDETH/2.0, 50) ImageName:nil Target:self Action:@selector(commentClick:) Title:@"评论"];
    
    [commentButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [commentButton setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
    commentButton.tag = 10;
    commentButton.titleLabel.font = [UIFont systemFontOfSize:20];
    commentButton.selected =YES;
    [topView addSubview:commentButton];
    
    //相关推荐
    UIButton * pushButton = [MyContol createButtonWithFrame:CGRectMake(WIDETH/2.0, 0, WIDETH/2.0,50) ImageName:nil Target:self Action:@selector(commentClick:) Title:@"相关推荐"]
    ;
    [pushButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [pushButton setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
    pushButton.tag = 11;
    pushButton.titleLabel.font = [UIFont systemFontOfSize:20];
    pushButton.selected = NO;
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
        mainSC.contentOffset =CGPointMake(index*WIDETH, 0);
    }];
    
}

-(void)createMainSC
{
    mainSC = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 293, WIDETH, HEIGHT-243-50-50)];
    
    mainSC.delegate  =self;
    //mainSC.backgroundColor = [UIColor greenColor];
    mainSC.showsHorizontalScrollIndicator = NO;
    mainSC.contentSize = CGSizeMake(WIDETH * 2, HEIGHT-293-50);
    mainSC.pagingEnabled = YES;
    [self.view addSubview:mainSC];
    
}
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

-(void)createLeftView
{
    LeftView = [[ChildenLeftLisenView alloc] initWithFrame:CGRectMake(0, 0, WIDETH, mainSC.frame.size.height)];
    LeftView.backgroundColor = [UIColor redColor];
    [mainSC addSubview:LeftView];
    mainSC.contentSize = CGSizeMake(WIDETH * 2, HEIGHT-50-293);
}
-(void)createRightView
{
    RightView = [[ChildenRightLisenView alloc] initWithFrame:CGRectMake(WIDETH, 0, WIDETH, mainSC.frame.size.height )];
    RightView.backgroundColor = [UIColor colorWithWhite:0.92 alpha:1];
    RightView.coureId = self.coureID;
    [RightView loadData];
    [mainSC addSubview:RightView];
    mainSC.contentSize = CGSizeMake(WIDETH * 2, HEIGHT-293-50);
    
}
#pragma  mark 底部选项卡
-(void)createBottomView
{
    NSArray  * imageArray =@[@"showmooc_back_icon.png",@"showmooc_note_icon.png",@"showmooc_download_icon.png",@"showmooc_share_icon.png",@"showmooc_talk_icon.png"];
    UIView * bgrView =[[UIView alloc] initWithFrame:CGRectMake(0, HEIGHT - 40, WIDETH, 40)];
    [self.view addSubview:bgrView];
    //添加bottom选项
    for (int i = 0; i < imageArray.count; i++) {
        UIButton * button = [MyContol createButtonWithFrame:CGRectMake(20+(bgrView.frame.size.width - 20)/5.0 * i , 0, 45,40) ImageName:imageArray[i] Target:self Action:@selector(ButtomButtonCick:) Title:nil];
        button.tag = 10+i;
        [bgrView addSubview:button];
    }
    
}
-(void)ButtomButtonCick:(UIButton*)sender
{
    float index = sender.tag - 10;
    if (index==0) {
        [self.navigationController popViewControllerAnimated:YES];
    }
    NSLog(@"底部按钮选项");
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
