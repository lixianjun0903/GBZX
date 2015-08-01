
//
//  ClassEveryViewController.m
//  干部在线
//
//  Created by lixianjun on 14-12-30.
//  Copyright (c) 2014年 中青年. All rights reserved.
//

#import "ClassEveryViewController.h"
#include "evreyClassNumberTableViewCell.h"
#import "LisenCourceViewController.h"
#import "LisenRightView.h"
#import "ImageDownManager.h"
#import "JSON.h"
#import "PublicLisenViewController.h"
#import "MyViewController.h"
@interface ClassEveryViewController ()<UITableViewDelegate,UITableViewDataSource,MBProgressHUDDelegate,UIAlertViewDelegate>
{
    MBProgressHUD * mLoadView;
    //热门最新背景view
    UITableView *_tabelView;
    //背景View
    UIView * childrenView;
    //最新最热按钮背景view
    UIView * backgroundView ;
    float flag;
    int height;
    
    int num;
}
@property (nonatomic, strong) ImageDownManager *mDownManager;
@property(nonatomic,strong)NSMutableArray *dataArray;

@property (nonatomic, strong) ImageDownManager *childrenDownManager;
@property(nonatomic,strong)NSMutableArray *childrenDataArray;

@property(nonatomic,strong)ImageDownManager *secDownManager;
@property(nonatomic,strong)ImageDownManager * retreatDownManager;
@end

