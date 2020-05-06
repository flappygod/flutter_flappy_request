#import "FlutterflappyrequestPlugin.h"
#import "FlappyJsonTool.h"
#import "LXHttpsRequest.h"

@implementation FlutterflappyrequestPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
    FlutterMethodChannel* channel = [FlutterMethodChannel
                                     methodChannelWithName:@"flutterflappyrequest"
                                     binaryMessenger:[registrar messenger]];
    FlutterflappyrequestPlugin* instance = [[FlutterflappyrequestPlugin alloc] init];
    [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
    //发送post请求
    if ([@"postParam" isEqualToString:call.method]) {
        //请求地址
        NSString* url=(NSString*)call.arguments[@"url"];
        //请求header
        NSString* header=(NSString*)call.arguments[@"header"];
        //请求body
        NSString* body=(NSString*)call.arguments[@"body"];
        //超时时间
        NSInteger timeout=[(NSString*)call.arguments[@"timeout"] integerValue];
        //开始请求
        LXHttpsRequest* req=[[LXHttpsRequest alloc]init];
        //超时时间
        req.timeOut=timeout;
        //成功
        req.successBlock=^(NSString*  data){
            result(data);
        };
        //失败
        req.errorBlock=^(NSException*  error,NSInteger code){
            result([FlutterError errorWithCode:[NSString stringWithFormat:@"%ld",(long)code]
                                       message:error.description
                                       details:[FlappyJsonTool JSONObjectToJSONString:error.userInfo]]);
        };
        //请求params
        req.params=[NSMutableDictionary dictionaryWithDictionary:[FlappyJsonTool JSONStringToDictionary:body]];
        //请求header
        req.headerProperty=[NSMutableDictionary dictionaryWithDictionary:[FlappyJsonTool JSONStringToDictionary:header]];
        //请求地址
        req.url=url;
        //发送请求
        [req postAsParam];
        
    } else if ([@"postJson" isEqualToString:call.method]) {
        //请求地址
        NSString* url=(NSString*)call.arguments[@"url"];
        //请求header
        NSString* header=(NSString*)call.arguments[@"header"];
        //请求body
        NSString* body=(NSString*)call.arguments[@"body"];
        //超时时间
        NSInteger timeout=[(NSString*)call.arguments[@"timeout"] integerValue];
        //开始请求
        LXHttpsRequest* req=[[LXHttpsRequest alloc]init];
        //超时时间
        req.timeOut=timeout;
        //成功
        req.successBlock=^(NSString*  data){
            result(data);
        };
        //失败
        req.errorBlock=^(NSException*  error,NSInteger code){
            result([FlutterError errorWithCode:[NSString stringWithFormat:@"%ld",(long)code]
                                       message:error.description
                                       details:[FlappyJsonTool JSONObjectToJSONString:error.userInfo]]);
        };
        //请求params
        req.params=[NSMutableDictionary dictionaryWithDictionary:[FlappyJsonTool JSONStringToDictionary:body]];
        //请求header
        req.headerProperty=[NSMutableDictionary dictionaryWithDictionary:[FlappyJsonTool JSONStringToDictionary:header]];
        //请求地址
        req.url=url;
        //发送请求
        [req postAsJson];
        
    }else if ([@"get" isEqualToString:call.method]) {
        //请求地址
        NSString* url=(NSString*)call.arguments[@"url"];
        //请求header
        NSString* header=(NSString*)call.arguments[@"header"];
        //请求body
        NSString* body=(NSString*)call.arguments[@"body"];
        //超时时间
        NSInteger timeout=[(NSString*)call.arguments[@"timeout"] integerValue];
        //开始请求
        LXHttpsRequest* req=[[LXHttpsRequest alloc]init];
        //超时时间
        req.timeOut=timeout;
        //成功
        req.successBlock=^(NSString*  data){
            result(data);
        };
        //失败
        req.errorBlock=^(NSException*  error,NSInteger code){
            result([FlutterError errorWithCode:[NSString stringWithFormat:@"%ld",(long)code]
                                       message:error.description
                                       details:[FlappyJsonTool JSONObjectToJSONString:error.userInfo]]);
        };
        //请求params
        req.params=[NSMutableDictionary dictionaryWithDictionary:[FlappyJsonTool JSONStringToDictionary:body]];
        //请求header
        req.headerProperty=[NSMutableDictionary dictionaryWithDictionary:[FlappyJsonTool JSONStringToDictionary:header]];
        //请求地址
        req.url=url;
        //发送请求
        [req get];
    }else {
        result(FlutterMethodNotImplemented);
    }
}

@end
