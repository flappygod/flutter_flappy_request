//
//  LXHttpsRequest.m
//  zhichuangyanbao
//
//  Created by macbook air on 16/12/16.
//  Copyright © 2016年 zhichuangyanbao. All rights reserved.
//

#import "LXHttpsRequest.h"
#import "FlappyJsonTool.h"



@implementation LXHttpsRequest



// 当前版本
#define FSystemVersion          ([[[UIDevice currentDevice] systemVersion] floatValue])
#define DSystemVersion          ([[[UIDevice currentDevice] systemVersion] doubleValue])
#define SSystemVersion          ([[UIDevice currentDevice] systemVersion])



//因为苹果之后都是异步操作，所以之后的都只写异步的了，同步相当于已经废弃

//直接get
-(void)get{
    //空的不执行
    if(self.url==nil){
        return;
    }
    NSMutableURLRequest* request=[self getParamGetRequest];
    //创建session
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]
                                                          delegate:self
                                                     delegateQueue:[NSOperationQueue mainQueue]];
    //执行get请求
    NSURLSessionDataTask *postDataTask = [session dataTaskWithRequest:request
                                                    completionHandler:^(NSData * _Nullable data,
                                                                        NSURLResponse * _Nullable response,
                                                                        NSError * _Nullable error) {
        //返回值
        NSInteger retCode=-1;
        //请求参数
        if(response!=nil&&[response isKindOfClass:[NSHTTPURLResponse class]]){
            NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
            retCode=[httpResponse statusCode];
        }
        //成功
        if(response!=nil&&error==nil){
            //成功时执行
            if(retCode==200){
                //成功
                NSString* resultStr = [[NSString alloc]initWithData:data
                                                           encoding:NSUTF8StringEncoding];
                [self performSelectorOnMainThread:@selector(dataSuccess:)
                                       withObject:resultStr
                                    waitUntilDone:YES];
            }else{
                //返回的字符串
                NSString* resultStr = [[NSString alloc]initWithData:data
                                                           encoding:NSUTF8StringEncoding];
                NSException* exception=[[NSException alloc]initWithName:@"HTTP STATE ERROR"
                                                                 reason:resultStr
                                                               userInfo:nil];
                //错误数据
                NSMutableDictionary* object=[[NSMutableDictionary alloc] init];
                //exception
                [object setObject:exception forKey:@"error"];
                //返回数据
                [object setObject:[NSNumber numberWithInteger:retCode] forKey:@"code"];
                //数据
                [self performSelectorOnMainThread:@selector(dataError:)
                                       withObject:object
                                    waitUntilDone:YES];
            }
        }
        //失败
        else{
            //返回值
            NSInteger retCode=-1;
            //不为空
            if(response!=nil&&[response isKindOfClass:[NSHTTPURLResponse class]]){
                NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
                retCode=[httpResponse statusCode];
            }
            //原因
            NSString* reason=(error==nil? nil:error.description);
            //info
            NSDictionary* info=(error==nil? nil:error.userInfo);
            //返回
            NSException* exception=[[NSException alloc]initWithName:@"NET_ERROR"
                                                             reason:reason
                                                           userInfo:info];
            //错误数据
            NSMutableDictionary* object=[[NSMutableDictionary alloc] init];
            //exception
            [object setObject:exception forKey:@"error"];
            //返回数据
            [object setObject:[NSNumber numberWithInteger:retCode] forKey:@"code"];
            
            [self performSelectorOnMainThread:@selector(dataError:)
                                   withObject:object
                                waitUntilDone:YES];
        }
    }];
    [postDataTask resume];
}


