//
//  NotePage.h
//  AccountingGame
//
//  Created by 张超 on 13-9-9.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "NetWebServiceRequest.h"
#import "MBProgressHUD.h"

@interface NotePage : CCLayer <NetWebServiceRequestDelegate>{

    MBProgressHUD *HUD;
}
+(CCScene *)scene;

@property(nonatomic,retain) NetWebServiceRequest *runningRequest;

@property(nonatomic,retain)NSArray *answerInfo;

@property(assign)int i;



@end
