//
//  ElectCoureRequest.h
//  干部在线
//
//  Created by lixianjun on 15-1-16.
//  Copyright (c) 2015年 中青年. All rights reserved.
//

#import "AFAppRequest.h"

@interface ElectCoureRequest : AFAppRequest
+(AFRequestState*)getElectCoureRequest:(void(^)(NSArray*electDic))succ;


@end