@implementation ClassEveryViewController
@synthesize mLoadMsg;
-(void)viewWillAppear:(BOOL)animated
{
[self.navigationController setNavigationBarHidden:NO animated:YES];
   [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
}

- (void)viewDidLoad{
    [super viewDidLoad];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
    height = 0;
    [self createNav];
    [self createHotAndNew];
    [self ceateTableView];
    self.dataArray = [NSMutableArray arrayWithCapacity:0];
    self.childrenDataArray = [NSMutableArray arrayWithCapacity:0];
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    [self childrenLoadData];
   
    flag= YES;
   
    // Do any additional setup after loading the view.
}
-(void)dealloc
{
    _mDownManager.delegate = nil;
    _childrenDownManager.delegate = nil;
    _secDownManager.delegate = nil;
    _retreatDownManager.delegate = nil;

}
-(void)childrenLoadData
{
    if (_childrenDownManager) {
        return;
    }
    
    [self StartLoading1];
    
     NSString * urlstr1 = [NSString stringWithFormat:@"%@api/course/getChildCategoryList.json?categoryId=%@",BASEURL,self.cagoryID];
    
    self.childrenDownManager = [[ImageDownManager alloc] init];
    _childrenDownManager.delegate = self;
    _childrenDownManager.OnImageDown = @selector(OnLoadFinish1:);
    _childrenDownManager.OnImageFail = @selector(OnLoadFail1:);
    [_childrenDownManager GetImageByStr:urlstr1];
   }
- (void)OnLoadFinish1:(ImageDownManager *)sender
{
    NSString *resStr = sender.mWebStr;
    NSDictionary *dict = [resStr JSONValue];
    [self Cancel1];
    
    NSArray *array = dict[@"data"];
    if (array&&[array isKindOfClass:[NSArray class]] &&array.count>0) {
        for (NSDictionary *dic in array) {
     [self.childrenDataArray addObject:dic];
        }
        [self childrenRefresh];
        self.cagoryID2 = [self.childrenDataArray firstObject][@"categoryId"];
        [self loadData];
    }
    else
    {
        self.cagoryID2 = self.cagoryID;
         [self loadData];
    }
}
-(void)childrenRefresh
{//背景View
     childrenView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDETH, 50)];
    [self.view addSubview:childrenView];
    float count = self.childrenDataArray.count;
    for (int i = 0 ;i< count; i++) {
//        UIButton * childrenButton = [MyContol createButtonWithFrame:CGRectMake(10+ i %3 * (WIDETH - 10)/3.0, 5+i/3 * 45, (WIDETH - 20)/3.0 -10, 40) ImageName:nil Target:self Action:@selector(childrenDetailLoadData:) Title:self.childrenDataArray[i][@"categoryName"]];
        UIButton * childrenButton = [MyContol createButtonWithFrame:CGRectMake(10+ i %2 * (WIDETH - 10)/2.0, 5+i/2 * 50, (WIDETH - 20)/2.0 -10, 40) ImageName:nil Target:self Action:@selector(childrenDetailLoadData:) Title:self.childrenDataArray[i][@"categoryName"]];
childrenButton.backgroundColor = [UIColor colorWithRed:0.98f green:0.98f blue:0.98f alpha:1.00f];
        
        childrenButton.tag = 10+i;
        if (childrenButton.tag ==10) {
            childrenButton.selected = YES;
        }
        childrenButton.layer.cornerRadius = 3;
        childrenButton.layer.masksToBounds = YES;
        childrenButton.layer.borderWidth = 0.8;
        childrenButton.layer.borderColor = [UIColor colorWithRed:0.53f green:0.53f blue:0.53f alpha:1.00f].CGColor;
        
        childrenButton.layer.borderColor = [UIColor colorWithRed:0.89f green:0.89f blue:0.89f alpha:1.00f].CGColor;
//        float a=arc4random()%256/255.0;
//        float b=arc4random()%256/255.0;
//        float c=arc4random()%256/255.0;
//        childrenButton.backgroundColor=[UIColor colorWithRed:a green:b blue:c alpha:0.5];
        //设置字体
        childrenButton.titleLabel.font = [UIFont systemFontOfSize:15];
        //childrenButton.titleLabel.adjustsFontSizeToFitWidth = YES;
        childrenButton.titleLabel.lineBreakMode = UILineBreakModeTailTruncation;
        childrenButton.titleLabel.numberOfLines = 1;
        //未选中的颜色
        [childrenButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        //选中的颜色
        [childrenButton setTitleColor:[UIColor colorWithRed:0.1 green:0.3 blue:0.98 alpha:1] forState:UIControlStateSelected];
         [childrenView addSubview:childrenButton];
        height =i/2 * 50+52;
        _tabelView.frame =CGRectMake(0, 54+height, WIDETH, HEIGHT-118+64- height);
        backgroundView.frame =CGRectMake(0, height, WIDETH, 54);
        childrenView.frame = CGRectMake(0, 0, WIDETH, height);
       
    }
}
-(void)childrenDetailLoadData:(UIButton*)sender
{
       for (UIView *view in childrenView.subviews)
    {
    if ([view isKindOfClass:[UIButton class]])
    {
        UIButton * btn = (UIButton*)view;
        btn.selected = NO;
    }
    sender.selected = YES;
    
}
    self.cagoryID2 = self.childrenDataArray[sender.tag-10][@"categoryId"];
    [self loadData];

    NSLog(@"刷新三级分类下的课程");

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
   
    SAFE_CANCEL_ARC(self.childrenDownManager);
    
}
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
    
        if (flag == YES) {
             urlstr = [NSString stringWithFormat:@"%@api/course/getHotCourseListByCategoryId.json?categoryId=%@",BASEURL,self.cagoryID2];
        }
        else
        {
       
        urlstr = [NSString stringWithFormat:@"%@api/course/getNewCourseListByCategoryId.json?categoryId=%@",BASEURL,self.cagoryID2];
        }
        
    }
    else
    {
        if (flag) {
            urlstr = [NSString stringWithFormat:@"%@api/course/getHotCourseListByCategoryId.json?categoryId=%@&studentId=%@",BASEURL,self.cagoryID2,strID];
            NSLog(@"最热数据刷新flag=YES");
        }
        else
        {
 
        urlstr = [NSString stringWithFormat:@"%@api/course/getNewCourseListByCategoryId.json?categoryId=%@&studentId=%@",BASEURL,self.cagoryID2,strID];
            NSLog(@"最新数据刷新flag=NO");
        }
    }
    
    self.mDownManager = [[ImageDownManager alloc] init];
    _mDownManager.delegate = self;
    _mDownManager.OnImageDown = @selector(OnLoadFinish:);
    _mDownManager.OnImageFail = @selector(OnLoadFail:);
    [_mDownManager GetImageByStr:urlstr];
