//
//  ServiceHelper.m
//  HttpRequest
//
//  Created by Richard Liu on 13-3-18.
//  Copyright (c) 2013年 Richard Liu. All rights reserved.
//

#import "NetWebServiceRequest.h"
#import "SoapXmlParseHelper.h"



NSString* const NetWebServiceRequestErrorDomain = @"NetWebServiceRequestErrorDomain";


@interface NetWebServiceRequest ()<ASIHTTPRequestDelegate>

@property (nonatomic, retain) __block ASIHTTPRequest* runningRequest;
@property (nonatomic, retain) NSRecursiveLock *cancelLock;

@end

@implementation Parameter

-(id)initParamWithName:(NSString *)Name AndKey:(NSString *)Key{
    if(self=[super init]){
        self.Name=Name;
        self.Key=Key;
    }
    return self;
}

@end

@implementation NetWebServiceRequest
@synthesize runningRequest = _runningRequest;
@synthesize delegate = _delegate;
@synthesize cancelLock = _cancelLock;
@synthesize tag;



+(id)serviceRequestUrl:(NSString *)WebURL SOAPActionURL:(NSString *)soapActionURL ServiceMethodName:(NSString *)strMethod SoapMessageArr:(NSArray *)soapMsgArr{
    return [[[self alloc]initWithUrl:WebURL SOAPActionURL:soapActionURL ServiceMethodName:strMethod SoapMessageArr:soapMsgArr]autorelease];
}


//创建请求对象
- (id)initWithUrl:(NSString *)WebURL SOAPActionURL:(NSString *)soapActionURL
ServiceMethodName:(NSString *)strMethod
      SoapMessageArr:(NSArray *)soapMsgArr
{
	//请求发送到的路径
    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"%@", WebURL]];
    
	if ((self = [super init])) {
        self.runningRequest = [[ASIHTTPRequest alloc] initWithURL:url];
        NSString *soapMsg=@"";
        NSString *soapMsgHead=[NSString stringWithFormat:
                               @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                               "<soap:Envelope %@>\n"
                               "<soap:Body>\n"
                               "<%@ xmlns=\"%@\">\n",Envelopesoap,strMethod,NameSpace];
        NSString *soapMagTail=[NSString stringWithFormat:
                               @"</%@>\n"
                                "</soap:Body>\n"
                                "</soap:Envelope>\n",strMethod];
        soapMsg=soapMsgHead;
        for(Parameter *Param in soapMsgArr){
            soapMsg=[NSString stringWithFormat:
                     @"%@"
                     "<%@>%@</%@>\n",soapMsg,Param.Name,Param.Key,Param.Name];
        }
        soapMsg=[NSString stringWithFormat:
                @"%@"
                 "%@",soapMsg,soapMagTail];
        
        NSString *msgLength = [NSString stringWithFormat:@"%lu", (unsigned long)[soapMsg length]];
        
        //以下对请求信息添加属性前四句是必有的，第五句是soap信息。
        [self.runningRequest addRequestHeader:@"Host" value:[url host]];
        [self.runningRequest addRequestHeader:@"Content-Type" value:@"text/xml; charset=utf-8"];
        [self.runningRequest addRequestHeader:@"Content-Length" value:msgLength];
        [self.runningRequest addRequestHeader:@"SOAPAction" value:[NSString stringWithFormat:@"%@",soapActionURL]];
        [self.runningRequest setRequestMethod:@"POST"];
        //传soap信息
        [self.runningRequest appendPostData:[soapMsg dataUsingEncoding:NSUTF8StringEncoding]];
        [self.runningRequest setValidatesSecureCertificate:NO];
        [self.runningRequest setTimeOutSeconds:60.0];
        [self.runningRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
        
        
        self.runningRequest.delegate = self;
#ifdef SSL
        [self.runningRequest setValidatesSecureCertificate:NO];
#else
        [self.runningRequest setValidatesSecureCertificate:YES];
#endif
        
        
        self.cancelLock = [[NSRecursiveLock alloc]  init];
    }
	return self;
}

-(void)dealloc{
    [self cancel];
    [super dealloc];
}



- (BOOL)isCancelled
{
    return [self.runningRequest isCancelled];
}

- (BOOL)isExecuting
{
    return [self.runningRequest isExecuting];
}

- (BOOL)isFinished
{
    return [self.runningRequest isFinished];
}


- (void) setDelegate:(id)delegate
{
    [self.cancelLock lock];
    
    _delegate = delegate;
    
    [self.cancelLock unlock];
}



