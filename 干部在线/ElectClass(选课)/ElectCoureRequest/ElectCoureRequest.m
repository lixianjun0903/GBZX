//
//  ElectCoureRequest.m
//  干部在线
//
//  Created by lixianjun on 15-1-16.
//  Copyright (c) 2015年 中青年. All rights reserved.
//

#import "ElectCoureRequest.h"

@implementation ElectCoureRequest
+(AFRequestState*)getElectCoureRequest:(void(^)(NSArray*electDic))succ
{
    return [self postRequestWithlogRequest:@"api/course/getCourseCategoryList.json" param:nil saveData:nil succ:succ fail:^(int errCode, NSError *err) {
        
    }];
    

}
@end