//以json形式进行post
-(void)postAsJson{
    //创建request
    NSMutableURLRequest* req=[self getJsonPostRequest];
    //创建session
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    //执行post请求
    NSURLSessionDataTask *postDataTask = [session dataTaskWithRequest:req completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        //返回值
        NSInteger retCode=-1;
        //请求参数
        if(response!=nil&&[response isKindOfClass:[NSHTTPURLResponse class]]){
            NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
            retCode=[httpResponse statusCode];
        }
        //成功
        if(response!=nil&&error==nil){
            //成功时执行
            if(retCode==200){
                //成功
                NSString* resultStr = [[NSString alloc]initWithData:data
                                                           encoding:NSUTF8StringEncoding];
                [self performSelectorOnMainThread:@selector(dataSuccess:)
                                       withObject:resultStr
                                    waitUntilDone:YES];
            }else{
                //返回的字符串
                NSString* resultStr = [[NSString alloc]initWithData:data
                                                           encoding:NSUTF8StringEncoding];
                NSException* exception=[[NSException alloc]initWithName:@"HTTP STATE ERROR"
                                                                 reason:resultStr
                                                               userInfo:nil];
                //错误数据
                NSMutableDictionary* object=[[NSMutableDictionary alloc] init];
                //exception
                [object setObject:exception forKey:@"error"];
                //返回数据
                [object setObject:[NSNumber numberWithInteger:retCode] forKey:@"code"];
                //数据
                [self performSelectorOnMainThread:@selector(dataError:)
                                       withObject:object
                                    waitUntilDone:YES];
            }
        }
        //失败
        else{
            //返回值
            NSInteger retCode=-1;
            //不为空
            if(response!=nil&&[response isKindOfClass:[NSHTTPURLResponse class]]){
                NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
                retCode=[httpResponse statusCode];
            }
            //原因
            NSString* reason=(error==nil? nil:error.description);
            //info
            NSDictionary* info=(error==nil? nil:error.userInfo);
            //返回
            NSException* exception=[[NSException alloc]initWithName:@"NET_ERROR"
                                                             reason:reason
                                                           userInfo:info];
            //错误数据
            NSMutableDictionary* object=[[NSMutableDictionary alloc] init];
            //exception
            [object setObject:exception forKey:@"error"];
            //返回数据
            [object setObject:[NSNumber numberWithInteger:retCode] forKey:@"code"];
            
            [self performSelectorOnMainThread:@selector(dataError:)
                                   withObject:object
                                waitUntilDone:YES];
        }
    }];
    [postDataTask resume];
}

//以param形式进行post
-(void)postAsParam{
    //获取post
    NSMutableURLRequest* req=[self getParamPostRequest];
    //创建session
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    //执行post请求
    NSURLSessionDataTask *postDataTask = [session dataTaskWithRequest:req completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        //返回值
        NSInteger retCode=-1;
        //请求参数
        if(response!=nil&&[response isKindOfClass:[NSHTTPURLResponse class]]){
            NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
            retCode=[httpResponse statusCode];
        }
        //成功
        if(response!=nil&&error==nil){
            //成功时执行
            if(retCode==200){
                //成功
                NSString* resultStr = [[NSString alloc]initWithData:data
                                                           encoding:NSUTF8StringEncoding];
                [self performSelectorOnMainThread:@selector(dataSuccess:)
                                       withObject:resultStr
                                    waitUntilDone:YES];
            }else{
                //返回的字符串
                NSString* resultStr = [[NSString alloc]initWithData:data
                                                           encoding:NSUTF8StringEncoding];
                NSException* exception=[[NSException alloc]initWithName:@"HTTP STATE ERROR"
                                                                 reason:resultStr
                                                               userInfo:nil];
                //错误数据
                NSMutableDictionary* object=[[NSMutableDictionary alloc] init];
                //exception
                [object setObject:exception forKey:@"error"];
                //返回数据
                [object setObject:[NSNumber numberWithInteger:retCode] forKey:@"code"];
                //数据
                [self performSelectorOnMainThread:@selector(dataError:)
                                       withObject:object
                                    waitUntilDone:YES];
            }
        }
        //失败
        else{
            //返回值
            NSInteger retCode=-1;
            //不为空
            if(response!=nil&&[response isKindOfClass:[NSHTTPURLResponse class]]){
                NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
                retCode=[httpResponse statusCode];
            }
            //原因
            NSString* reason=(error==nil? nil:error.description);
            //info
            NSDictionary* info=(error==nil? nil:error.userInfo);
            //返回
            NSException* exception=[[NSException alloc]initWithName:@"NET_ERROR"
                                                             reason:reason
                                                           userInfo:info];
            //错误数据
            NSMutableDictionary* object=[[NSMutableDictionary alloc] init];
            //exception
            [object setObject:exception forKey:@"error"];
            //返回数据
            [object setObject:[NSNumber numberWithInteger:retCode] forKey:@"code"];
            
            [self performSelectorOnMainThread:@selector(dataError:)
                                   withObject:object
                                waitUntilDone:YES];
        }
    }];
    [postDataTask resume];
}

