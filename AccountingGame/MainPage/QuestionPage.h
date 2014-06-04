//
//  QuestionPage.h
//  AccountingGame
//
//  Created by 张超 on 13-9-9.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "NetWebServiceRequest.h"
#import "MBProgressHUD.h"

@interface QuestionPage : CCLayer <NetWebServiceRequestDelegate>{
    //滑动精灵
    CCSprite * cal;
    //估测距离
    float y;
    float y1;
    float y2;
    float y3;
    float y4;
    MBProgressHUD *HUD;
    
    NSString *Status;
    
}
+(CCScene *)scene;
@property(nonatomic,retain) NetWebServiceRequest *runningRequest;
//每道题信息
@property(nonatomic,retain)NSArray *answerInfo;

@end
