//
//  commentMOdel.h
//  干部在线
//
//  Created by lixianjun on 15-1-14.
//  Copyright (c) 2015年 中青年. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface commentMOdel : NSObject
@property(nonatomic,copy)NSString*  userName;
@property(nonatomic) NSString * headPortraitUrl;
@property(nonatomic,copy)NSString*commentTime;
@property(nonatomic,copy)NSString *commentContent;

@end
