



//
//  publicLisenLeftView.m
//  干部在线
//
//  Created by lixianjun on 15-1-28.
//  Copyright (c) 2015年 中青年. All rights reserved.
//

#import "publicLisenLeftView.h"
#import "publicLisenLeftTableViewCell.h"
@interface publicLisenLeftView()
{
    UITableView *_tableView;
    
}
@end
@implementation publicLisenLeftView
-(id)initWithFrame:(CGRect)frame
{
    self  = [super initWithFrame:frame];
    if (self) {
        //         self.backgroundColor = [UIColor grayColor];
        [self makeUI];
        
        
    }
    return self;
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
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 15;
    //return self.dataArray.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    publicLisenLeftTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ID"];
    if (!cell) {
        cell = [[publicLisenLeftTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"ID"];
    }
    //cell.frame = CGRectMake(cell.frame.origin.x, cell.frame.origin.y, tableView.frame.size.width, cell.frame.size.height);
    
    // cell.backgroundColor = [UIColor blueColor];
    //[cell config:self.dataArray[indexPath.row]];
    
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
