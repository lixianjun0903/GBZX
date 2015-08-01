

//
//  SpecialClassDetailViewController.m
//  干部在线
//
//  Created by lixianjun on 15-1-2.
//  Copyright (c) 2015年 中青年. All rights reserved.
//

#import "SpecialClassDetailViewController.h"
#import "specialDetailCell.h"
#import "spcialTableViewCell.h"

#import "JSON.h"
#import "ImageDownManager.h"

#import "specialTabelModel.h"

@interface SpecialClassDetailViewController ()<UITableViewDataSource,UITableViewDelegate,MBProgressHUDDelegate>
{
     MBProgressHUD * mLoadView;
    UITableView * _tabelView;
    specialDetailCell * detailCell;
    //选课
    UIButton * selectButton;
    specialTabelModel * model;
}

@property (nonatomic, strong) ImageDownManager *detailDownManager;
@property(nonatomic,strong)NSDictionary * detailDic;


@property (nonatomic, strong) ImageDownManager *mDownManager;
@property(nonatomic,strong)NSMutableArray *dataArray;

@property(nonatomic,strong)ImageDownManager * electDownManager;

@end

@implementation SpecialClassDetailViewController
@synthesize mLoadMsg;
- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataArray =[NSMutableArray arrayWithCapacity:0];
    //self.view.backgroundColor  = [UIColor colorWithRed:0.89f green:0.89f blue:0.89f alpha:1.00f];
    self.view.backgroundColor =[UIColor whiteColor];
    [self ceateNav];
     [self createTabelView];
    [self createTopView];
    
    [self loadData1];
    [self loadData];
    
    
    
    
}
-(void)dealloc
{
    self.mDownManager.delegate = nil;
    self.electDownManager.delegate = nil;
}
#pragma mark 专题课程详情数据读取
-(void)loadData1
{
    if (_detailDownManager) {
        return;
    }
    [self StartLoading1];
    
    NSString * urlstr1;
    
    urlstr1 = [NSString stringWithFormat:@"%@api/topicCourse/getImportantTopicBySeq.json",BASEURL];
    
    
    
    self.detailDownManager = [[ImageDownManager alloc] init];
    _detailDownManager.delegate = self;
    _detailDownManager.OnImageDown = @selector(OnLoadFinish1:);
    _detailDownManager.OnImageFail = @selector(OnLoadFail1:);
    [_detailDownManager GetImageByStr:urlstr1];
    
}
- (void)OnLoadFinish1:(ImageDownManager *)sender
{
    
    NSString *resStr = sender.mWebStr;
    NSDictionary *dict = [resStr JSONValue];
    [self Cancel1];
    if (dict&&[dict isKindOfClass:[NSDictionary class]]&&dict.count>0) {
        self.detailDic  = [NSMutableDictionary dictionaryWithDictionary:dict[@"data"]];
        [detailCell config:self.detailDic];
        //        [self refreshTopView];
    }
}
-(void)createTopView
{
    
    detailCell = [[specialDetailCell alloc] initWithFrame:CGRectMake(10, -320,WIDETH- 20, 310)];
    detailCell.layer.cornerRadius = 6;
    detailCell.layer.masksToBounds =  YES;
    detailCell.backgroundColor =[UIColor whiteColor];
    
    [_tabelView addSubview:detailCell];
    //选课
    selectButton = [MyContol createButtonWithFrame:CGRectMake(WIDETH / 3.0 - 15, 270, WIDETH / 3.0, 40) ImageName:nil Target:selectButton Action:@selector(electButtonClick:) Title:nil];
    [selectButton setImage:[UIImage imageNamed:@"专题详情选课.png"] forState:UIControlStateNormal];
    selectButton.selected = NO;
    [selectButton setImage:[UIImage imageNamed:@"专题详情已选.png"] forState:UIControlStateSelected];
    
    //        if ([[NSString stringWithFormat:@"%@",[self.dataArray firstObject][@"isSelect"]]isEqualToString:@"1"])
    //        {
    //            [selectButton setImage:[UIImage imageNamed:@"退课.png"] forState:UIControlStateNormal];
    //        }
    //        else
    //        {
    //            [selectButton setImage:[UIImage imageNamed:@"选课退课.png"] forState:UIControlStateNormal];
    //        }
    selectButton.layer.cornerRadius = 10;
    [detailCell addSubview:selectButton];
    
}
-(void)refreshTopView
{
    if (self.dataArray.count>0) {
        specialTabelModel *model1 = [self.dataArray firstObject];
        NSString *isSelect = [NSString stringWithFormat:@"%@",model1.isSelect];
        if ([isSelect isEqualToString:@"1"]) {
            selectButton.selected =YES;
        }
        else
        {
            selectButton.selected = NO;
        }
    }
}
#pragma mark 选课按钮事件
-(void)electButtonClick:(UIButton *)sender
{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *stuID = [user objectForKey:@"sutdentId"];
    if (!stuID) {
        MBProgressHUD* reginLoadView = [[MBProgressHUD alloc] initWithView:self.view];
        [self.view addSubview:reginLoadView];
        
        reginLoadView.mode = MBProgressHUDModeCustomView;
        reginLoadView.labelText = @"你还没有登录无法选择";
        [reginLoadView show:YES];
        [reginLoadView hide:YES afterDelay:1];
        reginLoadView = nil;
        return;
    }
    if (sender.selected) {
        NSLog(@"已选");
        MBProgressHUD* electLoadView = [[MBProgressHUD alloc] initWithView:self.view];
        [self.view addSubview:electLoadView];
        
        electLoadView.mode = MBProgressHUDModeCustomView;
        electLoadView.labelText = @"已经选择了该门课程";
        [electLoadView show:YES];
        [electLoadView hide:YES afterDelay:1];
        electLoadView = nil;
        return;
    }
    
    [self electClick];
}
#pragma mark 选课
-(void)electClick
{
    if (_electDownManager) {
        return;
    }
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *stuID = [user objectForKey:@"sutdentId"];
    
    NSString * urlstr = [NSString stringWithFormat:@"%@api/topicCourse/selectAllCourse.json?topicId=%@&studentId=%@",BASEURL,self.topicID,stuID];
    
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
            for (int i = 0; i<self.dataArray.count; i++) {
                specialTabelModel *model2 = self.dataArray[i];
                model2.isSelect = [NSNumber numberWithInt:1];
                [self refreshTopView];
            }
            
        }
        else
        {
            
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



#pragma mark 开始下载
-(void)StartLoading1
{
    
}
- (void)OnLoadFail1:(ImageDownManager *)sender {
    [self Cancel1];
}
- (void)Cancel1 {
    //[self StopLoading];
    SAFE_CANCEL_ARC(self.detailDownManager);
    
}

//专题课程数量列表数据加载
-(void)loadData
{
    if (_mDownManager) {
        return;
    }
    
    [self StartLoading];
    mLoadView = [[MBProgressHUD alloc] initWithView:self.view];
    mLoadView.delegate = self;
    mLoadView.labelText = @"拼命加载中，请稍后";
    if (mLoadMsg) {
        mLoadView.mode = MBProgressHUDModeCustomView;
    }
    mLoadView.dimBackground = YES;
    [self.view addSubview:mLoadView];
    [mLoadView show:YES];
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *strID = [user objectForKey:@"sutdentId"];
    NSString * urlstr;
    if (!strID) {
        urlstr = [NSString stringWithFormat:@"%@api/topicCourse/getCourseList.json?topicId=%@",BASEURL,self.topicID];
        
        
    }else
    {
        urlstr = [NSString stringWithFormat:@"%@api/topicCourse/getCourseList.json?topicId=%@&studentId=%@",BASEURL,self.topicID,strID];
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
    NSArray *array = dict[@"data"];
    
    if (array&&[array isKindOfClass:[NSArray class]] &&array.count>0) {
        for (NSDictionary *dic in array) {
            model = [[specialTabelModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            [self.dataArray addObject:model];
        }
        [_tabelView reloadData];
        [self refreshTopView];
        
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
    //[self StopLoading];
    [mLoadView hide:YES];
    mLoadView = nil;
    SAFE_CANCEL_ARC(self.mDownManager);
    
}


#pragma mark ---创建createTabelView
-(void)createTabelView
{
    _tabelView =[[UITableView alloc] initWithFrame:CGRectMake(0,0 , WIDETH, self.view.frame.size.height-64) style:UITableViewStylePlain];
    _tabelView.delegate = self;
    _tabelView.dataSource = self;
    _tabelView.backgroundColor = [UIColor colorWithRed:0.89f green:0.89f blue:0.89f alpha:1.00f];
    _tabelView.contentInset = UIEdgeInsetsMake(330, 0, 0, 0);
    [self.view addSubview:_tabelView];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    spcialTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ID"];
    if (!cell) {
        cell = [[spcialTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ID"];
    }
    [cell config:self.dataArray[indexPath.row] row:(int)indexPath.row];
    //选课
    //    selectButton = [MyContol createButtonWithFrame:CGRectMake(WIDETH / 3.0 - 15, 270, WIDETH / 3.0, 40) ImageName:nil Target:selectButton Action:@selector(electButtonClick) Title:nil];
    //    specialTabelModel * dic = self.dataArray[0];
    //    if ([[NSString stringWithFormat:@"%@",dic.isSelect]isEqualToString:@"1"])
    //    {
    //        [selectButton setImage:[UIImage imageNamed:@"退课.png"] forState:UIControlStateNormal];
    //    }
    //    else
    //    {
    //        [selectButton setImage:[UIImage imageNamed:@"选课退课.png"] forState:UIControlStateNormal];
    //    }
    //    selectButton.layer.cornerRadius = 10;
    //    selectButton.layer.masksToBounds =YES;
    //    [detailCell addSubview:selectButton];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 110;
    
}

-(void)ceateNav
{
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 80, 44)];
    titleLabel.text = @"专题";
    titleLabel.textColor =[UIColor whiteColor];
    titleLabel.font =[UIFont boldSystemFontOfSize:20];
    self.navigationItem.titleView = titleLabel;
    UIButton * leftButton = [MyContol createButtonWithFrame:CGRectMake(15, 15, 40, 20) ImageName:nil Target:self Action:@selector(specialLeftClick) Title:@"返回"];
    leftButton.titleLabel.font = [UIFont boldSystemFontOfSize:19];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    
}
-(void)specialLeftClick
{
    NSLog(@"左边按钮事件");
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
