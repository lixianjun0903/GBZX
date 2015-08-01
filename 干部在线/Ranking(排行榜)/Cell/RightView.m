//
//  RightView.m
//  干部在线
//
//  Created by lixianjun on 15-1-8.
//  Copyright (c) 2015年 中青年. All rights reserved.
//

#import "RightView.h"
#import "JSON.h"
#import "ImageDownManager.h"
#import "CourceRankModel.h"
#import "ClassRankTableViewCell.h"
@interface RightView()<UITableViewDataSource,UITableViewDelegate,MBProgressHUDDelegate>

{
    MBProgressHUD  * mLoadView;

    UITableView * _tableView;
}
@property(nonatomic,strong)NSMutableArray * dataArray;
@property(nonatomic,strong)ImageDownManager *mDownManager;
@end

@implementation RightView
@synthesize mLoadMsg;

-(id)initWithFrame:(CGRect)frame
{
    self  = [super initWithFrame:frame];
    if (self) {
        //        self.backgroundColor = [UIColor yellowColor];
        [self createUI];
        self.dataArray = [NSMutableArray arrayWithCapacity:0];
        [self loadData];
    }
    return self;
}
-(void)dealloc
{
    _mDownManager.delegate = nil;
}
-(void)loadData

{
    if (_mDownManager) {
        return;
    }
    
    //[self StartLoading];
    mLoadView = [[MBProgressHUD alloc] initWithView:self];
    mLoadView.delegate = self;
    mLoadView.labelText = @"正在加载中...";
    if (mLoadMsg){
        mLoadView.mode = MBProgressHUDModeCustomView;
    }
    mLoadView.dimBackground = YES;
    [self addSubview:mLoadView];
    NSString * urlstr;
    
    urlstr = [NSString stringWithFormat:@"%@api/rank/getCourseRank.json",BASEURL];
    
    self.mDownManager = [[ImageDownManager alloc]init];
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
    if (array&&[array isKindOfClass:[NSArray class]] &&array.count>0)
    {
        for (NSDictionary *dic in array) {
            CourceRankModel * model = [[CourceRankModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            [self.dataArray addObject:model];
        }
        [_tableView reloadData];
        
    }
}

//#pragma mark 开始下载

- (void)OnLoadFail:(ImageDownManager *)sender {
    [self Cancel];
}
- (void)Cancel {
    [mLoadView hide:YES];
    mLoadView = nil;
    self.mDownManager.delegate = nil;
    SAFE_CANCEL_ARC(self.mDownManager);
}
-(void)createUI
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) style:UITableViewStylePlain];
    //           _tableView.contentInset = UIEdgeInsetsMake(-35, 0, -38, 0);
    _tableView.showsVerticalScrollIndicator= NO;
    _tableView.delegate = self;
    _tableView.dataSource = self;
//    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor =  [UIColor whiteColor];
    [self addSubview:_tableView];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.dataArray.count == 0) {
        return 10;
    }
    else
    {
    return self.dataArray.count;
    }
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ClassRankTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ID"];
    if (!cell) {
        cell = [[ClassRankTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ID"];
    }
    if (self.dataArray.count==0) {
        [cell config:nil row:0];
    }
    else
    {
    [cell config:self.dataArray[indexPath.row] row:(int)indexPath.row];
    }
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90;
    
}
    /*
     // Only override drawRect: if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     - (void)drawRect:(CGRect)rect {
     // Drawing code
     }
     */

@end