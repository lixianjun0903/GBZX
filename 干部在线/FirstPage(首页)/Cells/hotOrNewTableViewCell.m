//
//  hotOrNewTableViewCell.m
//  干部在线
//
//  Created by lixianjun on 14-12-30.
//  Copyright (c) 2014年 中青年. All rights reserved.
//

#import "hotOrNewTableViewCell.h"
#import "FirtPageModel.h"

@implementation hotOrNewTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createUI];
    }
    return self;
}
#pragma mark 创建UI
-(void)createUI
{
        //左边图片
    leftImageView  = [MyContol createImageViewWithFrame:CGRectMake(15, 15, 100, 85) ImageName:@"默认logo.png"];
    leftImageView.layer.cornerRadius = 4;
    leftImageView.layer.masksToBounds = YES;
//    activityIndicatorView = [[UIActivityIndicatorView alloc]
    
//                             initWithFrame : CGRectMake(10.0f, 10.0f, 32.0f, 32.0f)] ;
    activityIndicatorView = [[UIActivityIndicatorView alloc] init];
    
   [activityIndicatorView setCenter: leftImageView.center] ;
  [activityIndicatorView setFrame:CGRectMake(40,30, 20, 20)];
    
    [activityIndicatorView setActivityIndicatorViewStyle: UIActivityIndicatorViewStyleGray] ;
    
    [leftImageView addSubview : activityIndicatorView] ;
    [self.contentView addSubview:leftImageView];
    //课程
    classLabel = [MyContol createLabelWithFrame:CGRectMake(130, 15, [UIScreen mainScreen].bounds.size.width-140, 35) Font:14.5 Text:@"团中央学习报告团的业务、团干部能力"];
        classLabel.textColor = [UIColor colorWithRed:0.3 green:0.34 blue:0.3 alpha:1];
    classLabel.font = [UIFont systemFontOfSize:14.5];
    classLabel.numberOfLines = 0;
    //    classLabel.backgroundColor =[UIColor redColor];
    classLabel.adjustsFontSizeToFitWidth = YES;
    [self.contentView addSubview:classLabel];
    //讲师
    lecturerLabel = [MyContol createLabelWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 100,49, 90, 20) Font:13.3 Text:@"讲师:李老师"];
    lecturerLabel.adjustsFontSizeToFitWidth  =  YES;
    lecturerLabel.textColor =[UIColor grayColor];
    [self.contentView addSubview:lecturerLabel];
    
    
    //课时
    classTimeLabel = [MyContol createLabelWithFrame:CGRectMake(130, 49, [UIScreen mainScreen].bounds.size.width - 130 - 86, 20) Font:13.3 Text:@"课时：130小时"];
    classTimeLabel.adjustsFontSizeToFitWidth = YES;
    
    classTimeLabel.textColor =[UIColor grayColor];
    //    classTimeLabel.backgroundColor =[UIColor yellowColor];
    [self.contentView addSubview:classTimeLabel];
 
    //积分
    markLabel = [MyContol createLabelWithFrame:CGRectMake(130, 68, [UIScreen mainScreen].bounds.size.width - 130 -125, 20) Font:13.3 Text:@"积分：25"];
    markLabel.adjustsFontSizeToFitWidth = YES;
    markLabel.textColor =[UIColor grayColor];
    //    markLabel.backgroundColor = [UIColor yellowColor];
    [self.contentView addSubview:markLabel];
    //学习人数
    leanNumberLabel = [MyContol createLabelWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 100, 68, 90, 20) Font:13.3 Text:@"已有10000选学"];
    leanNumberLabel.adjustsFontSizeToFitWidth = YES;
    leanNumberLabel.textColor =[UIColor grayColor];
//     leanNumberLabel.backgroundColor =[UIColor redColor];
    [self.contentView addSubview:leanNumberLabel];
    //显示星星
    startView * startViews = [[startView alloc] initWithFrame:CGRectMake(170, 89, 65, 23)];
    //startViews.backgroundColor =[UIColor redColor];
    [self.contentView addSubview:startViews];
    NSString * str = @"5";
    [startViews conFigNumber:[str floatValue]];
    commentLabel =  [MyContol createLabelWithFrame:CGRectMake(130, 88, 50, 20) Font:13.3 Text:@"评价 ："];
    commentLabel.textColor = [UIColor grayColor];
    [self.contentView addSubview:commentLabel];
