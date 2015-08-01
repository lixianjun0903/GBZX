

//
//  ChildrenLeftRankView.m
//  干部在线
//
//  Created by lixianjun on 15-2-2.
//  Copyright (c) 2015年 中青年. All rights reserved.
//

#import "ChildrenLeftRankView.h"
#import "ImageDownManager.h"
#import "JSON.h"
#import "childrenLeftRankModel.h"
#import "ChildrenLeftRankTableViewCell.h"
@interface ChildrenLeftRankView()<UITableViewDataSource,UITableViewDelegate>
{
    MBProgressHUD * mLoadView;
    UITableView * _tableView;
}
@property(nonatomic,strong)NSMutableArray * dataArray;
@property(nonatomic,strong)ImageDownManager *mDownManager;
@end
@implementation ChildrenLeftRankView
@synthesize mLoadMsg;
-(id)initWithFrame:(CGRect)frame
{
    self  = [super initWithFrame:frame];
    if (self) {
        //         self.backgroundColor = [UIColor grayColor];
        [self makeUI];
        [self loadData];
        self.dataArray = [NSMutableArray arrayWithCapacity:0];
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
    
    mLoadView = [[MBProgressHUD alloc] initWithView:self];
    if (mLoadMsg) {
        mLoadView.mode = MBProgressHUDModeCustomView;
        mLoadView.labelText = @"正在加载";
    }
    [self addSubview:mLoadView];
    
    [mLoadView show:YES];
    NSString * urlstr;
    
    urlstr = [NSString stringWithFormat:@"%@api/rank/getStudentRank.json",BASEURL];
    
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
            childrenLeftRankModel * model = [[childrenLeftRankModel alloc] init];
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
    self.mDownManager.delegate = nil;
    SAFE_CANCEL_ARC(self.mDownManager);
    
}



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ChildrenLeftRankTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ID"];
    if (!cell) {
        cell = [[ChildrenLeftRankTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"ID"];
    }
    //cell.frame = CGRectMake(cell.frame.origin.x, cell.frame.origin.y, tableView.frame.size.width, cell.frame.size.height);
    
    // cell.backgroundColor = [UIColor blueColor];
    //[cell config:self.dataArray[indexPath.row]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell config:self.dataArray[indexPath.row] row:(int)indexPath.row];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 85;
    
}

-(void)makeUI
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0,self.frame.size.width, self.frame.size.height) style:UITableViewStylePlain];
    
    _tableView.showsVerticalScrollIndicator= NO;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    // _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor =  [UIColor whiteColor];
    [self addSubview:_tableView];
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
