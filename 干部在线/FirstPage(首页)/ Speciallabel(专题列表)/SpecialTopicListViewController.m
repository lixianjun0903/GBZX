
//
//  SpecialTopicListViewController.m
//  干部在线
//
//  Created by lixianjun on 15-1-17.
//  Copyright (c) 2015年 中青年. All rights reserved.
//

#import "SpecialTopicListViewController.h"
#import "SpecialTopicTableViewCell.h"
#import "JSON.h"
#import "ImageDownManager.h"
#import "specialListModel.h"
@interface SpecialTopicListViewController ()<UITableViewDataSource,UITableViewDelegate>

{//选择全部课程
    UIButton * selectAllCourceButton;

    specialListModel * model;
    UITableView *_tableView;
}
@property (nonatomic, strong) ImageDownManager *mDownManager;
@property(nonatomic,strong)NSMutableArray *dataArray;

@property(nonatomic,strong)ImageDownManager * electDownManager;
@property(nonatomic,strong)NSMutableArray * electArray;

@end

@implementation SpecialTopicListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.dataArray = [NSMutableArray arrayWithCapacity:0];
        self.view.backgroundColor =[UIColor colorWithRed:0.89f green:0.89f blue:0.89f alpha:1.00f];
    [self createNav];
    [self createView];
    [self LoadData];
    
    // Do any additional setup after loading the view.
}
-(void)dealloc
{
    _mDownManager.delegate = nil;
    _electDownManager.delegate = nil;
}

#pragma mark 创建导航
-(void)createNav
{
    //标题
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 80, 44)];
     titleLabel.text = @"专题课程";
    titleLabel.textColor =[UIColor whiteColor];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont boldSystemFontOfSize:20];
    self.navigationItem.titleView = titleLabel;
    UIButton * leftButton = [MyContol createButtonWithFrame:CGRectMake(15, 15, 40, 20) ImageName:nil Target:self Action:@selector(topicListButton) Title:@"返回"];
    leftButton.titleLabel.font =[UIFont boldSystemFontOfSize:18];
    self.navigationItem.leftBarButtonItem =[[UIBarButtonItem alloc] initWithCustomView:leftButton];
    
}
#pragma mark  返回
-(void)topicListButton
{
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark 专题课程数据
-(void)LoadData
{
    if (_mDownManager) {
        return;
    }
    
    [self StartLoading];
    NSString * urlstr;
    
        urlstr = [NSString stringWithFormat:@"%@api/topicCourse/getTopicList.json",BASEURL];
  
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
   NSArray * array = dict[@"data"];
    
    
     if ( array&&[ array isKindOfClass:[NSArray class]] && array.count>0) {
    
         for (NSDictionary * dic in array) {
             [self.dataArray addObject:dic];
             
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
    //[self StopLoading];
    SAFE_CANCEL_ARC(self.mDownManager);
    
}
-(void)createView
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDETH, HEIGHT - 64) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return self.dataArray.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SpecialTopicTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ID"];
    if (!cell) {
        cell = [[SpecialTopicTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ID"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
               cell.delegate = self;
    }
    [cell config:self.dataArray[indexPath.row]];

    //选择全部课程
      selectAllCourceButton = [MyContol createButtonWithFrame:CGRectMake(cell.frame.size.width/2+20 , 290, cell.frame.size.width/2-10, 40) ImageName:nil Target:self Action:@selector(classButtonClick:) Title:@"选择全部课程"];
    selectAllCourceButton.layer.cornerRadius = 5;
    selectAllCourceButton.layer.masksToBounds = YES;
    selectAllCourceButton.backgroundColor =[UIColor colorWithRed:0.19f green:0.51f blue:0.94f alpha:1.00f];
////未选得状态
//    [selectAllCourceButton setTitleColor:[UIColor purpleColor] forState:UIControlStateNormal];
//    //已经选了的状态
//    [selectAllCourceButton setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
//    selectAllCourceButton.selected = NO;
    selectAllCourceButton.tag = indexPath.row;
    [cell addSubview:selectAllCourceButton];
    return cell;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    return 360;
}
//#pragma mark 更新按钮状态
//-(void)refreshElectView
//{
//    if (self.dataArray.count>0) {
//        specialListModel *model1 = [self.dataArray firstObject];
//        NSString *isSelect = [NSString stringWithFormat:@"%@",model1.isSelect];
//        if ([isSelect isEqualToString:@"1"]) {
//            selectAllCourceButton.selected =YES;
//        }
//        else
//        {
//            selectAllCourceButton.selected = NO;
//        }
//    }
//}
#pragma mark选择全部课程
-(void)classButtonClick:(UIButton*)sender
{
    int index = (int)sender.tag;
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
    else
    {
        [self electClick:index];
    }
//    if (sender.selected) {
//        NSLog(@"已选");
//        MBProgressHUD* electLoadView = [[MBProgressHUD alloc] initWithView:self.view];
//        [self.view addSubview:electLoadView];
//        
//        electLoadView.mode = MBProgressHUDModeCustomView;
//        electLoadView.labelText = @"已经选择了该门课程";
//        [electLoadView show:YES];
//        [electLoadView hide:YES afterDelay:1];
//        electLoadView = nil;
//        return;
//    }
    
}
-(void)electClick:(int)index
{
    if (_electDownManager) {
        return;
    }
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *stuID = [user objectForKey:@"sutdentId"];
    
    NSString * str = self.dataArray[index][@"topicId"];
    NSString * urlstr = [NSString stringWithFormat:@"%@api/topicCourse/selectAllCourse.json?topicId=%@&studentId=%@",BASEURL,str,stuID];
    
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
            reginLoadView.labelText = dict[@"msg"];
            [reginLoadView show:YES];
            [reginLoadView hide:YES afterDelay:1];
            reginLoadView = nil;

        }
        else
        {
        NSLog(@"%@",dict[@"msg"]);
            MBProgressHUD* reginLoadView = [[MBProgressHUD alloc] initWithView:self.view];
            [self.view addSubview:reginLoadView];
            reginLoadView.mode = MBProgressHUDModeCustomView;
            reginLoadView.labelText = dict[@"msg"];
            [reginLoadView show:YES];
            [reginLoadView hide:YES afterDelay:1];
            reginLoadView = nil;
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
