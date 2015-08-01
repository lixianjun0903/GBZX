//
//  Adaptation.h
//  干部在线
//
//  Created by lixianjun on 15-1-6.
//  Copyright (c) 2015年 中青年. All rights reserved.
//

//适配的宏定义
/*****是否是3.5的尺寸*/
//宽320
#define is3_5Inch  ([UIScreen mainScreen].bounds.size.height == 480.0)
/**是否4寸屏*/
#define is4Inch  ([UIScreen mainScreen].bounds.size.height == 568.0)
/**是否是4.7寸屏*/
//宽375
#define is4_7Inch ([UIScreen mainScreen].bounds.size.height == 667.0)
/**是否是5.5寸屏幕*/
//宽414
#define is5_5Inch ([UIScreen mainScreen].bounds.size.height == 736.0)
//角度旋转
//随机颜色
#define myBgRandomColor [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:arc4random_uniform(255)/255.0]
//自定义颜色
#define myColor(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:255/255.0]
//随机数
#define myRandom  arc4random_uniform(100000000.0)



