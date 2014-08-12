//
//  NotePage.m
//  AccountingGame
//
//  Created by 张超 on 13-9-9.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import "NotePage.h"
#import "QuestionPage.h"
#import "SettingPage.h"
#import "MainUIPage.h"
#import "UserUtils.h"
#import "GameUtils.h"

#define MethodNameGetUserGameNote @"GetUserGameNote"
#define MethodNameGetQuestion @"GetQuestion"
@implementation NotePage

+(CCScene *)scene{
    
    CCScene *scene=[CCScene node];
    
    NotePage *layer=[NotePage node];
    
    [scene addChild:layer];
    
    return scene;
}



-(id)init{
    if (self=[super init]) {

        if(iPhone5){
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
        nextBtn.position=ccp(250, 125);
        CCMenu *startMenu=[CCMenu menuWithItems:backBtn,setBtn,nextBtn, nil];
        startMenu.position=CGPointZero;
        [self addChild:startMenu z:2];
        
    }else{
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
            nextBtn.position=ccp(250, 120);
            CCMenu *startMenu=[CCMenu menuWithItems:backBtn,setBtn,nextBtn, nil];
            startMenu.position=CGPointZero;
            [self addChild:startMenu z:2];
        }
        [self gameResult];
        
        //self.isTouchEnabled=YES;
    }
    return self;
}


-(void)gameResult{
    int SumNum=[GameUtils getCurrentUserInfo].SumNum;
    int CorrectNum=[GameUtils getCurrentUserInfo].CorrectNum;
    CCLabelTTF *itemPoint=[CCLabelTTF labelWithString:[NSString stringWithFormat:@"POINTS:%d/%d",CorrectNum,SumNum] fontName:@"Marker Felt" fontSize:15];
    if(iPhone5){
        itemPoint.position=ccp(250, 90);}
    else{
        itemPoint.position=ccp(250, 70);
    }
    itemPoint.color=ccc3(0, 0, 0);
    [self addChild:itemPoint z:3];
    
    if(iPhone5){
    CCLabelTTF *answer=[CCLabelTTF labelWithString:[GameUtils getCurrentUserInfo].correctOrIncorrect fontName:@"Helvetica-Bold" fontSize:23];
    answer.position=ccp(160, 360);
    answer.color=ccc3(0, 0, 0);
    [self addChild:answer z:3];
    
    CCLabelTTF *answerInfo=[CCLabelTTF labelWithString:@"Correct Answer:" fontName:@"Helvetica-Bold" fontSize:17];
    answerInfo.position=ccp(110, 320);
    answerInfo.color=ccc3(0, 0, 0);
    [self addChild:answerInfo z:3];
    
    self.answerInfo=[GameUtils getCurrentUserInfo].questionArr;
    NSDictionary *site=[self.answerInfo objectAtIndex:0];
    NSString *Answer=[site valueForKey:@"FAnswer"];
    self.i=[Answer characterAtIndex:0]-65;
    site=[self.answerInfo objectAtIndex:self.i];
    CCLabelTTF *rightAnswer=[CCLabelTTF labelWithString:[NSString stringWithFormat:@"No.%@-%@",Answer,[site valueForKey:@"FOption"]] dimensions:CGSizeMake(220, 60) hAlignment:kCCTextAlignmentLeft fontName:@"Helvetica-Bold" fontSize:17];
    rightAnswer.position=ccp(155, 275);
    rightAnswer.color=ccc3(0, 0, 0);
    [self addChild:rightAnswer z:3];
    
    CCLabelTTF *link=[CCLabelTTF labelWithString:@"Link to Notes:" fontName:@"Helvetica-Bold" fontSize:17];
    link.position=ccp(100, 220);
    link.color=ccc3(0, 0, 0);
    [self addChild:link z:3];
    
    //CCSprite *linkWWW=nil;
    }else{
        CCLabelTTF *answer=[CCLabelTTF labelWithString:[GameUtils getCurrentUserInfo].correctOrIncorrect fontName:@"Helvetica-Bold" fontSize:23];
        answer.position=ccp(160, 300);
        answer.color=ccc3(0, 0, 0);
        [self addChild:answer z:3];
        
        CCLabelTTF *answerInfo=[CCLabelTTF labelWithString:@"Correct Answer:" fontName:@"Helvetica-Bold" fontSize:17];
        answerInfo.position=ccp(105, 255);
        answerInfo.color=ccc3(0, 0, 0);
        [self addChild:answerInfo z:3];
        
        self.answerInfo=[GameUtils getCurrentUserInfo].questionArr;
        NSDictionary *site=[self.answerInfo objectAtIndex:0];
        NSString *Answer=[site valueForKey:@"FAnswer"];
        self.i=[Answer characterAtIndex:0]-65;
        site=[self.answerInfo objectAtIndex:self.i];
        
        CCLabelTTF *rightAnswer=[CCLabelTTF labelWithString:[NSString stringWithFormat:@"No.%@-%@",Answer,[site valueForKey:@"FOption"]] dimensions:CGSizeMake(220, 50) hAlignment:kCCTextAlignmentLeft fontName:@"Helvetica-Bold" fontSize:17];
        rightAnswer.position=ccp(150, 220);
        rightAnswer.color=ccc3(0, 0, 0);
        [self addChild:rightAnswer z:3];
        
        CCLabelTTF *link=[CCLabelTTF labelWithString:@"Link to Notes:" fontName:@"Helvetica-Bold" fontSize:17];
        link.position=ccp(95, 180);
        link.color=ccc3(0, 0, 0);
        [self addChild:link z:3];
    }
    
    
}




