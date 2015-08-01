//
//  ChildrenPublicModel.h
//  干部在线
//
//  Created by lixianjun on 15-2-2.
//  Copyright (c) 2015年 中青年. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ChildrenPublicModel : NSObject
@property(nonatomic) NSNumber* courseId;
@property(nonatomic,copy)NSString * courseImg;

@property(nonatomic,copy)NSString * courseType;

@property(nonatomic) int period;

@property(nonatomic) int studyNum;

@property(nonatomic,copy)NSString * teacherName;

@property(nonatomic,copy)NSString * title;


@end
