//
//  SettingPage.m
//  AccountingGame
//
//  Created by 张超 on 13-9-9.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import "SettingPage.h"
#import "CoverPage.h"

@implementation SettingPage

+(CCScene *)scene{
    
    CCScene *scene=[CCScene node];
    
    SettingPage *layer=[SettingPage node];
    
    [scene addChild:layer];
    
    return scene;
}



-(id)init{
    if (self=[super init]) {
        CCMenuItem *nextBtn=[CCMenuItemImage itemWithNormalImage:@"next button.png" selectedImage:@"next button_glow.png" target:self selector:@selector(nextButtonTap:)];
        nextBtn.position=ccp(100, 200);
        CCMenu *startMenu=[CCMenu menuWithItems:nextBtn, nil];
        startMenu.position=CGPointZero;
        [self addChild:startMenu];
        
        self.isTouchEnabled=YES;
    }
    return self;
}


//返回界面
-(void)nextButtonTap:(id)sender{
    [[CCDirector sharedDirector]replaceScene:[CCTransitionFade transitionWithDuration:1 scene:[CoverPage scene]]];
}
@end
