//
//  MainPage.m
//  AccountingGame
//
//  Created by 张超 on 13-9-9.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import "MainPage.h"
#import "MainUIPage.h"
#import "SettingPage.h"
#import "QuestionPage.h"
#import "UserUtils.h"
#import "GameUtils.h"



@implementation MainPage

+(CCScene *)scene{
    // 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	MainPage *layer = [MainPage node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

-(id)init{
    if(self=[super init]){
       //描述语句
        if(iPhone5){
            //添加背景图片
            CGSize size=[[CCDirector sharedDirector]winSize];
            CCSprite *background=[CCSprite spriteWithFile:@"bkgrd3.png"];
            [self addChild:background];
            [background setPosition:ccp(size.width/2, size.height/2)];
            
            //设置和返回按钮
            CCMenuItem *backBtn=[CCMenuItemImage itemWithNormalImage:@"back button.png" selectedImage:@"back button_glow.png" target:self selector:@selector(backButtonTap:)];
            CCMenuItem *setBtn=[CCMenuItemImage itemWithNormalImage:@"settings button.png" selectedImage:@"settings button_glow.png" target:self selector:@selector(setButtonTap:)];
            CCMenuItem *nextBtn=[CCMenuItemImage itemWithNormalImage:@"next button.png" selectedImage:@"next button_glow.png" target:self selector:@selector(nextButtonTap:)];
            
            backBtn.position=ccp(30, 540);
            setBtn.position=ccp(290, 540);
            nextBtn.position=ccp(250, 100);
            
            CCMenu *startMenu=[CCMenu menuWithItems:backBtn,setBtn,nextBtn, nil];
            startMenu.position=CGPointZero;
            [self addChild:startMenu z:2];
            NSDictionary *DataDict=[[GameUtils getCurrentUserInfo].dataArr objectAtIndex:[GameUtils getCurrentUserInfo].cID];
            NSString *Catagory=[DataDict valueForKey:@"FTopic"];
            CCLabelTTF *label1=[CCLabelTTF labelWithString:[Catagory uppercaseString] dimensions:CGSizeMake(200, 50) hAlignment:kCCTextAlignmentLeft  fontName:@"Helvetica-Bold" fontSize:14];
            [label1 setColor:ccc3(0, 0, 0)];
            label1.position=ccp(95, 400);
            label1.anchorPoint=ccp(0, 0);
            [self addChild:label1 z:3];
            
            CCLabelTTF *label2=[CCLabelTTF labelWithString:@"EXERCISE 1" fontName:@"Helvetica-Bold" fontSize:14];
            [label2 setColor:ccc3(0, 0, 0)];
            label2.position=ccp(95, 400);
            label2.anchorPoint=ccp(0, 0);
            [self addChild:label2 z:3];
            
            CCLabelTTF *label3=[CCLabelTTF labelWithString:@"PRINCIPLES OF ACCOUNTS"  fontName:@"Helvetica-Bold" fontSize:19];
            [label3 setColor:ccc3(0, 0, 0)];
            label3.position=ccp(30, 325);
            label3.anchorPoint=ccp(0, 0);
            [self addChild:label3 z:3];
            
            CCLabelTTF *label4=[CCLabelTTF labelWithString:@"MULTIPLE CHOICE QUESTIONS" dimensions:CGSizeMake(260, 100) hAlignment:kCCTextAlignmentCenter fontName:@"Helvetica-Bold" fontSize:19];
            [label4 setColor:ccc3(0, 0, 0)];
            label4.position=ccp(30, 220);
            label4.anchorPoint=ccp(0, 0);
            [self addChild:label4 z:3];
            
            CCLabelTTF *label5=[CCLabelTTF labelWithString:@"You have a total of"
               dimensions:CGSizeMake(280, 30) hAlignment:kCCTextAlignmentCenter fontName:@"Helvetica-Bold"  fontSize:17];
            [label5 setColor:ccc3(0, 0, 0)];
            label5.position=ccp(20, 220);
            label5.anchorPoint=ccp(0, 0);
            [self addChild:label5 z:3];
        
            CCLabelTTF *label6=[CCLabelTTF labelWithString:[NSString stringWithFormat:@"%d multiple chioce questions.",[GameUtils getCurrentUserInfo].SumNum] dimensions:CGSizeMake(280, 30) hAlignment:kCCTextAlignmentCenter fontName:@"Helvetica-Bold" fontSize:17];
            [label6 setColor:ccc3(0, 0, 0)];
            label6.position=ccp(20, 200);
            label6.anchorPoint=ccp(0, 0);
            [self addChild:label6 z:3];
            
            CCLabelTTF *label7=[CCLabelTTF labelWithString:@"Tap the number that" dimensions:CGSizeMake(280, 30) hAlignment:kCCTextAlignmentCenter
                    fontName:@"Helvetica-Bold" fontSize:17];
            [label7 setColor:ccc3(0, 0, 0)];
            label7.position=ccp(20, 170);
            label7.anchorPoint=ccp(0, 0);
            [self addChild:label7 z:3];
            
            CCLabelTTF *label8=[CCLabelTTF labelWithString:@"represents the correct answer." dimensions:CGSizeMake(280, 30) hAlignment:kCCTextAlignmentCenter
                            fontName:@"Helvetica-Bold" fontSize:17];
            [label8 setColor:ccc3(0, 0, 0)];
            label8.position=ccp(20, 150);
            label8.anchorPoint=ccp(0, 0);
            [self addChild:label8 z:3];
            
        }else{
            //添加背景图片
            CGSize size=[[CCDirector sharedDirector]winSize];
            CCSprite *background=[CCSprite spriteWithFile:@"bkgrd3s.png"];
            [self addChild:background];
            [background setPosition:ccp(size.width/2, size.height/2)];
            
            //设置和返回按钮
            CCMenuItem *backBtn=[CCMenuItemImage itemWithNormalImage:@"back button.png" selectedImage:@"back button_glow.png" target:self selector:@selector(backButtonTap:)];
            CCMenuItem *setBtn=[CCMenuItemImage itemWithNormalImage:@"settings button.png" selectedImage:@"settings button_glow.png" target:self selector:@selector(setButtonTap:)];
            CCMenuItem *nextBtn=[CCMenuItemImage itemWithNormalImage:@"next button.png" selectedImage:@"next button_glow.png" target:self selector:@selector(nextButtonTap:)];
            
            backBtn.position=ccp(30, 450);
            setBtn.position=ccp(290, 450);
            nextBtn.position=ccp(250, 80);
            
            CCMenu *startMenu=[CCMenu menuWithItems:backBtn,setBtn,nextBtn, nil];
            startMenu.position=CGPointZero;
            [self addChild:startMenu z:2];
            NSDictionary *DataDict=[[GameUtils getCurrentUserInfo].dataArr objectAtIndex:[GameUtils getCurrentUserInfo].cID];
            NSString *Catagory=[DataDict valueForKey:@"FTopic"];
            CCLabelTTF *label1=[CCLabelTTF labelWithString:[Catagory uppercaseString] dimensions:CGSizeMake(200, 50) hAlignment:kCCTextAlignmentLeft  fontName:@"Helvetica-Bold" fontSize:14];
            [label1 setColor:ccc3(0, 0, 0)];
            label1.position=ccp(95, 335);
            label1.anchorPoint=ccp(0, 0);
            [self addChild:label1 z:3];
            
            CCLabelTTF *label2=[CCLabelTTF labelWithString:@"EXERCISE 1" fontName:@"Helvetica-Bold" fontSize:14];
            [label2 setColor:ccc3(0, 0, 0)];
            label2.position=ccp(95, 335);
            label2.anchorPoint=ccp(0, 0);
            [self addChild:label2 z:3];
            
            CCLabelTTF *label3=[CCLabelTTF labelWithString:@"PRINCIPLES OF ACCOUNTS MULTIPLE CHOICE QUESTIONS" dimensions:CGSizeMake(280, 150) hAlignment:kCCTextAlignmentCenter fontName:@"Helvetica-Bold" fontSize:19];
            [label3 setColor:ccc3(0, 0, 0)];
            label3.position=ccp(20, 155);
            label3.anchorPoint=ccp(0, 0);
            [self addChild:label3 z:3];
            
            CCLabelTTF *label4=[CCLabelTTF labelWithString:@"You have a total of " dimensions:CGSizeMake(280, 100) hAlignment:kCCTextAlignmentCenter fontName:@"Helvetica-Bold" fontSize:17];
            [label4 setColor:ccc3(0, 0, 0)];
            label4.position=ccp(20, 120);
            label4.anchorPoint=ccp(0, 0);
            [self addChild:label4 z:3];
            
            CCLabelTTF *label5=[CCLabelTTF labelWithString:[NSString stringWithFormat:@"%d multiple chioce questions.",[GameUtils getCurrentUserInfo].SumNum] dimensions:CGSizeMake(280, 100) hAlignment:kCCTextAlignmentCenter fontName:@"Helvetica-Bold" fontSize:17];
            [label5 setColor:ccc3(0, 0, 0)];
            label5.position=ccp(20, 100);
            label5.anchorPoint=ccp(0, 0);
            [self addChild:label5 z:3];
            
            CCLabelTTF *label6=[CCLabelTTF labelWithString:@"Tap the number that " dimensions:CGSizeMake(280, 100) hAlignment:kCCTextAlignmentCenter fontName:@"Helvetica-Bold" fontSize:17];
            [label6 setColor:ccc3(0, 0, 0)];
            label6.position=ccp(20, 70);
            label6.anchorPoint=ccp(0, 0);
            [self addChild:label6 z:3];
            
            CCLabelTTF *label7=[CCLabelTTF labelWithString:@"represents the correct answer." dimensions:CGSizeMake(280, 100) hAlignment:kCCTextAlignmentCenter fontName:@"Helvetica-Bold" fontSize:17];
            [label7 setColor:ccc3(0, 0, 0)];
            label7.position=ccp(20, 50);
            label7.anchorPoint=ccp(0, 0);
            [self addChild:label7 z:3];
        }
    self.isTouchEnabled=YES;
    }
    return self;
}





//返回主UI界面
-(void)backButtonTap:(id)sender{
    [[CCDirector sharedDirector]replaceScene:[MainUIPage scene]];
}

//设置按钮
-(void)setButtonTap:(id)sender{
    //[[CCDirector sharedDirector]replaceScene:[CCTransitionFade transitionWithDuration:1 scene:[SettingPage scene]]];
}

//进入下一界面
-(void)nextButtonTap:(id)sender{
    [[CCDirector sharedDirector]replaceScene:[CCTransitionFadeBL transitionWithDuration:1 scene:[QuestionPage scene]]];
}

@end
