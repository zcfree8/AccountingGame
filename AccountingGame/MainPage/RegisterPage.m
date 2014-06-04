//
//  RegisterPage.m
//  AccountingGame
//
//  Created by 张超 on 13-9-23.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import "RegisterPage.h"


@implementation RegisterPage

+(CCScene *)scene{
    
    CCScene *scene=[CCScene node];
    
    RegisterPage *layer=[RegisterPage node];
    
    [scene addChild:layer];
    
    return scene;
}

-(id)init{
    if (self=[super init]) {
        view2=[[registerViewController alloc]initWithNibName:@"registerViewController" bundle:nil];
        [[CCDirector sharedDirector].view addSubview:view2.view];
    }
    return self;
}



-(void)dealloc{
    CCLOG(@"2");
   [super dealloc];
}
@end