- (void)startAsynchronous
{
//    CLog(@"Url_path:%@",_runningRequest.url);
//    CLog(@"Method:%@",_runningRequest.requestMethod);
    //CLog(@"PostData:%@",_runningRequest.postBody);
    [_runningRequest startAsynchronous];

}

-(void)startSynchronous{
    
//    CLog(@"Url_path:%@",_runningRequest.url);
//    CLog(@"Method:%@",_runningRequest.requestMethod);
    //CLog(@"PostData:%@",_runningRequest.postBody);
    [_runningRequest startSynchronous];
    
}

-(NSString *)responseString{
    NSError *error=[_runningRequest error];
    NSString *result=@"";
    if(!error){
        NSString *responseString=[_runningRequest responseString];
        
        
        NSString *soapAction = [[_runningRequest requestHeaders] objectForKey:@"SOAPAction"];
        NSArray *arraySOAP =[soapAction componentsSeparatedByString:@"/"];
        int count = (int)[arraySOAP count] - 1;
        NSString *methodName = [arraySOAP objectAtIndex:count];
        result = [SoapXmlParseHelper SoapMessageResultXml:responseString ServiceMethodName:methodName];
        
    }
    return result;
    
    
    
}

- (void) cancel
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
//    CLog(@"begin");
    [self.cancelLock lock];
    
    self.delegate = nil;
    
    if (self.runningRequest) {
        [self.runningRequest clearDelegatesAndCancel];
        self.runningRequest = nil;
    }
    
    [self.cancelLock unlock];
    
//    CLog(@"end");
}


- (void)NetWebServiceRequestStarted
{
//    CLog(@"begin");
    if (_delegate && [_delegate respondsToSelector:@selector(netRequestStarted:)]) {
        [self.delegate netRequestStarted:self];
    }
//    CLog(@"end");
}



- (void)FinisheddidRecvedInfoToResult:(NSString *)result responseData:(NSData*)requestData
{
//    CLog(@"begin");
    if (_delegate && [_delegate respondsToSelector:@selector(netRequestFinished: finishedInfoToResult: responseData:)]) {
		[_delegate netRequestFinished:self finishedInfoToResult:result responseData:requestData];
	}
//    CLog(@"end");
}

- (void) FaileddidRequestError:(NSError *)error
{
//    CLog(@"begin");
    
    if (_delegate && [_delegate respondsToSelector:@selector(netRequestFailed:didRequestError:)]) {
        [_delegate netRequestFailed:self didRequestError:error];
    }
//    CLog(@"end");
}




#pragma mark -
#pragma mark - ASIHTTPRequestDelegate Methods
- (void)requestStarted:(ASIHTTPRequest *)request
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [self NetWebServiceRequestStarted];
}


- (void)requestFinished:(ASIHTTPRequest *)request
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
    int statusCode = [request responseStatusCode];
	NSString *soapAction = [[request requestHeaders] objectForKey:@"SOAPAction"];
    
    NSArray *arraySOAP =[soapAction componentsSeparatedByString:@"/"];
    int count = (int)[arraySOAP count] - 1;
	NSString *methodName = [arraySOAP objectAtIndex:count];
    
 
	// Use when fetching text data
	NSString *responseString = [request responseString];
	NSString *result = nil;
    if (statusCode == 200) {
        //表示正常请求
        result = [SoapXmlParseHelper SoapMessageResultXml:responseString ServiceMethodName:methodName];

        NSData *responseData = [request responseData];
        [self FinisheddidRecvedInfoToResult:result responseData:responseData];
    }
    else{
        NSError *error;
        
        if (request.responseStatusMessage) {
            error = ERROR_INFO(NetWebServiceRequestErrorDomain, request.responseStatusCode,request.responseStatusMessage);
        }
        else {
            error = ERROR_NOINFO(NetWebServiceRequestErrorDomain, request.responseStatusCode);
        }
        
//        CLog(@"error:%@",error);
        
        [self FaileddidRequestError:error];
    }
}



- (void)requestFailed:(ASIHTTPRequest *)request
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
  
    NSError *error = ERROR_DICTINFO(NetWebServiceRequestErrorDomain, request.error.code, request.error.userInfo);
    
    if (error.code == ASIRequestTimedOutErrorType) {
        error = ERROR_INFO(NetWebServiceRequestErrorDomain, NetRequestTimedOutErrorType, @"网络连接超时");
    }
    else if (error.code == ASIConnectionFailureErrorType)
    {
        error = ERROR_INFO(NetWebServiceRequestErrorDomain, NetRequestConnectionFailureErrorType, @"未连接网络");
    }
    
    //网络错误
    [self FaileddidRequestError:error];
	
}






@end