//get请求的情况下获取request
-(NSMutableURLRequest*)getParamGetRequest{
    //拼接支付穿
    NSString *paramString;
    if(self.params!=nil)
    {
        paramString=[NSString stringWithFormat:@"%@?%@",self.url,[self parseParams:_params]];
    }else{
        paramString=self.url;
    }
    NSString *urlString=paramString;
    //特殊处理
    if(DSystemVersion<9.0)
    {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        urlString = [urlString stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
#pragma clang diagnostic pop
    }
    else{
        urlString = [urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet characterSetWithCharactersInString:@"`#%^{}\"[]|\\<> "].invertedSet];
    }
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString: urlString]];
    [request setCachePolicy:NSURLRequestReloadIgnoringCacheData];
    //超时时间
    [request setTimeoutInterval: self.timeOut ==0? 60:self.timeOut];
    //是否启用cookie
    [request setHTTPShouldHandleCookies:self.enableCookie];
    //get
    [request setHTTPMethod:@"GET"];
    //添加header
    if(self.headerProperty!=nil){
        NSEnumerator *keyEnum = [self.headerProperty keyEnumerator];
        id key;
        while (key = [keyEnum nextObject]) {
            [request setValue:[self.headerProperty valueForKey:key] forHTTPHeaderField:key];
        }
    }
    return request;
}