//返回开始界面
-(void)backButtonTap:(id)sender{
    [[CCDirector sharedDirector]replaceScene:[MainUIPage scene]];
}
//设置按钮
-(void)setButtonTap:(id)sender{
    //[[CCDirector sharedDirector]replaceScene:[CCTransitionFade transitionWithDuration:1 scene:[SettingPage scene]]];
}
//返回问题界面
-(void)nextButtonTap:(id)sender{
    if([GameUtils getCurrentUserInfo].DoneNum>[GameUtils getCurrentUserInfo].SumNum){
        //重新获取
        NSString *uid=[NSString stringWithFormat:@"%d",[GameUtils getCurrentUserInfo].u_id];
        Parameter *Param1=[[Parameter alloc]initParamWithName:@"FUserID" AndKey:uid];
        NSArray *ParamArr=[[NSArray alloc]initWithObjects:Param1, nil];
        [Param1 release];
        NSString *soapActionURL=[NSString stringWithFormat:@"%@%@",NameSpace,MethodNameGetUserGameNote];
        NetWebServiceRequest *request=[NetWebServiceRequest serviceRequestUrl:URLIP SOAPActionURL:soapActionURL ServiceMethodName:MethodNameGetUserGameNote SoapMessageArr:ParamArr];
        [ParamArr release];
        [request startSynchronous];
        NSString *result=[request responseString];
        NSArray *DataA=[result strToArr];
        [GameUtils getCurrentUserInfo].dataArr=DataA;
        [[CCDirector sharedDirector]replaceScene:[MainUIPage scene]];
    }else{
        NSString *UserID=[NSString stringWithFormat:@"%d",[GameUtils getCurrentUserInfo].u_id];
        NSString *Type=[NSString stringWithFormat:@"%c",[GameUtils getCurrentUserInfo].cID+65];
       
        NSString *Status=[GameUtils getCurrentUserInfo].Status;
        NSString *Number=[NSString stringWithFormat:@"%d",[GameUtils getCurrentUserInfo].DoneNum];
        Parameter *Param1=[[Parameter alloc]initParamWithName:@"FUserID" AndKey:UserID];
        Parameter *Param2=[[Parameter alloc]initParamWithName:@"FType" AndKey:Type];
        Parameter *Param3=[[Parameter alloc]initParamWithName:@"FNumber" AndKey:Number];
        Parameter *Param4=[[Parameter alloc]initParamWithName:@"FStatus" AndKey:Status];
        NSArray *ParamArr=[[NSArray alloc]initWithObjects:Param1,Param2,Param3,Param4, nil];
        [Param1 release];[Param2 release];[Param3 release];[Param4 release];
        NSString *soapActionURL=[NSString stringWithFormat:@"%@%@",NameSpace,MethodNameGetQuestion];
        NetWebServiceRequest *request=[NetWebServiceRequest serviceRequestUrl:URLIP SOAPActionURL:soapActionURL ServiceMethodName:MethodNameGetQuestion SoapMessageArr:ParamArr];
        [ParamArr release];
        [request startAsynchronous];
        [request setDelegate:self];
        self.runningRequest=request;
        HUD=[[MBProgressHUD showHUDAddedTo:[CCDirector sharedDirector].view animated:YES]retain];
    }
}

#pragma mark NetWebServiceRequestDelegate Methods
-(void)netRequestStarted:(NetWebServiceRequest *)request{
    CLog(@"Start");
}

-(void)netRequestFinished:(NetWebServiceRequest *)request finishedInfoToResult:(NSString *)result responseData:(NSData *)requestData{
    CLog(@"Finish");
    [HUD setHidden:YES];
    if(result.length!=0){
        NSArray *DataArr=[result strToArr];
        [GameUtils getCurrentUserInfo].questionArr=DataArr;
        [[CCDirector sharedDirector]replaceScene:[CCTransitionFadeBL transitionWithDuration:1 scene:[QuestionPage scene]]];
    }
}

-(void)netRequestFailed:(NetWebServiceRequest *)request didRequestError:(NSError *)error{
    CLog(@"%@",error);
    [HUD setHidden:YES];
}

-(void)dealloc{
    [super dealloc];
}
@end
