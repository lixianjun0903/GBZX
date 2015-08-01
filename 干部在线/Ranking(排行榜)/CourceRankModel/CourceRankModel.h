//
//  CourceRankModel.h
//  干部在线
//
//  Created by lixianjun on 15-1-8.
//  Copyright (c) 2015年 中青年. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CourceRankModel : NSObject
@property(nonatomic,copy)NSNumber* courseId;
//@property(nonatomic) int period;
@property(nonatomic) int studyNum;

@property(nonatomic,copy)NSString*name;
@property(nonatomic,copy)NSString*courseImgUrl;
//@property(nonatomic,copy)NSString*title;

@end
