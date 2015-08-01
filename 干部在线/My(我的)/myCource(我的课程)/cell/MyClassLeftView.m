

//
//  MyClassLeftView.m
//  干部在线
//
//  Created by lixianjun on 15-1-22.
//  Copyright (c) 2015年 中青年. All rights reserved.
//

#import "MyClassLeftView.h"
#import "MyClassTableViewCell.h"
#import "JSON.h"
#import "ImageDownManager.h"
#import "MyClassModel.h"
@interface MyClassLeftView()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableView;
    
}
@property (nonatomic, strong) ImageDownManager *mDownManager;
@property(nonatomic,strong)NSMutableArray *dataArray;
@end
@implementation MyClassLeftView
@synthesize mLoadMsg;
-(id)initWithFrame:(CGRect)frame
{
    self  = [super initWithFrame:frame];
    if (self) {
        //        self.backgroundColor = [UIColor yellowColor];
        [self createUI];
        //[self loadData];
        
    }
    return self;
}
-(void)dealloc
{
    self.mDownManager.delegate = nil;
}
#pragma merk 数据请求
-(void)loadData
{
    if (_mDownManager) {
        return;
    }
    if (mLoadView) {
        return;
    }
    mLoadView = [[MBProgressHUD alloc] initWithView:self];
    if (mLoadMsg) {
        mLoadView.mode = MBProgressHUDModeCustomView;
        mLoadView.labelText = @"正在加载";
    }
    [self addSubview:mLoadView];
    
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
    [mLoadView hide:YES];
    mLoadView = nil;
    SAFE_CANCEL_ARC(self.mDownManager);
    
}

-(void)createUI
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self addSubview:_tableView];
    
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
        cell.selectionStyle =UITableViewCellSelectionStyleNone;
        
        
        [cell myClassCofig:self.dataArray[indexPath.row] rowNumber:(int)indexPath.row];
    }
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 125;
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
