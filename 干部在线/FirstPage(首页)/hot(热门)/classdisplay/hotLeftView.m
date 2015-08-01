//
//  hotLeftView.m
//  干部在线
//
//  Created by lixianjun on 15-1-30.
//  Copyright (c) 2015年 中青年. All rights reserved.
//

#import "hotLeftView.h"
#import "ConmentTableViewCell.h"
#import "ImageDownManager.h"
#import "JSON.h"
#import "commentMOdel.h"
@interface hotLeftView()<UITableViewDataSource,UITableViewDelegate>
{

    UITableView * _tableView;
}
@property (nonatomic, strong) ImageDownManager *mDownManager;
@property(nonatomic,strong)NSMutableArray * commentArray;

@end
@implementation hotLeftView
-(id)initWithFrame:(CGRect)frame
{
    self  = [super initWithFrame:frame];
    if (self) {
        //         self.backgroundColor = [UIColor grayColor];
        [self makeUI];
//        [self commentloadData];
    }
    return self;
}
#pragma mark 评论的数据请求
-(void)commentloadData
{
    if (_mDownManager) {
        return;
    }
    [self StartLoading];
       NSString * urlstr = [NSString stringWithFormat:@"%@api/course/getCommentByCourseId.json?courseId=%@",BASEURL,self.coreID];
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
 NSDictionary * commentDic = dict[@"data"];
 if (commentDic&&[commentDic isKindOfClass:[NSDictionary class]])
 {

//        commentMOdel * model = [[commentMOdel alloc] init];
     }
    [_tableView reloadData];
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

-(void)makeUI
{

    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self addSubview:_tableView];
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 13;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{ConmentTableViewCell * cell =[tableView dequeueReusableCellWithIdentifier:@"ID"];
    if (!cell) {
        cell = [[ConmentTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ID"];
    }
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
