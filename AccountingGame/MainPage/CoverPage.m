//
//  CoverPage.m
//  AccountingGame
//
//  Created by 张超 on 13-9-9.
//  Copyright __MyCompanyName__ 2013年. All rights reserved.
//


// Import the interfaces
#import "CoverPage.h"
#import "LoginPage.h"
// Needed to obtain the Navigation Controller
#import "AppDelegate.h"
#import "GameUtils.h"
#import "MainUIPage.h"
#import "SettingPage.h"
#pragma mark - CoverPage

// HelloWorldLayer implementation
@implementation CoverPage

// Helper class method that creates a Scene with the HelloWorldLayer as the only child.
+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	CoverPage *layer = [CoverPage node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super's" return value
	if( (self=[super init]) ) {
		
        //获取屏幕尺寸
        CGSize size=[[CCDirector sharedDirector]winSize];
        //添加背景图片
        if(iPhone5){
            CCSprite *background=[CCSprite spriteWithFile:@"bkgrd1.png"];
            [self addChild:background];
            [background setPosition:ccp(size.width/2, size.height/2)];
        
        }else{
            CCSprite *background=[CCSprite spriteWithFile:@"bkgrd1s.png"];
            [self addChild:background];
            [background setPosition:ccp(size.width/2, size.height/2)];
            
        }
		//添加开始按钮
        if(iPhone5){
            CCMenuItem *playBtn=[CCMenuItemImage itemWithNormalImage:@"play button.png" selectedImage:@"play button_glow.png" target:self selector:@selector(playButtonTap:)];
            playBtn.position=ccp(230, 320);
            CCMenu *startMenu=[CCMenu menuWithItems:playBtn, nil];
            startMenu.position=CGPointZero;
            [self addChild:startMenu];
        }else{
            CCMenuItem *playBtn=[CCMenuItemImage itemWithNormalImage:@"play button.png" selectedImage:@"play button_glow.png" target:self selector:@selector(playButtonTap:)];
            playBtn.position=ccp(230, 270);
            CCMenu *startMenu=[CCMenu menuWithItems:playBtn, nil];
            startMenu.position=CGPointZero;
            [self addChild:startMenu];
        }
        self.isTouchEnabled=YES;
    }
	return self;
}




//开始按钮
-(void)playButtonTap:(id)sender{
    if(![GameUtils getCurrentUserInfo].isLogin){
        [[CCDirector sharedDirector]replaceScene:[LoginPage scene]];
    }else{
        [[CCDirector sharedDirector]replaceScene:[MainUIPage scene]];
    }

 
}


// on "dealloc" you need to release all your retained objects
- (void) dealloc
{

	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	
	// don't forget to call "super dealloc"
    
	[super dealloc];
}



@end
