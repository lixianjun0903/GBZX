

//
//  mainTabBarViewController.m
//  干部在线
//
//  Created by lixianjun on 14-12-30.
//  Copyright (c) 2014年 中青年. All rights reserved.
//

#import "mainTabBarViewController.h"
#import "MyclassViewController.h"
#import "ElectCourcrViewController.h"
#import "StatictisViewController.h"
#import "SetingViewController.h"
@interface mainTabBarViewController ()

@end

@implementation mainTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   [self createView];
    [self createItem];
    // Do any additional setup after loading the view.
}
-(void)createItem
{
    
    NSArray *unSelectImageName = [NSArray arrayWithObjects:@"课程正常.png", @"选课正常.png", @"统计正常.png", @"设置正常.png", nil];
    NSArray *selectImageName = [NSArray arrayWithObjects:@"课程选中.png", @"选课选中.png", @"统计选中.png", @"设置选中.png", nil];
   NSArray*titleArray=@[@"课程",@"选课",@"统计",@"设置"];
    
    if (iOS7) {
        for (int i=0; i<self.tabBar.items.count; i++) {
        //处理图片
        UIImage*unSelectImage=[UIImage imageNamed:unSelectImageName[i]];
        //使用图像原尺寸
        unSelectImage=[unSelectImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        //处理图片2
        UIImage*selectImage=[UIImage imageNamed:selectImageName[i]];
        //使用图像原尺寸
        selectImage=[selectImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        //获取item
        UITabBarItem*item=self.tabBar.items[i];
        
        item=[item initWithTitle:titleArray[i] image:unSelectImage selectedImage:selectImage];
    }
    
}else{
    for (int i=0; i<self.tabBar.items.count; i++) {
        //7以下不需要处理图片
        UITabBarItem*item=self.tabBar.items[i];
        
        [item setFinishedSelectedImage:[UIImage imageNamed:selectImageName[i]] withFinishedUnselectedImage:[UIImage imageNamed:unSelectImageName[i]]];
        item.title=titleArray[i];
        
    }   
    
}

    //修改选中颜色
    [[UITabBarItem appearance]setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor redColor]} forState:UIControlStateSelected];
    
    
}


-(void)createView
{
    
    MyclassViewController * first = [[MyclassViewController alloc] init];
    UINavigationController * nc1 = [[UINavigationController alloc] initWithRootViewController:first];
    ElectCourcrViewController * elect = [[ElectCourcrViewController alloc] init];
    UINavigationController * nc2 = [[UINavigationController alloc] initWithRootViewController:elect];
    
    StatictisViewController * infor = [[StatictisViewController alloc] init];
    UINavigationController * nc3 = [[UINavigationController alloc] initWithRootViewController:infor];
    SetingViewController * my =[[SetingViewController alloc] init];
    UINavigationController *nc4= [[UINavigationController alloc] initWithRootViewController:my];
    NSArray * array = @[nc1,nc2,nc3,nc4];
    self.viewControllers = array;
    self.selectedIndex = 0;

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
