//
//  MainUIPage.h
//  AccountingGame
//
//  Created by 张超 on 13-9-9.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import <UIKit/UIKit.h>
#import "NetWebServiceRequest.h"
#import "MBProgressHUD.h"


@interface MainUIPage : CCLayer<NetWebServiceRequestDelegate,UIScrollViewDelegate> {
    UIScrollView *scrollView;
    MBProgressHUD *HUD;
    
}

+(CCScene *) scene;

@property(nonatomic,retain)NSArray *dataMutArr;

@property(nonatomic,retain) NetWebServiceRequest *runningRequest;

@end
