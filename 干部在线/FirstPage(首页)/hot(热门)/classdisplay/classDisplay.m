//
//  classPlay.m
//  干部在线
//
//  Created by lixianjun on 15-1-5.
//  Copyright (c) 2015年 中青年. All rights reserved.
//

#import "classDisplay.h"
#import "startView.h"
@implementation classDisplay
-(id)initWithFrame:(CGRect)frame
{
    
    self = [super initWithFrame:frame];
    if (self) {
        [self makeUI];
    }
    return self;
    
}
-(void)makeUI
{
    //标题
    titleLabel = [MyContol createLabelWithFrame:CGRectMake(0, 5, self.frame.size.width, 45) Font:17 Text:@"全面推进依法治国"];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = [UIColor colorWithRed:0.3 green:0.34 blue:0.3 alpha:1];
    titleLabel.font = [UIFont boldSystemFontOfSize:17];
    [self addSubview:titleLabel];
    //图标
    imageView  = [MyContol createImageViewWithFrame:CGRectMake(15, 50, 150, 110) ImageName:@"侧滑最热.jpg"];
    imageView.layer.cornerRadius = 4;
    imageView.layer.masksToBounds = YES;
    [self addSubview:imageView];
    //讲师
    teacherLabel = [MyContol createLabelWithFrame:CGRectMake(180 , 50, self.frame.size.width - 180, 14) Font:14 Text:@"讲师：王老师"];
    teacherLabel.textColor = [UIColor grayColor];
    [self addSubview:teacherLabel];
    //课时
    classTimeLabel =[MyContol createLabelWithFrame:CGRectMake(180, 72, self.frame.size.width - 180, 14) Font:14 Text:@"课时：120小时"];
    classTimeLabel.textColor = [UIColor grayColor];
    [self addSubview:classTimeLabel];
    //积分
    markLabel =[MyContol createLabelWithFrame:CGRectMake(180, 94, self.frame.size.width -180, 14) Font:14 Text:@"积分：25"];
    markLabel.textColor = [UIColor grayColor];
    [self addSubview:markLabel];
    //学习人数
    learnNumberLabel = [MyContol createLabelWithFrame:CGRectMake(180, 116, self.frame.size.width - 220, 14) Font:14 Text:@"已有100人学习"];
    learnNumberLabel.font =[UIFont systemFontOfSize:14];
    learnNumberLabel.textColor =[UIColor grayColor];
    [self addSubview:learnNumberLabel];
    //评价
    smarkLabel = [MyContol createLabelWithFrame:CGRectMake(180, 138, 40, 20) Font:14 Text:@"评价:"];
    smarkLabel.font =[UIFont systemFontOfSize:14];
    smarkLabel.textColor =[UIColor grayColor];
    [self addSubview:smarkLabel];
    startView * startViews = [[startView alloc] initWithFrame:CGRectMake(218, 140, 65, 23)];
    [self addSubview:startViews];
    [startViews conFigNumber:5];
    //想写描述
    //describeLabel = [MyContol createLabelWithFrame:CGRectMake(10,165, self.frame.size.width, 25) Font:15 Text:@"  新年前夕，国家主席习近平通过中国国际广播电台、中央人民广播电台人民广播电台，，，"];
//    describeLabel = [[UILabel alloc] initWithFrame:CGRectMake(10,155, self.frame.size.width, 25)];
//    describeLabel.text = @"  新年前夕，国家主席习近平通过中国国际广播电台、中央人民广播电台人民广播电台新年前夕";
//    describeLabel.numberOfLines = 0;
////   describeLabel.backgroundColor = [UIColor redColor];
//    describeLabel.font = [UIFont systemFontOfSize:14];
//    describeLabel.lineBreakMode = NSLineBreakByTruncatingTail;
//    describeLabel.lineBreakMode = NSLineBreakByWordWrapping;
//    [self addSubview:describeLabel];
////    //更多
//    moreButton = [MyContol createButtonWithFrame:CGRectMake(self.frame.size.width - 50, 200,50,20)  ImageName:nil Target:self Action:@selector(moreClick) Title:@"更多"];
//    
//    // moreButton.backgroundColor = [UIColor blueColor];
//    [moreButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [self addSubview:moreButton];
    
    
    
}
-(void)config:(NSDictionary *)dic
{
    //标题
    if (dic[@"title"]==nil) {
        titleLabel.text = @"暂无";
    }
    else
    {
    titleLabel.text = dic[@"title"];
    }
    //图标
    [imageView sd_setImageWithURL:[NSURL URLWithString:dic[@"courseImg"]]placeholderImage:[UIImage imageNamed:@"侧滑最热.jpg"]];
       //讲师
        if (dic[@"teacherName"] == nil) {
            teacherLabel.text = @"讲师:暂时没讲师";
    
        }else
        {
//        teacherLabel.text = dic[@"teacherName"] ;
            teacherLabel.text = [NSString stringWithFormat:@"讲师:%@",dic[@"teacherName"] ];
        }
//    teacherLabel.text = [NSString stringWithFormat:@"讲师：%@",dic[@"teacherName"] ];
    //NSNumber  * num = [[NSNumber alloc] initWithInt:10];
    //课时
    classTimeLabel.text = [NSString stringWithFormat:@"课时：%d",[dic[@"period"] intValue]];
    
    //积分
    markLabel.text = [NSString stringWithFormat:@"积分：%d",[dic[@"period"] intValue]*10];
    
        //学习人数
    learnNumberLabel.text = [NSString stringWithFormat:@"已有%d人选学",[dic[@"studyNum"]intValue]];
    
    //评价
    //smarkLabel.text = dic[@"comment"];
    //想写描述
    if ([dic[@"courseIntro"] isEqual:@"<null>"]) {
        describeLabel.text = @"评论:暂无";
    }else
    {
    describeLabel.text =[NSString stringWithFormat:@"评论：%@",dic[@"courseIntro"]];
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
