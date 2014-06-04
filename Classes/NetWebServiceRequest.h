//
//  NetWebServiceRequest.h
//  HttpRequest
//
//  Created by Richard Liu on 13-3-18.
//  Copyright (c) 2013年 Richard Liu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"


typedef enum _NetworkRequestErrorType {
    NetRequestConnectionFailureErrorType = 1,
    NetRequestTimedOutErrorType = 2,
	
} NetworkRequestErrorType;


extern NSString* const NetWebServiceRequestErrorDomain;

@interface Parameter : NSObject

@property(assign)NSString *Name;
@property(assign)NSString *Key;

-(id)initParamWithName:(NSString *)Name AndKey:(NSString *)Key;

@end

@protocol NetWebServiceRequestDelegate;

@interface NetWebServiceRequest : NSObject 

@property (nonatomic, assign) id<NetWebServiceRequestDelegate> delegate;
@property (nonatomic, assign) NSInteger tag;

+(id)serviceRequestUrl:(NSString *)WebURL
         SOAPActionURL:(NSString *)soapActionURL
     ServiceMethodName:(NSString *)strMethod
        SoapMessageArr:(NSArray *)soapMsgArr;

//创建请求对象
- (id)initWithUrl:(NSString *)WebURL
    SOAPActionURL:(NSString *)soapActionURL
ServiceMethodName:(NSString *)strMethod
   SoapMessageArr:(NSArray *)soapMsgArr;

- (void)cancel;

- (BOOL)isCancelled;
- (BOOL)isExecuting;
- (BOOL)isFinished;

- (void)startAsynchronous;
- (void)startSynchronous;
-(NSString *)responseString;

@end



@protocol NetWebServiceRequestDelegate <NSObject>

@optional


//开始
- (void)netRequestStarted:(NetWebServiceRequest *)request;
//失败
- (void)netRequestFailed:(NetWebServiceRequest *)request didRequestError:(NSError *)error;

@required
//成功
- (void)netRequestFinished:(NetWebServiceRequest *)request
      finishedInfoToResult:(NSString *)result
              responseData:(NSData *)requestData;


@end

