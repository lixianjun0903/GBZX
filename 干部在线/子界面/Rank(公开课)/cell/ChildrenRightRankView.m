

//
//  ChildrenRightRankView.m
//  干部在线
//
//  Created by lixianjun on 15-2-2.
//  Copyright (c) 2015年 中青年. All rights reserved.
//

#import "ChildrenRightRankView.h"
#import "JSON.h"
#import "ImageDownManager.h"
#import "ChildrenRightRankTableViewCell.h"
#import "childrenRightRankModel.h"
@interface ChildrenRightRankView()<UITableViewDelegate,UITableViewDataSource>
{
    
    UITableView * _tableView;
}
@property(nonatomic,strong)NSMutableArray * dataArray;
@property(nonatomic,strong)ImageDownManager *mDownManager;
@end
@implementation ChildrenRightRankView
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
    NSString * urlstr;
    
    urlstr = [NSString stringWithFormat:@"%@api/rank/getCourseRank.json",BASEURL];
    
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
    if (array&&[array isKindOfClass:[NSArray class]] &&array.count>0)
    {
        for (NSDictionary *dic in array) {
            childrenRightRankModel * model = [[childrenRightRankModel alloc] init];
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
    //    return 10;
    return self.dataArray.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ChildrenRightRankTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ID"];
    if (!cell) {
        cell = [[ChildrenRightRankTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ID"];
    }
    [cell config:self.dataArray[indexPath.row] row:(int)indexPath.row];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