//    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:0];
//    [dic setObject: @""forKey:@"studentId"];
//    [dic setObject:@"" forKey:@"courseId"];
//    [_mDownManager PostHttpRequest:urlstr :dic];
    
}
- (void)OnLoadFinish:(ImageDownManager *)sender
{
    NSString *resStr = sender.mWebStr;
    NSDictionary *dict = [resStr JSONValue];
    [self Cancel];
    NSDictionary *d = dict[@"data"];
    NSArray *array = d[@"data"];
    if (array&&[array isKindOfClass:[NSArray class]] &&array.count>0) {
        [self.dataArray removeAllObjects];
        for (NSDictionary *dic in array) {
            ClassEveryModel * model = [[ClassEveryModel alloc] init];
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
- (void)OnLoadFail:(ImageDownManager *)sender
{
    [self Cancel];
}
- (void)Cancel {
    //[self StopLoading];
    [mLoadView hide:YES];
    mLoadView = nil;
    SAFE_CANCEL_ARC(self.mDownManager);
    
}

-(void)ceateTableView
{
    _tabelView = [[UITableView alloc] initWithFrame:CGRectMake(0, 55, WIDETH, HEIGHT-118) style:UITableViewStylePlain];
    _tabelView.delegate = self;
    _tabelView.dataSource = self;
    _tabelView.backgroundColor =  [UIColor whiteColor];
    
    [self.view addSubview:_tabelView];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    evreyClassNumberTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ID"];
    if (!cell) {
        cell = [[evreyClassNumberTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ID"];
        cell.selectionStyle =UITableViewCellSelectionStyleNone;
        
    }
    cell.accessoryView = nil;
    ClassEveryModel *dic = self.dataArray[indexPath.row];
    UIButton *choseBtn = [[UIButton alloc]initWithFrame:CGRectMake(1100, 8880, 45, 30)];
    if ([[NSString stringWithFormat:@"%@",dic.isSelect]isEqualToString:@"1"])
    {
       [choseBtn setImage:[UIImage imageNamed:@"退课1.png"] forState:UIControlStateNormal];
    }
    else
    {
        [choseBtn setImage:[UIImage imageNamed:@"选课1.png"]forState:UIControlStateNormal];
    }
    
    [choseBtn addTarget:self action:@selector(choseClick:) forControlEvents:UIControlEventTouchUpInside];
    choseBtn.tag = indexPath.row;
    cell.accessoryView = choseBtn;

    [cell config:self.dataArray[indexPath.row]];
    return cell;
    
}
-(void)choseClick:(UIButton *)sender
{
    int index = (int)sender.tag;
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSNumber *stuId = [user objectForKey:@"sutdentId"];
    if (!stuId) {
        
//    MyViewController * myloginView = [[MyViewController alloc] init]
//        ;
//       myloginView.electRecord = @"ddddddd";
//        [self.navigationController pushViewController:myloginView animated:YES];
//        
        NSLog(@"你还没有登陆");
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"登陆后才能选课" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        alert.delegate = self;
        [alert show];
        return;
    }else 
    {     ClassEveryModel * dic = self.dataArray[index];
    if (![[NSString stringWithFormat:@"%@",dic.isSelect]isEqualToString:@"1"]) {
        [self choseLoad:index];
    }
    else if([[NSString stringWithFormat:@"%@",dic.isSelect]isEqualToString:@"1"])
    {
        [self retreatCourece:index];
    
    }
    }
//    else
//    {
//        
//    }
}
#pragma marks -- UIAlertViewDelegate --
//根据被点击按钮的索引处理点击事件
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==1) {
            MyViewController * myloginView = [[MyViewController alloc] init]
                ;
               myloginView.electRecord = @"ddddddd";
                [self.navigationController pushViewController:myloginView animated:YES];
                 }
    NSLog(@"clickButtonAtIndex:%ld",(long)buttonIndex);
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 115;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
//    PublicLisenViewController  * lisen =[[PublicLisenViewController alloc] init];
  LisenCourceViewController *lisen =[[LisenCourceViewController alloc] init];
    ClassEveryModel * model =self.dataArray[indexPath.row];
    lisen.coureID = [NSString stringWithFormat:@"%@",model.courseId];
    lisen.courceTitle = model.title;
    lisen.hidesBottomBarWhenPushed = YES;
//    NSString * isSelect = [model.isSelect stringValue];
//    
//    if ([isSelect  isEqual: @"1"])
    if ([[NSString stringWithFormat:@"%@",model.isSelect] isEqualToString:@"1"])
    {
        [self.navigationController pushViewController:lisen animated:YES];
    }else
    {
        MBProgressHUD* electLoadView = [[MBProgressHUD alloc] initWithView:self.view];
        [self.view addSubview:electLoadView];
        
        electLoadView.mode = MBProgressHUDModeCustomView;
        electLoadView.labelText = @"先选课才能听课";
        [electLoadView show:YES];
        [electLoadView hide:YES afterDelay:1.5];
        electLoadView = nil;
    }

}
#pragma mark 导航
-(void)createNav
{
   
    //课程展示
    //    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 80, 44)];
    //    titleLabel.text = @"课程展示 ";
    //    self.navigationItem.titleView = titleLabel;
//    
//    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 80, 44)];
//    titleLabel.text = @"课程列表";
//    titleLabel.font =[UIFont boldSystemFontOfSize:20];
//    titleLabel.textColor =[UIColor whiteColor];
//    self.navigationItem.titleView = titleLabel;
//    //左侧首页按钮
    if (iOS7) {
        [self.navigationController.navigationBar
         
         setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont boldSystemFontOfSize:20]}];
    }else{
        [self.navigationController.navigationBar setTitleTextAttributes:@{UITextAttributeTextColor: [UIColor whiteColor],UITextAttributeFont : [UIFont boldSystemFontOfSize:20]}];
    }

    UIButton * leftButton = [MyContol createButtonWithFrame:CGRectMake(15, 15, 14, 22) ImageName:@"back.png" Target:self Action:@selector(ElectLeftClick) Title:nil];
    leftButton.titleLabel.font =[UIFont boldSystemFontOfSize:18];
    self.navigationItem.leftBarButtonItem =[[UIBarButtonItem alloc] initWithCustomView:leftButton];
    
}
-(void)ElectLeftClick
{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark 热门最新最热选项条
-(void)createHotAndNew
{
    
    //热门最新最热选项条
    backgroundView =[[UIView alloc] initWithFrame:CGRectMake(0, height, WIDETH, 54)];
    backgroundView.layer.borderWidth = 0.5;
    backgroundView.layer.borderColor = [UIColor colorWithRed:0.89f green:0.89f blue:0.89f alpha:1.00f].CGColor;
    [self.view addSubview:backgroundView];
    NSArray * titleArray = @[@"最热",@"最新"];
    for (int i=0; i < titleArray.count ; i++) {
        UIButton * button = [MyContol createButtonWithFrame:CGRectMake(10+ i * 70, 10, 40, 40) ImageName:nil Target:self Action:@selector(buttonClick:) Title:titleArray[i]];
        button.tag = 10+i;
        if (button.tag==10) {
            button.selected = YES;
        }
        //正常的颜色
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        //选中的颜色
        [button setTitleColor:[UIColor blueColor] forState:UIControlStateSelected];
        [backgroundView addSubview:button];
    }
    UIImageView * bottomLineView = [MyContol createImageViewWithFrame:CGRectMake((WIDETH  /2- 120)/4 - 13, 51, 50, 3) ImageName:@"矩形 10.png"];
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
//        bottomLineView.frame = CGRectMake(WIDETH/4 * index + (WIDETH/2 - 110)/4 -25, 51,50, 3);
           bottomLineView.frame = CGRectMake(52*index+((index+1) *(WIDETH  /2- 120)/4 - 13), 51,50, 3);
        
    }];
    
    
    if (sender.tag == 10) {
        flag = YES;
        [self.dataArray removeAllObjects];
        [self loadData];
        NSLog(@" 最热");
    }
    else if (sender.tag ==11) {
        flag = NO;
        [self.dataArray removeAllObjects];
        [self loadData];
        NSLog(@"最新");
    }
//
//    if (index == 0) {
//        NSLog(@"最热");
//        flag = YES;
//    }
//    if (index == 1) {
//        NSLog(@"最新");
//        flag = NO;
//    }
    
}
#pragma mark 退课
-(void)retreatCourece:(int)retreatCouceNum
{
    num = retreatCouceNum;
    if (_retreatDownManager) {
        return;
    }
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *stuID = [user objectForKey:@"sutdentId"];
    ClassEveryModel *model = self.dataArray[num];
    NSString * urlstr = [NSString stringWithFormat:@"%@api/operateCourse/cancleCourse.json?courseId=%@&studentId=%@",BASEURL,model.courseId,stuID];
    
    self.retreatDownManager = [[ImageDownManager alloc] init];
    _retreatDownManager.delegate = self;
    _retreatDownManager.OnImageDown = @selector(OnLoadFinish4:);
    _retreatDownManager.OnImageFail = @selector(OnLoadFail4:);
    [_retreatDownManager GetImageByStr:urlstr];
}
- (void)OnLoadFinish4:(ImageDownManager *)sender
{
    NSString *resStr = sender.mWebStr;
    NSDictionary *dict = [resStr JSONValue];
    [self Cancel4];
    if (dict&&[dict isKindOfClass:[NSDictionary class]] &&dict.count>0) {
        if ([dict[@"error_code"] isEqualToString:@"0"]) {
            NSLog(@"退课成功了");
            MBProgressHUD* mLoadView1 = [[MBProgressHUD alloc] initWithView:self.view];
            [self.view addSubview:mLoadView1];
            
            mLoadView1.mode = MBProgressHUDModeCustomView;
            mLoadView1.labelText = dict[@"msg"];
            [mLoadView1 show:YES];
            [mLoadView1 hide:YES afterDelay:3];
            mLoadView1 = nil;
            ClassEveryModel *dic = self.dataArray[num];
            dic.isSelect =[NSNumber numberWithInt:0];
            [_tabelView reloadData];
            
            
        }
        else
        {
            MBProgressHUD* mLoadView1 = [[MBProgressHUD alloc] initWithView:self.view];
            [self.view addSubview:mLoadView1];
            
            mLoadView1.mode = MBProgressHUDModeCustomView;
            mLoadView1.labelText = dict[@"msg"];
            [mLoadView1 show:YES];
            [mLoadView1 hide:YES afterDelay:3];
            mLoadView1 = nil;
            NSLog(@"%@",dict[@"msg"]);
        }
    }
}