//    //课程
//    classLabel = [MyContol createLabelWithFrame:CGRectMake(130, 20, [UIScreen mainScreen].bounds.size.width-140, 35) Font:14 Text:@"名称：团中央学习报告团的业务、团干部能力"];
//    classLabel.textColor = [UIColor blackColor];
//    classLabel.font = [UIFont boldSystemFontOfSize:14];
//    classLabel.numberOfLines = 0;
////    classLabel.backgroundColor =[UIColor redColor];
//    classLabel.adjustsFontSizeToFitWidth = YES;
//    [self.contentView addSubview:classLabel];
//    //讲师
//    lecturerLabel = [MyContol createLabelWithFrame:CGRectMake(130, 50, [UIScreen mainScreen].bounds.size.width - 130 - 86, 20) Font:15 Text:@"讲师:李老师"];
//    lecturerLabel.adjustsFontSizeToFitWidth  =  YES;
//    lecturerLabel.textColor =[UIColor grayColor];
////    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:lecturerLabel.text];
////    [str addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(1,2)];
////    [str addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"HelveticaNeue-Bold" size:30.0] range:NSMakeRange(1, 2)];
////    lecturerLabel.attributedText = str;
////    
//   [self.contentView addSubview:lecturerLabel];
//    
// 
//    //课时
//    classTimeLabel = [MyContol createLabelWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 80, 50, 70, 20) Font:16 Text:@"课时：130小时"];
//    classTimeLabel.adjustsFontSizeToFitWidth = YES;
//    
//    classTimeLabel.textColor =[UIColor grayColor];
////    classTimeLabel.backgroundColor =[UIColor yellowColor];
//    [self.contentView addSubview:classTimeLabel];
//    //积分
//    markLabel = [MyContol createLabelWithFrame:CGRectMake(130, 70, [UIScreen mainScreen].bounds.size.width - 130 -125, 20) Font:15 Text:@"积分：25"];
//    markLabel.adjustsFontSizeToFitWidth = YES;
//    markLabel.textColor =[UIColor grayColor];
////    markLabel.backgroundColor = [UIColor yellowColor];
//    [self.contentView addSubview:markLabel];
//    //学习人数
//    leanNumberLabel = [MyContol createLabelWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 130, 70, 110, 20) Font:16 Text:@"已有10000选学"];
//    leanNumberLabel.adjustsFontSizeToFitWidth = YES;
//// leanNumberLabel.backgroundColor =[UIColor redColor];
//    [self.contentView addSubview:leanNumberLabel];
//    //显示星星
//   startView * startViews = [[startView alloc] initWithFrame:CGRectMake(178, 90, 65, 23)];
//    //startViews.backgroundColor =[UIColor redColor];
//       [self.contentView addSubview:startViews];
// NSString * str = @"4";
//    [startViews conFigNumber:[str floatValue]];
//    commentLabel =  [MyContol createLabelWithFrame:CGRectMake(130, 90, 40, 20) Font:15 Text:@"评价:"];
//    NSMutableAttributedString *commentLabelStr = [[NSMutableAttributedString alloc] initWithString:commentLabel.text];
//    [commentLabelStr addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0,2)];
//    [commentLabelStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:nil size:17.0] range:NSMakeRange(0, 2)];
//    commentLabel.attributedText = commentLabelStr;
//    [self.contentView addSubview:commentLabel];
}
-(void)config:(FirtPageModel*)model
{
    //读取图片
    if (model.courseImg == nil) {
       
      [activityIndicatorView startAnimating] ;
            }
    else{
   [activityIndicatorView stopAnimating] ;
//        [activityIndicatorView startAnimating] ;
    [leftImageView sd_setImageWithURL:[NSURL URLWithString:model.courseImg]placeholderImage:[UIImage imageNamed:@"默认logo.png"]];
        }
    //课程
    if (model.title == nil) {
        classLabel.text = @"团中央学习报告团的业务、团干部能力";
    }
    else
    {
    classLabel.text = model.title;
    }
     //讲师
    if (model.teacherName==nil) {
        lecturerLabel.text = [NSString stringWithFormat:@"讲师:暂无"];
    }else {
   
    lecturerLabel.text = [NSString stringWithFormat:@"讲师 : %@",model.teacherName];
    }
    //课时
    classTimeLabel.text = [NSString stringWithFormat:@"课时 : %@",model.period];

    //积分
    markLabel.text = [NSString stringWithFormat:@"积分 : %d",[model.period intValue]*10];
//    NSMutableAttributedString *markLabelStr = [[NSMutableAttributedString alloc] initWithString:markLabel.text];
//    [markLabelStr addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0,2)];
//    [markLabelStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:nil size:16.0] range:NSMakeRange(0, 2)];
//    markLabel.attributedText = markLabelStr;
    //学习人数
    leanNumberLabel.text = [NSString stringWithFormat:@"已有%@人选学",model.studyNum];
    }
- (void)awakeFromNib
{
    // Initialization code
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
