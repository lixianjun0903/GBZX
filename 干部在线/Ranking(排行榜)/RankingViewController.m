//
//  RankingViewController.m
//  干部在线
//
//  Created by lixianjun on 14-12-29.
//  Copyright (c) 2014年 中青年. All rights reserved.
//

#import "RankingViewController.h"
#import "StudentRankTableViewCell.h"
#import "ClassRankTableViewCell.h"
#import "LeftView.h"
#import "RightView.h"

@interface RankingViewController ()<UIScrollViewDelegate>
{
    
    UIScrollView *mainSC;
    
    UIImageView * bottomLineView;
    UIImageView * topView;
    //底部的UIView
    LeftView * leftView;
    //顶部的uiview
    RightView * rightView;
}
@property(nonatomic,strong)NSMutableArray * dataArray;
@end

@implementation RankingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createNav];
    self.view.backgroundColor = [UIColor whiteColor];
    mainSC = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 50, WIDETH, HEIGHT-50-64)];
    
    mainSC.delegate  =self;
    //    mainSC.backgroundColor = [UIColor greenColor];
    mainSC.showsHorizontalScrollIndicator = NO;
    mainSC.contentSize = CGSizeMake(WIDETH * 2, HEIGHT-50-64);
    mainSC.pagingEnabled = YES;
    [self.view addSubview:mainSC];
    
    
    [self createRankButtonView];
    [self createStudentRankVeiw];
    [self createCourceRanVeiw];
    
    
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated
{
    //    self.tabBarController.tabBar.hidden = YES;
}
-(void)createNav
{
    self.navigationController.navigationBar.translucent = NO;
    self.navigationItem.hidesBackButton = YES;
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 80, 44)];
    titleLabel.text = @"排行榜";
    titleLabel.textColor =[UIColor whiteColor];
    titleLabel.font = [UIFont boldSystemFontOfSize:20];
    self.navigationItem.titleView = titleLabel;
    //左侧首页按钮
    UIButton * leftButton = [MyContol createButtonWithFrame:CGRectMake(0, 15,14, 22) ImageName:@"back.png" Target:self Action:@selector(rankLeftClick) Title:nil];
    leftButton.titleLabel.font =[UIFont boldSystemFontOfSize:18];
    self.navigationItem.leftBarButtonItem =[[UIBarButtonItem alloc] initWithCustomView:leftButton];
    
}
-(void)rankLeftClick
{
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGPoint point = scrollView.contentOffset;
    bottomLineView.frame = CGRectMake((WIDETH /2- 120)/2+point.x/2, 47, 120, 3);
    
    int index = (int)point.x/(WIDETH/2);
    UIButton * btn0 = (UIButton *)[topView viewWithTag:10];
    UIButton * btn1 = (UIButton*)[topView viewWithTag:11];
    if (index == 0) {
        btn0.selected = YES;
        btn1.selected = NO;
    }
    else if(index==2||index == 1)
    {
        btn0.selected = NO;
        btn1.selected = YES;
    }
    
    NSLog(@"%f~~~~%f",scrollView.contentOffset.x,scrollView.contentOffset.y);
}
-(void)createRankButtonView
{
    topView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, WIDETH, 49.8)];
    topView.image = [UIImage imageNamed:@""];
    topView.layer.borderWidth = 0.8;
    topView.layer.borderColor =[UIColor colorWithRed:0.84f green:0.84f blue:0.84f alpha:1.00f].CGColor;
    topView.userInteractionEnabled =YES;
    [self.view addSubview:topView];
    
    //评论
    UIButton * commentButton = [MyContol createButtonWithFrame:CGRectMake(0, 0, WIDETH/2.0, 50) ImageName:nil Target:self Action:@selector(commentClick:) Title:@"学员排行"];
    
    [commentButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [commentButton setTitleColor:[UIColor colorWithRed:0.13f green:0.4f blue:0.91 alpha:1.00f] forState:UIControlStateSelected];
    commentButton.tag = 10;
    commentButton.titleLabel.font = [UIFont systemFontOfSize:20];
    commentButton.selected = YES;
    [topView addSubview:commentButton];
    
    //相关推荐
    UIButton * pushButton = [MyContol createButtonWithFrame:CGRectMake(WIDETH/2.0, 0, WIDETH/2.0,50) ImageName:nil Target:self Action:@selector(commentClick:) Title:@"课程排行"]
    ;
    [pushButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [pushButton setTitleColor:[UIColor colorWithRed:0.13f green:0.4f blue:0.91 alpha:1.00f] forState:UIControlStateSelected];
    pushButton.tag = 11;
    pushButton.titleLabel.font = [UIFont systemFontOfSize:20];
    [topView addSubview:pushButton];
    bottomLineView = [MyContol createImageViewWithFrame:CGRectMake((WIDETH /2- 120)/2, 47, 120, 3) ImageName:@"矩形 10.png"];
    
    bottomLineView.tag = 100;
    [topView addSubview:bottomLineView];
}
-(void)commentClick:(UIButton*)sender
{
    float index = sender.tag - 10;
    NSLog(@"%f",index);
    UIButton * btn0 = (UIButton *)[topView viewWithTag:10];
    UIButton * btn1 = (UIButton*)[topView viewWithTag:11];
    NSArray * tempArray = @[btn0,btn1];
    
    for (UIButton * btn in tempArray) {
        if (btn.tag - 10 == index) {
            btn.selected = YES;
        }else
        {
            btn.selected = NO;
        }
    }
    UIImageView *bottomLineViews = (UIImageView*)[topView viewWithTag:100];
    [UIView animateWithDuration:0.3 animations:^{
        bottomLineViews.frame = CGRectMake(WIDETH/2 * index + (WIDETH/2 - 120)/2, 47, 120, 3);
        mainSC.contentOffset =CGPointMake(index*WIDETH, 0);
    }];
    
}
#pragma mark 学员排行
-(void)createStudentRankVeiw
{
    leftView = [[LeftView alloc] initWithFrame:CGRectMake(0, 0, WIDETH, mainSC.frame.size.height)];
    // leftView.backgroundColor = [UIColor redColor];
    [mainSC addSubview:leftView];
    mainSC.contentSize = CGSizeMake(WIDETH * 2, HEIGHT-50-64);
}
#pragma mark 课程排行
-(void)createCourceRanVeiw
{//rightView.backgroundColor = [UIColor redColor];
    rightView = [[RightView alloc] initWithFrame:CGRectMake(WIDETH, 0, WIDETH, mainSC.frame.size.height )];
    rightView.backgroundColor = [UIColor colorWithWhite:0.92 alpha:1];
    [mainSC addSubview:rightView];
    mainSC.contentSize = CGSizeMake(WIDETH * 2, HEIGHT-50-64);
}
-(void)leftClick
{
    [self.navigationController popViewControllerAnimated:YES];
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
