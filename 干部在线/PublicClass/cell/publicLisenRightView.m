


//
//  publicLisenRightView.m
//  干部在线
//
//  Created by lixianjun on 15-1-28.
//  Copyright (c) 2015年 中青年. All rights reserved.
//

#import "publicLisenRightView.h"
#import "publicLisenRightTableViewCell.h"
#import "LisenRightModel.h"
#import "JSON.h"
#import "ImageDownManager.h"
@interface publicLisenRightView()
{
    UITableView *_tableView;
    
}
@property (nonatomic, strong) ImageDownManager *mDownManager;
@property(nonatomic,strong)NSMutableArray *dataArray;
@end
@implementation publicLisenRightView
-(id)initWithFrame:(CGRect)frame
{
    self  = [super initWithFrame:frame];
    if (self) {
        //        self.backgroundColor = [UIColor yellowColor];
        [self createUI];
        
    }
    return self;
}
-(void)loadData
{
    
    if (_mDownManager) {
        return;
    }
    
    [self StartLoading];
    NSString * urlstr;
    
    urlstr = [NSString stringWithFormat:@"%@api/course/getRecommendCourseList.json?courseId=%@",BASEURL,self.coureId];
    
    self.mDownManager = [[ImageDownManager alloc] init];
    _mDownManager.delegate = self;
    _mDownManager.OnImageDown = @selector(OnLoadFinish:);
    _mDownManager.OnImageFail = @selector(OnLoadFail:);
    [_mDownManager GetImageByStr:urlstr];
    
}
-(void)dealloc
{
    self.mDownManager = nil;
}
- (void)OnLoadFinish:(ImageDownManager *)sender
{
    self.dataArray  =[NSMutableArray arrayWithCapacity:0];
    NSString *resStr = sender.mWebStr;
    NSDictionary *dict = [resStr JSONValue];
    [self Cancel];
    NSDictionary *d = dict[@"data"];
    NSArray *array = d[@"data"];
    if (array&&[array isKindOfClass:[NSArray class]] &&array.count>0) {
        for (NSDictionary *dic in array) {
            LisenRightModel * model = [[LisenRightModel alloc] init];
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
    //[self StopLoading];
    SAFE_CANCEL_ARC(self.mDownManager);
    
}


-(void)createUI
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0,self.frame.size.width, self.frame.size.height) style:UITableViewStylePlain];
    
    _tableView.showsVerticalScrollIndicator= NO;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    // _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor =  [UIColor whiteColor];
    [self addSubview:_tableView];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.dataArray.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    publicLisenRightTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ID"];
    if (!cell) {
        cell = [[publicLisenRightTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ID"];
    }
    [cell LisenConfig:self.dataArray[indexPath.row]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    //[cell config:self.dataArray[indexPath.row] row:(int)indexPath.row];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 115;
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
