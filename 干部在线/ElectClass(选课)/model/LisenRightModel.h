//
//  LisenRightModel.h
//  干部在线
//
//  Created by lixianjun on 15-1-21.
//  Copyright (c) 2015年 中青年. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LisenRightModel : NSObject
@property(nonatomic,copy)NSString * courseImg;
@property(nonatomic,copy)NSString * courseType;
@property(nonatomic,copy)NSString * teacherName;
@property(nonatomic,copy)NSString * title;
@property(nonatomic)int comment;
@property(nonatomic)int courseId;
@property(nonatomic)int period;
@property(nonatomic)int studyNum;

@end
