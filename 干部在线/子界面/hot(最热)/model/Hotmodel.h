//
//  Hotmodel.h
//  干部在线
//
//  Created by lixianjun on 15-1-19.
//  Copyright (c) 2015年 中青年. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Hotmodel : NSObject
@property(nonatomic)int comment;
@property(nonatomic,copy)NSString * courseId;
@property(nonatomic,copy)NSString * courseImg;
@property(nonatomic,copy)NSString * courseType;
@property(nonatomic)int period;
@property(nonatomic)int studyNum;
@property(nonatomic,copy)NSString * teacherName;
@property(nonatomic,copy)NSString * title;
@end