//获取请求
-(NSMutableURLRequest*)getJsonPostRequest{
    //第一步，创建url
    NSURL *url = [NSURL URLWithString:self.url];
    //第二步，创建请求
    NSMutableURLRequest *req = [[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:self.timeOut];
    //超时时间
    [req setTimeoutInterval: self.timeOut ==0? 60:self.timeOut];
    //是否启用cookie
    [req setHTTPShouldHandleCookies:self.enableCookie];
    //设置为post方式
    [req setHTTPMethod:@"POST"];
    //json格式
    [req setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    //添加header
    if(self.headerProperty!=nil){
        NSEnumerator *keyEnum = [self.headerProperty keyEnumerator];
        id key;
        while (key = [keyEnum nextObject]) {
            [req setValue:[self.headerProperty valueForKey:key] forHTTPHeaderField:key];
        }
    }
    //设置为post请求
    if (self.params != nil )
    {
        NSString *parseParamsResult = [FlappyJsonTool JSONObjectToJSONString:self.params];
        NSData *postData = [parseParamsResult dataUsingEncoding:NSUTF8StringEncoding];
        [req setHTTPBody:postData];
    }
    return req;
}

//获取param形式的post
-(NSMutableURLRequest*)getParamPostRequest{
    //第一步，创建url
    NSURL *url = [NSURL URLWithString:self.url];
    //第二步，创建请求
    NSMutableURLRequest *req = [[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:self.timeOut];
    //超时时间
    [req setTimeoutInterval: self.timeOut ==0? 60:self.timeOut];
    //是否启用cookie
    [req setHTTPShouldHandleCookies:self.enableCookie];
    //设置为post方式
    [req setHTTPMethod:@"POST"];
    //param格式
    [req setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    //添加header
    if(self.headerProperty!=nil){
        NSEnumerator *keyEnum = [self.headerProperty keyEnumerator];
        id key;
        while (key = [keyEnum nextObject]) {
            [req setValue:[self.headerProperty valueForKey:key] forHTTPHeaderField:key];
        }
    }
    //设置为post请求
    if (self.params != nil )
    {
        NSString *parseParamsResult = [self parseParams:self.params];
        NSData *postData = [parseParamsResult dataUsingEncoding:NSUTF8StringEncoding];
        [req setHTTPBody:postData];
    }
    return req;
}





//把NSDictionary解析成post格式的NSString字符串
- (NSString *)parseParams:(NSDictionary *)params{
    NSString *keyValueFormat;
    NSMutableString *result = [NSMutableString new];
    //实例化一个key枚举器用来存放dictionary的key
    NSEnumerator *keyEnum = [params keyEnumerator];
    id key;
    while (key = [keyEnum nextObject]) {
        keyValueFormat = [NSString stringWithFormat:@"%@=%@&",key,[params valueForKey:key]];
        [result appendString:keyValueFormat];
    }
    NSString* paramStr=@"";
    if(result.length>1){
        paramStr=[result substringWithRange:NSMakeRange(0, result.length-1)];
        NSLog(@"post()方法参数解析结果：%@",paramStr);
    }
    return paramStr;
}



//请求完成
-(void)dataSuccess:(id) data{
    if(_successBlock!=nil)
    {
        _successBlock(data);
    }
}

//请求错误
-(void)dataError:(NSMutableDictionary*) data{
    if(_errorBlock!=nil)
    {
        //错误
        NSException* exeption=[data valueForKey:@"error"];
        //response
        NSInteger retCode=[[data valueForKey:@"code"] integerValue];
        //错误返回
        _errorBlock(exeption,retCode);
    }
}

//解压p12数据
-(OSStatus) extractP12Data:(CFDataRef)inP12Data
              withPassword:(NSString*)passstr
                toIdentity:(SecIdentityRef*)identity {
    
    OSStatus securityError = errSecSuccess;
    CFStringRef password = (__bridge CFStringRef)passstr;
    const void *keys[] = { kSecImportExportPassphrase };
    const void *values[] = { password };
    
    CFDictionaryRef options = CFDictionaryCreate(NULL, keys, values, 1, NULL, NULL);
    
    CFArrayRef items = CFArrayCreate(NULL, 0, 0, NULL);
    securityError = SecPKCS12Import(inP12Data, options, &items);
    
    if (securityError == 0) {
        CFDictionaryRef ident = CFArrayGetValueAtIndex(items,0);
        const void *tempIdentity = NULL;
        tempIdentity = CFDictionaryGetValue(ident, kSecImportItemIdentity);
        *identity = (SecIdentityRef)tempIdentity;
    }
    
    if (options) {
        CFRelease(options);
    }
    
    return securityError;
}

#pragma NSURLSessionDelegate

/* The last message a session receives.  A session will only become
 * invalid because of a systemic error or when it has been
 * explicitly invalidated, in which case the error parameter will be nil.
 */
- (void)URLSession:(NSURLSession *)session didBecomeInvalidWithError:(nullable NSError *)error{
    NSLog(@"%@",error.description);
}

/* If implemented, when a connection level authentication challenge
 * has occurred, this delegate will be given the opportunity to
 * provide authentication credentials to the underlying
 * connection. Some types of authentication will apply to more than
 * one request on a given connection to a server (SSL Server Trust
 * challenges).  If this delegate message is not implemented, the
 * behavior will be to use the default handling, which may involve user
 * interaction.
 */
- (void)URLSession:(NSURLSession *)session didReceiveChallenge:(NSURLAuthenticationChallenge *)challenge
 completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential * _Nullable credential))completionHandler{
    
    //获取验证的类型
    NSString *method = challenge.protectionSpace.authenticationMethod;
    
    //如果是服务器验证
    if([method isEqualToString:NSURLAuthenticationMethodServerTrust]){
        //获取host
        //NSString *host = challenge.protectionSpace.host;
        //创建证书
        NSURLCredential *credential = [NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust];
        //设置
        [challenge.sender useCredential:credential forAuthenticationChallenge:challenge];
        //安装证书
        completionHandler(NSURLSessionAuthChallengeUseCredential, credential);
        return;
    }
    //如果是客户端验证
    else if([method isEqualToString:NSURLAuthenticationMethodClientCertificate]){
        //如果是验证本地的
        NSString* password=@"";
        //本地的资源文件名称
        NSString* resourceName=@"";
        //p12文件
        NSString *thePath = [[NSBundle mainBundle] pathForResource:resourceName ofType:@"p12"];
        //p12数据
        NSData *PKCS12Data = [[NSData alloc] initWithContentsOfFile:thePath];
        //retain
        CFDataRef inPKCS12Data = (CFDataRef)CFBridgingRetain(PKCS12Data);
        
        SecIdentityRef identity;
        
        // 读取p12证书中的内容
        OSStatus result = [self extractP12Data:inPKCS12Data
                                  withPassword:password
                                    toIdentity:&identity];
        //读取不成功
        if(result != errSecSuccess){
            completionHandler(NSURLSessionAuthChallengeCancelAuthenticationChallenge, nil);
            return;
        }
        //读取成功
        SecCertificateRef certificate = NULL;
        //赋值
        SecIdentityCopyCertificate (identity, &certificate);
        
        const void *certs[] = {certificate};
        
        CFArrayRef certArray = CFArrayCreate(kCFAllocatorDefault, certs, 1, NULL);
        
        //创建证书
        NSURLCredential *credential = [NSURLCredential credentialWithIdentity:identity
                                                                 certificates:(NSArray*)CFBridgingRelease(certArray)
                                                                  persistence:NSURLCredentialPersistencePermanent];
        //返回过去
        completionHandler(NSURLSessionAuthChallengeUseCredential, credential);
    }else{
        completionHandler(NSURLSessionAuthChallengeCancelAuthenticationChallenge,nil);
    }
    
}

/* If an application has received an
 * -application:handleEventsForBackgroundURLSession:completionHandler:
 * message, the session delegate will receive this message to indicate
 * that all messages previously enqueued for this session have been
 * delivered.  At this time it is safe to invoke the previously stored
 * completion handler, or to begin any internal updates that will
 * result in invoking the completion handler.
 */
- (void)URLSessionDidFinishEventsForBackgroundURLSession:(NSURLSession *)session NS_AVAILABLE_IOS(7_0){
    
    
}




@end
