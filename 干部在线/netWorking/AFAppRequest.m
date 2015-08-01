 //
//  AFAppRequest.m
//  QIQI_77
//
//  Created by Bill.Zhang on 14-8-23.
//  Copyright (c) 2014年 Bill.Zhang. All rights reserved.
//

#import "AFAppRequest.h"
#import "AppDelegate.h"
#import "Gson.h"
#import "MJRefresh.h"
#import "UIImageView+WebCache.h"
#import "GeneralizedProcessor.h"

#import "MBProgressHUD.h"

static NSString* const WC_API=@"http://wly.iheima.com";
//static NSString* const youku=@"https://openapi.youku.com";

@interface AFRequestState()
@property NSMutableArray * NotfifyArray;

-(void)changeState:(id)notify;
-(void)setEnd;
-(void)start;
@end

@implementation AFRequestState

-(id)init
{
    self = [super init];
    _NotfifyArray = [NSMutableArray new];
    return self;
}

-(AFRequestState *)addNotifaction:(id)notify
{
//    NSValue * v = [NSValue valueWithNonretainedObject:notify];
    [_NotfifyArray addObject:notify];
    
    [self changeState:notify ];
    
    return self;
}

-(void)changeState:(id)notify
{
    if( [notify isKindOfClass:[MJRefreshBaseView class]]){
        if( _running ){
            //            [(MJRefreshBaseView *)notify beginRefreshing];
        }
        else{
            [(MJRefreshBaseView *)notify endRefreshing];
        }
    }
    if( [notify isKindOfClass:[MBProgressHUD class]]){
        if( _running ){
            [(MBProgressHUD *)notify show:YES];
        }
        else{
            [(MBProgressHUD *)notify removeFromSuperview];
        }
    }}

-(void)setEnd;
{
    _running = NO;
    
    for( id notify in _NotfifyArray ){
        [self changeState:notify];//[(NSValue *)notify nonretainedObjectValue]];
    }
    
    [_NotfifyArray removeAllObjects];
}

-(void)start
{
    _running = YES;
    
    for( id notify in _NotfifyArray ){
        [self changeState:[(NSValue *)notify nonretainedObjectValue]];
    }
}

@end

@interface UploadImgResp : NSObject<Expose>
@property (nonatomic, strong) NSString * img;
@end

@implementation UploadImgResp
@end

@implementation AFAppRequest

//创建单例
+(AFAppRequest*)sharedClient
{
    static AFAppRequest* _AFRequest = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        _AFRequest=[[AFAppRequest alloc]initWithBaseURL:[NSURL URLWithString:BASEURL]];
    });
    
    return _AFRequest;
}

+(AFHTTPRequestOperationManager *)sharedManager
{
    static AFHTTPRequestOperationManager* _om = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        _om =[[AFHTTPRequestOperationManager alloc]initWithBaseURL:[NSURL URLWithString:WC_API]];
    });
    
    return _om;
}


//无token加密
+(NSMutableDictionary*)getURLSign:(NSString*)path
{
    NSString*urlStr=[NSString stringWithFormat:@"%@/%@",WC_API,path];
    NSString*base64=[GeneralizedProcessor base64StringFromText:urlStr];
    
    return [NSMutableDictionary dictionaryWithObjectsAndKeys:base64,@"urlSign",nil];
}


//有token加密
//+(NSMutableDictionary*)getURLSignaAndTokenDic:(NSString*)path
//{
//   NSString*urlStr=[NSString stringWithFormat:@"%@/%@",WC_API,path];
//    NSString*base64=[GeneralizedProcessor base64StringFromText:urlStr];
//    NSString*token= [[AccountModel instance] getToken];
//    return   [NSMutableDictionary dictionaryWithObjectsAndKeys:base64,@"urlSign",token,@"authSign", nil];
//}

//上传数据统一错误处理
+(AFRequestState *)postRequestWithToken:(NSString *)url param:(NSDictionary *)param succ:(void (^)(id))succ
{
    return [self postRequestWithToken:url param:param succ:succ resp:nil];
}

//上传数据处理特定错误码
+(AFRequestState *)postRequestWithToken:(NSString *)url param:(NSDictionary *)param succ:(void (^)(id))succ fail:(void (^)(int errCode, NSError * err))fail
{
    return [self postRequestWithToken:url param:param succ:succ fail:fail resp:nil];
}

+(AFRequestState *)postRequestWithToken:(NSString *)url param:(NSDictionary *)param succ:(void (^)(id))succ resp:(Class)resp
{
    return [self postRequestWithToken:url param:param succ:succ fail:^(int errCode, NSError *err) {

        [self error_hanlde:errCode Witherr:err];
        
    } resp:resp];
}

//统一错误处理
+(void)error_hanlde:(int)errCode Witherr:(NSError *)err {
    
    if(err.code == -1009)
    {
        [self creatembHub:@"没有网络"];
    }
    if(errCode == 1003)//err.code == - 1003)
    {
//        [AppDelegate errorAndRelogin];
        
    }
    if (errCode==5551) {
        [self creatembHub:@"~亲，暂时没有评论哦，快来成为第一个评论者吧"];
        
        
    }
}


+(void)creatembHub:(NSString *)message
{
//    AppDelegate * app = [AppDelegate instance];
//    MBProgressHUD * mbHud = [[MBProgressHUD alloc] initWithWindow:app.window];
//    [app.window addSubview:mbHud];
//    mbHud.labelText = message;
//    mbHud.mode = MBProgressHUDModeText;
//    
//    
//    [mbHud showAnimated:YES whileExecutingBlock:^{
//        sleep(1);
//        
//    } completionBlock:^{
//        [mbHud removeFromSuperview];
//    }];
}

