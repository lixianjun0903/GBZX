//
//  MyClassModel.h
//  干部在线
//
//  Created by lixianjun on 15-1-27.
//  Copyright (c) 2015年 中青年. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyClassModel : NSObject
@property(nonatomic)NSNumber *courseId;
@property(nonatomic,copy)NSString * courseImg;
@property(nonatomic,copy)NSString * courseType;
@property(nonatomic,copy)NSString * learnedHour;
@property(nonatomic)NSNumber* period;
@property(nonatomic,copy)NSString * requiredHour;
@property(nonatomic)NSNumber* studyNum;
@property(nonatomic,copy)NSString * teacherName;
@property(nonatomic,copy)NSString * title;

@end
