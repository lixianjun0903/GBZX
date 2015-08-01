

//
//  PublicCoureceViewController.m
//  干部在线
//
//  Created by lixianjun on 15-1-25.
//  Copyright (c) 2015年 中青年. All rights reserved.
//

#import "PublicCoureceViewController.h"
#import "ChildrenPublicLisenTableViewController.h"
#import "JSON.h"
#import "ImageDownManager.h"
#import "ChildrenPublicModel.h"
#import "ChildrenPublicTableViewCell.h"
@interface PublicCoureceViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    //焦点图
    UIScrollView * _sc ;
    //创建原点
    UIPageControl * _pageControl;
    UIImageView * imageView;
    UIImageView * imageView1;
    UIImageView * imageView2;
    UITableView * _tabelView;
    NSArray * imageArray;
    //选项卡
    UIView * backgroundView;
    BOOL flag;

}
@property (nonatomic,assign) BOOL m_bScreen;



@property (nonatomic, strong) ImageDownManager *mDownManager;
@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,strong)ImageDownManager * focDownManager;
@property(nonatomic,strong)NSMutableArray * focArray;
@end

@implementation PublicCoureceViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =[UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;
    self.dataArray = [NSMutableArray arrayWithCapacity:0];
    [self createNav];
    //焦点图
    [self createScroView];
    flag = YES;
    //定时器
    [self createTimer];
    [self createView];
    [self createTableView];
    [self loadData];
    [self focLoadData];

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
    self.focDownManager.delegate = nil;
}
#pragma mark 焦点图
-(void)focLoadData
{
    
    if (_focDownManager) {
        return;
    }
    
    NSString  *urlstr = [NSString stringWithFormat:@"%@api/information/getFocusImg.json",BASEURL];
    self.focDownManager = [[ImageDownManager alloc] init];
    _focDownManager.delegate = self;
    _focDownManager.OnImageDown = @selector(OnLoadFinish1:);
    _focDownManager.OnImageFail = @selector(OnLoadFail1:);
    [_focDownManager GetImageByStr:urlstr];
    
}
- (void)OnLoadFinish1:(ImageDownManager *)sender
{
    self.focArray = [NSMutableArray arrayWithCapacity:0];
    NSString *resStr = sender.mWebStr;
    NSDictionary *dict = [resStr JSONValue];
    [self Cancel1];
    NSArray * array1 = dict[@"data"];
    if (array1&&[array1 isKindOfClass:[NSArray class]] &&array1.count>0)
    {
        for (NSDictionary * dic in array1) {
            [self.focArray addObject:dic];
        }
        [self refreshFocus];
        
    }
}
-(void)refreshFocus
{
    float num  = self.focArray.count;
    for (int i = 0 ;i < num ; i++) {
        UIImageView * imageViews = (UIImageView *)[_sc viewWithTag:1000 + i];
        
        [imageViews sd_setImageWithURL:[NSURL URLWithString:self.focArray[i][@"imgUrl"]] placeholderImage:[UIImage imageNamed:imageArray[i]]];
        //设置第一张图片显示最后一张图片
        //imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, WIDETH, 150)];
        [imageView1 sd_setImageWithURL:[NSURL URLWithString:self.focArray[2][@"imgUrl"]] placeholderImage:[UIImage imageNamed:imageArray[2]]];
        //设置最后一张显示第一张
        //imageView = [[UIImageView alloc] initWithFrame:CGRectMake(WIDETH * 4, 0, WIDETH, 150)];
        [imageView2 sd_setImageWithURL:[NSURL URLWithString:self.focArray[0][@"imgUrl"]] placeholderImage:[UIImage imageNamed:imageArray[0]]];
        
    }
    
}
- (void)OnLoadFail1:(ImageDownManager *)sender {
    [self Cancel1];
}
- (void)Cancel1 {
    //[self StopLoading];
    SAFE_CANCEL_ARC(self.focDownManager);
    
}
#pragma mark 课程展示
-(void)loadData
{
    if (_mDownManager) {
        return;
    }
    
    NSString * urlstr;
    if (flag) {
        urlstr = [NSString stringWithFormat:@"%@api/publicCourse/getCourseListByHot.json",BASEURL];
    }
    else
    {
        urlstr = [NSString stringWithFormat:@"%@api/publicCourse/getCourseListByNew.json",BASEURL];
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
        for (NSDictionary *dic in array) {
            ChildrenPublicModel * model = [[ChildrenPublicModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            [self.dataArray addObject:model];
        }
        [_tabelView reloadData];
        
    }
}

- (void)OnLoadFail:(ImageDownManager *)sender {
    [self Cancel];
}
- (void)Cancel {
    //[self StopLoading];
    SAFE_CANCEL_ARC(self.mDownManager);
    
}
-(void)createView
{
    
    backgroundView =[[UIView alloc] initWithFrame:CGRectMake(0, 158, WIDETH, 54)];
    backgroundView.layer.borderWidth =1;
    backgroundView.layer.borderColor = [UIColor colorWithRed:0.94f green:0.94f blue:0.94f alpha:1.00f].CGColor;
    [self.view addSubview:backgroundView];
    NSArray * titleArray = @[@"最热",@"最新"];
    for (int i=0; i < titleArray.count ; i++) {
        UIButton * button = [MyContol createButtonWithFrame:CGRectMake(10+ i * 70, 10, 40, 40) ImageName:nil Target:self Action:@selector(buttonClick:) Title:titleArray[i]];
        button.tag = 10+i;
        if (i ==0) {
            button.selected = YES;
            
        }
        //正常的颜色
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        //选中的颜色
        [button setTitleColor:[UIColor blueColor] forState:UIControlStateSelected];
        [backgroundView addSubview:button];
    }
    UIImageView * bottomLineView = [MyContol createImageViewWithFrame:CGRectMake((WIDETH  /2- 120)/4 - 5, 51, 50, 3) ImageName:@"矩形 10.png"];
    bottomLineView.tag = 100;
    [backgroundView addSubview:bottomLineView];
}
-(void)buttonClick:(UIButton*)sender
{
    float index = sender.tag - 10;
    
    for (UIView *view in backgroundView.subviews)
        
    {
        if ([view isKindOfClass:[UIButton class]]) {
            UIButton * btn = (UIButton*)view;
            btn.selected = NO;
        }
        sender.selected = YES;
        
    }
    UIImageView *bottomLineView = (UIImageView*)[backgroundView viewWithTag:100];
    [UIView animateWithDuration:0.3 animations:^{
        bottomLineView.frame = CGRectMake(WIDETH/4 * index + (WIDETH/4 - 100)/4 -10, 51,50, 3);
    }];
    
    if (index == 0) {
        NSLog(@"最热");
        flag = YES;
    }
    if (index == 1) {
        NSLog(@"最新");
        flag = NO;
    }
    
}

-(void)createTableView
{
    _tabelView = [[UITableView alloc] initWithFrame:CGRectMake(0,214 , WIDETH, HEIGHT-214-64 ) style:UITableViewStylePlain];
    _tabelView.delegate = self;
    _tabelView.dataSource = self;
    // _tabelView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    //    _tabelView.backgroundColor =  [UIColor redColor];
    
    [self.view addSubview:_tabelView];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    ChildrenPublicTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ID"];
    if (!cell) {
        cell = [[ChildrenPublicTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ID"];
        //cell.selectionStyle =UITableViewCellSelectionStyleNone;
        
    }
    [cell config:self.dataArray[indexPath.row]];
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ChildrenPublicLisenTableViewController * vc = [[ChildrenPublicLisenTableViewController alloc] init];

    ChildrenPublicModel * model = self.dataArray[indexPath.row];
    vc.coureID = [NSString stringWithFormat:@"%@",model.courseId];
   vc.coureTitle = model.title;
   vc.navigationController.navigationBarHidden  =YES;
[self.navigationController pushViewController:vc animated:YES];
}
-(void)createTimer
{
    [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(nextClick) userInfo:nil repeats:YES];
}
-(void)createScroView
{
    _sc  = [[UIScrollView alloc] initWithFrame:CGRectMake(0,0, WIDETH, 150)];
    _sc.bounces = YES;
    _sc.showsHorizontalScrollIndicator = NO;
    _sc.pagingEnabled=YES;
    [self.view addSubview:_sc];
    _sc.contentSize = CGSizeMake(WIDETH *5, 150);
    imageArray = @[@"专题.png",@"kecheng.png",@"course_bg.png"];
    
    for (int i = 0; i < imageArray.count; i++) {
        imageView  = [[UIImageView alloc] initWithFrame:CGRectMake( WIDETH+ WIDETH * i , 0, WIDETH, 150)];
        imageView.tag = 1000 + i;
        
        imageView.image = [UIImage imageNamed:imageArray [i]];
        [_sc addSubview:imageView];
    }
    
    //    设置第一张图片显示最后一张图片
    imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, WIDETH, 150)];
    imageView1.image = [UIImage  imageNamed:imageArray[2]];
    [_sc addSubview:imageView1];
    //设置最后一张显示第一张
    imageView2 = [[UIImageView alloc] initWithFrame:CGRectMake(WIDETH *4, 0, WIDETH, 150)];
    imageView2.image = [UIImage imageNamed:imageArray[0]];
    [_sc addSubview:imageView2];
    
    //    UIImageView * imageView2 = [[UIImageView alloc] initWithFrame:CGRectMake(WIDETH * 4, 0, WIDETH, 150)];
    //    imageView2.image = [UIImage imageNamed:nil];
    //    [_sc addSubview:imageView2];
    //需要设置sc的偏移量
    _sc.contentOffset=CGPointMake(WIDETH, 0);
    //创建原点
    _pageControl   = [[UIPageControl alloc] initWithFrame:CGRectMake(160, 115, 50, 50)];
    _pageControl.currentPage = 0;
    _pageControl.numberOfPages = 3;
    [self.view addSubview:_pageControl];
    
}
-(void)nextClick{
    [UIView animateWithDuration:0.5 animations:^{
        
        _sc.contentOffset=CGPointMake(_sc.contentOffset.x+WIDETH, 0);
        _pageControl.currentPage +=1;
        
    }completion:^(BOOL finished) {
        
        if (_sc.contentOffset.x==WIDETH*4) {
            _sc.contentOffset=CGPointMake(WIDETH, 0);
            _pageControl.currentPage = 0;
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
    // Dispose of any resources that can be recreated.
}
-(void)createNav
{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 20)];
    view.backgroundColor = [UIColor blackColor];
    [self.navigationController.view addSubview:view];
    self.navigationController.navigationBar.barTintColor  = [UIColor colorWithRed:0.19f green:0.51f blue:0.93f alpha:1.00f];
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 80, 44)];
    titleLabel.text = @"公开课";
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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