#pragma mark 开始下载
- (void)OnLoadFail4:(ImageDownManager *)sender
{
    [self Cancel4];
}
- (void)Cancel4 {
    //[self StopLoading];
    SAFE_CANCEL_ARC(self.retreatDownManager);
    
}


#pragma mark   选课
-(void)choseLoad:(int)num1
{
    num = num1;
    if (_secDownManager) {
        return;
    }
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *stuID = [user objectForKey:@"sutdentId"];
    ClassEveryModel *model = self.dataArray[num];
    NSString * urlstr = [NSString stringWithFormat:@"%@api/operateCourse/selectCourse.json?courseId=%@&studentId=%@",BASEURL,model.courseId,stuID];
    
    self.secDownManager = [[ImageDownManager alloc] init];
    _secDownManager.delegate = self;
    _secDownManager.OnImageDown = @selector(OnLoadFinish3:);
    _secDownManager.OnImageFail = @selector(OnLoadFail3:);
    [_secDownManager GetImageByStr:urlstr];
}
- (void)OnLoadFinish3:(ImageDownManager *)sender
{
    NSString *resStr = sender.mWebStr;
    NSDictionary *dict = [resStr JSONValue];
    [self Cancel3];
    if (dict&&[dict isKindOfClass:[NSDictionary class]] &&dict.count>0) {
        if ([dict[@"error_code"] isEqualToString:@"0"]) {
            NSLog(@"选课成功了");
            ClassEveryModel *dic = self.dataArray[num];
            dic.isSelect =[NSNumber numberWithInt:1];
            [_tabelView reloadData];
            //提示框
        MBProgressHUD* mLoadView1 = [[MBProgressHUD alloc] initWithView:self.view];
            [self.view addSubview:mLoadView1];
            
            mLoadView1.mode = MBProgressHUDModeCustomView;
            mLoadView1.labelText = dict[@"msg"];
            [mLoadView1 show:YES];
            [mLoadView1 hide:YES afterDelay:1];
            mLoadView1 = nil;
        }
        else
        {
            UIAlertView * elview = [[UIAlertView alloc] initWithTitle:@"我的选课" message:dict[@"msg"] delegate:nil cancelButtonTitle:nil otherButtonTitles:nil, nil];
            [elview show];
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
    SAFE_CANCEL_ARC(self.secDownManager);
    
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