//+(AFRequestState *)postRequestWithToken:(NSString *)url param:(NSDictionary *)param succ:(void (^)(id))succ fail:(void (^)(int errCode, NSError * err))fail resp:(Class)resp;
//{
//    NSString * urlStr = [WC_API stringByAppendingString:url];
//    NSString * base64=[GeneralizedProcessor base64StringFromText:urlStr];
//    
////    NSString * token = [[AccountModel instance] getToken];
//
//    
////    if( token == nil )
////    {
////        fail(11000, nil);
////        return nil;
////    }
//    
////    NSMutableDictionary * sign = [[NSMutableDictionary alloc]initWithDictionary:@{@"urlSign":base64, @"authSign":token}];
////    
////    [sign addEntriesFromDictionary:param];
////    
////    AFRequestState * State = [AFRequestState new];
////    [[self sharedClient] POST:url parameters:sign success:^(AFHTTPRequestOperation * operation, id responseObject)
////     {
////         [self handleResponse:responseObject Succ:succ Fail:fail Resp:resp State:State];
////         
////     } failure:^(AFHTTPRequestOperation *operation, NSError *error)
////     {
////         fail(0, error);
////         [State setEnd];
////     }];
////    
////    [State start];
////    return State;
//}

+(void)handleResponse:(id)responseObject Succ:(void (^)(id data))succ Fail:(void (^)(int errCode, NSError * err))fail Resp:(Class)resp State:(AFRequestState *)State;
{
    
    @try
    {
        if([responseObject isKindOfClass:[NSData class]])
        {
            responseObject = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        }
        
        if( responseObject == nil )
        {
            fail(10002, nil);
            return;
        }
        
        int error_code = [[responseObject objectForKey:@"error_code"] intValue];
        
        if( error_code != 0)
        {
            fail(error_code, nil);
            return;
        }
        
        id data = [Gson fromObj:[responseObject objectForKey:@"data"] Cls:resp];
        
        if( data == nil && resp != [NSNull class] )
        {
            fail(10001, nil);
            return;
        }
        
        succ(data);
    }
    @catch(NSException * excep){
        fail(10000, nil);
    }
    @finally{
        [State setEnd];
    }
}

+(AFRequestState *)postImageFlag:(BOOL)flag url:(NSString *)url succ:(void(^)(id img))succ WithData:(NSDictionary *)data fail:(void (^)(int errCode, NSError * err))fail
{

     NSMutableDictionary*parameter= [self getURLSignaAndTokenDic:url];
    [parameter setValuesForKeysWithDictionary:data];
    AFHTTPRequestOperationManager*manager=[self sharedClient];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        manager.responseSerializer.acceptableContentTypes =[NSSet setWithObject:@"application/json"];
    AFRequestState * State = [AFRequestState new];
    [manager POST:url parameters:parameter constructingBodyWithBlock:^(id<AFMultipartFormData> formData)

     {
         
         if(flag){
            [formData appendPartWithFileData:UIImagePNGRepresentation([data objectForKey:@"feedcontent_pic"]) name:@"Filedata" fileName:@"upload.png" mimeType:@"image/png"];
           
         }
         else{
             for (int i =0; i<[[data objectForKey:@"feedcontent_pic"]  count]; i++) {
                 
                 
                 [formData appendPartWithFileData:UIImagePNGRepresentation([[data objectForKey:@"feedcontent_pic"] objectAtIndex:i]) name:[NSString stringWithFormat: @"Filedata%d",i ] fileName:@"test1.png" mimeType:@"image/png"];
             }
         }
         
     } success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         if(flag){
             [self handleResponse:responseObject Succ:^(id data) {
                 succ(((UploadImgResp *)data).img);
                 
             } Fail:fail Resp:[UploadImgResp class] State:State];
         }
         else{
             [self handleResponse:responseObject Succ:^(id data) {
                 succ([NSNumber numberWithInt:(int)data]);
                 
             } Fail:fail Resp:nil State:State];
         }
         
         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         [self creatembHub:@"上传失败"];
         [State setEnd];
     }];
    [State start];
    return State;
}

+(AFRequestState *)postRequestWithPost:(NSString *)url param:(NSDictionary *)param saveData:(void (^)(NSDictionary*dic))saveData succ:(void (^)(NSDictionary*dic))succ fail:(void (^)(int errCode, NSError * err))fail
{
    NSMutableDictionary*sign=[AFAppRequest getURLSign:url];
    
    [sign addEntriesFromDictionary:param];
    
    AFRequestState * State = [AFRequestState new];

    [[self sharedClient] POST:url parameters:sign success:^(AFHTTPRequestOperation * operation, id responseObject)
    {
        [self handleResponse:responseObject Succ:succ Fail:fail Resp:nil State:State];
        [self handleResponse:responseObject Succ:saveData Fail:fail Resp:nil State:State];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error)
    {
        fail(0,error);
        [State setEnd];
    }];
    
    [State start];
    return State;
}



+(AFRequestState *)postRequestWithlogRequest:(NSString *)url param:(NSDictionary *)param saveData:(void (^)(NSDictionary*dic))saveData succ:(void (^)(id))succ fail:(void (^)(int errCode, NSError * err))fail
{

    NSMutableDictionary*sign=[AFAppRequest getURLSign:url];
    
    [sign addEntriesFromDictionary:param];
    
    AFRequestState * State = [AFRequestState new];
    
    [[self sharedClient] GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         [self handleResponse:responseObject Succ:succ Fail:fail Resp:nil State:State];
         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         fail(0,error);
         [State setEnd];
     }];
    
    [State start];
    return State;

}



@end
