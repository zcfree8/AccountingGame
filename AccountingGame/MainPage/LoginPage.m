//
//  LoginPage.m
//  AccountingGame
//
//  Created by 张超 on 13-9-23.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import "LoginPage.h"



@implementation LoginPage

+(CCScene *)scene{
    
    CCScene *scene=[CCScene node];
    
    LoginPage *layer=[LoginPage node];
    
    [scene addChild:layer];
    
    return scene;
}

-(id)init{
    if (self=[super init]) {
        view1=[[loginViewController alloc]initWithNibName:@"loginViewController" bundle:nil];
        [[CCDirector sharedDirector].view addSubview:view1.view];
    }
    return self;
}



-(void)dealloc{
    CCLOG(@"1");
    [super dealloc];
}
@end
