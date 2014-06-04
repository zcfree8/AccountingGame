//
//  LoginPage.h
//  AccountingGame
//
//  Created by 张超 on 13-9-23.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "loginViewController.h"
#import "cocos2d.h"

@interface LoginPage : CCLayer {
    loginViewController *view1;
}

+(CCScene *)scene;

@end
