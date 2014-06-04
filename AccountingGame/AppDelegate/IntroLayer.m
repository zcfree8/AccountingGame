//
//  IntroLayer.m
//  AccountingGame
//
//  Created by 张超 on 13-9-23.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import "IntroLayer.h"
#import "CoverPage.h"
#import "LoginPage.h"
#import "MainPage.h"
#import "NotePage.h"
#import "SettingPage.h"

@implementation IntroLayer

+(CCScene *)scene{
    
    CCScene *scene=[CCScene node];
    
    IntroLayer *layer=[IntroLayer node];
    
    [scene addChild:layer];
    
    return scene;
}


-(void) onEnter{
    [super onEnter];
    [self scheduleOnce:@selector(makeTransition:) delay:1];
} 

-(void) makeTransition:(ccTime)dt
{
    [[CCDirector sharedDirector]replaceScene:[CCTransitionFade transitionWithDuration:.1 scene:[CoverPage scene]]];
}
@end
