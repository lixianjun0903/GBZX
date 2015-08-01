//
//  startView.h
//  干部在线
//
//  Created by lixianjun on 14-12-31.
//  Copyright (c) 2014年 中青年. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface startView : UIView
{
//背景星星
UIImageView * bgImageView;
//上边的红星星
UIImageView * startImageView;
}
-(void)conFigNumber:(float)num;
@end
