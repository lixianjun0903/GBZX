


//
//  SearchViewController.m
//  干部在线
//
//  Created by lixianjun on 15-2-3.
//  Copyright (c) 2015年 中青年. All rights reserved.
//

#import "SearchViewController.h"
#import "JSON.h"
#import "ImageDownManager.h"
#import "searchTableViewCell.h"
#import "ClassEveryModel.h"
@interface SearchViewController ()<UISearchBarDelegate,UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
{
    MBProgressHUD * mLoadView;
    
    //搜索框
    UITextField * textField;
    UITableView * _tableView;
    UIButton *searchGo;
    BOOL isEmpty;
}
@property(nonatomic,strong)ImageDownManager * searchDownManager;
@property(nonatomic,strong)NSMutableArray * searchArray;

@end

@implementation SearchViewController
-(void)viewWillDisappear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = NO;
    
    
}
-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden  = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self crearteTableView];
    isEmpty =YES;
    self.searchArray = [NSMutableArray arrayWithCapacity:0];
    self.view.backgroundColor = [UIColor whiteColor];
    [self createSearch];
    // Do any additional setup after loading the view.
}
-(void)crearteTableView
{
    _tableView =[[UITableView alloc] initWithFrame:CGRectMake(0, 64, WIDETH, HEIGHT - 64) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.searchArray.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    searchTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ID"];
    if (!cell) {
        cell = [[searchTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ID"];
    }
    [cell config:self.searchArray[indexPath.row]];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120;
}

#pragma mark 搜索课程
-(void)loadData
{
    if (_searchDownManager) {
        return;
    }
    
    NSUserDefaults * user =[NSUserDefaults standardUserDefaults];
    NSString * userID = [user objectForKey:@"sutdentId"];
    NSString * urlstr4;
    if (!userID){
        urlstr4 = [NSString stringWithFormat:@"%@api2/course/getCourseListByCondition.json?conditionStr=%@",BASEURL,textField.text];
    }
    else{
        urlstr4 = [NSString stringWithFormat:@"%@api2/course/getCourseListByCondition.json?conditionStr=%@&studentId=%@",BASEURL,textField.text ,userID];
    }
    self.searchDownManager = [[ImageDownManager alloc] init];
    _searchDownManager.delegate = self;
    _searchDownManager.OnImageDown = @selector(OnLoadFinish4:);
    _searchDownManager.OnImageFail = @selector(OnLoadFail4:);
    [_searchDownManager GetImageByStr:urlstr4];
}
- (void)OnLoadFinish4:(ImageDownManager *)sender
{
    NSString *resStr = sender.mWebStr;
    NSDictionary *dict = [resStr JSONValue];
    [self Cancel4];
    
    NSDictionary * dic = dict[@"data"];
    if (dic&&[dic isKindOfClass:[NSDictionary class]]&&dic.count>0) {
        for (NSDictionary *dics in dic) {
            ClassEveryModel * model = [[ClassEveryModel alloc] init];
            [model setValuesForKeysWithDictionary:dics];
            [self.searchArray addObject:model];
        }
    }
    [_tableView reloadData];
}


- (void)OnLoadFail4:(ImageDownManager *)sender {
    [self Cancel4];
}
- (void)Cancel4 {
    [mLoadView hide:YES];
    mLoadView = nil;
    SAFE_CANCEL_ARC(self.searchDownManager);
    
}

-(void)createSearch
{
    // 底部View
    UIView * bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 20, WIDETH, 44)];
    bgView.backgroundColor =[UIColor colorWithRed:0.94f green:0.94f blue:0.94f alpha:1.00f];
    [self.view addSubview:bgView];
    //半圆形view
    UIView * halfView = [[UIView alloc] initWithFrame:CGRectMake(15, 5, WIDETH -100, 34)];
    halfView.layer.cornerRadius = 18;
    halfView.layer.masksToBounds = YES;
    halfView.backgroundColor = [UIColor whiteColor];
    [bgView addSubview:halfView];
    
    textField =[[UITextField alloc] initWithFrame:CGRectMake(40, 0, halfView.frame.size.width - 40, 34)];
    textField.placeholder =@"想学哈都有";
        textField.clearButtonMode = UITextFieldViewModeAlways;
       [halfView addSubview:textField];
    //搜索图
    UIImageView * searchImageView =[[UIImageView alloc] initWithFrame:CGRectMake(10, 6, 24, 24)];
    searchImageView.image = [UIImage imageNamed:@"搜索.jpg"];
    [halfView addSubview:searchImageView];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textFiledEditChanged:) name:UITextFieldTextDidChangeNotification object:textField];
    //搜索返回按钮
    searchGo =[MyContol createButtonWithFrame:CGRectMake(WIDETH-70, 5, 60, 34) ImageName:nil Target:self Action:@selector(searchGoClick) Title:@"取消"];
    [searchGo setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [searchGo setTitle:@"搜索" forState:UIControlStateSelected];
    searchGo.layer.cornerRadius = 6;
    searchGo.layer.masksToBounds = YES;
    searchGo.layer.borderWidth = 0.6;
    searchGo.layer.borderColor = [UIColor colorWithRed:0.53f green:0.53f blue:0.53f alpha:1.00f].CGColor;
    searchGo.backgroundColor = [UIColor whiteColor];
    [bgView addSubview:searchGo];
    
}

-(void)textFiledEditChanged:(NSNotification *)obj
{
    UITextField *textField1 = (UITextField *)obj.object;
    if (textField1.text.length != 0) {
        isEmpty =NO;
        searchGo.selected = YES;
    }
    else
    {
        isEmpty = YES;
        searchGo.selected = NO;
    }
    
}
-(void)searchGoClick
{
    if (isEmpty) {
        [self.navigationController popViewControllerAnimated:NO];
    }
    else
    {
        [self loadData];
    }
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    [self.view endEditing:YES];
    
}
- (void)dealloc {
    _searchDownManager.delegate = nil;
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UITextFieldTextDidChangeNotification object:textField];
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
