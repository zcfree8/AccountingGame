//
//  QuestionPage.m
//  AccountingGame
//
//  Created by 张超 on 13-9-9.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import "QuestionPage.h"
#import "MainPage.h"
#import "MainUIPage.h"
#import "SettingPage.h"
#import "NotePage.h"
#import "CCRadioMenu.h"
#import "GameUtils.h"

#import <CoreText/CoreText.h>
#define MethodNameInsertNote @"InsertNote"


@implementation QuestionPage

+(CCScene *)scene{
    
    CCScene *scene=[CCScene node];
    
    QuestionPage *layer=[QuestionPage node];
   
    [scene addChild:layer];
    
    return scene;
}



-(id)init{
    if (self=[super init]) {
        Status=[GameUtils getCurrentUserInfo].Status;
        if(iPhone5){
            
            //添加背景图片
            CGSize size=[[CCDirector sharedDirector]winSize];
            CCSprite *background=[CCSprite spriteWithFile:@"bkgrd3a.png"];
            [self addChild:background z:3];
            [background setPosition:ccp(size.width/2, size.height/2)];
            if([Status isEqualToString:@"A"]){
                //设置和返回按钮
                CCMenuItem *backBtn=[CCMenuItemImage itemWithNormalImage:@"back button.png" selectedImage:@"back button_glow.png" target:self selector:@selector(backButtonTap:)];
                CCMenuItem *setBtn=[CCMenuItemImage itemWithNormalImage:@"settings button.png" selectedImage:@"settings button_glow.png" target:self selector:@selector(setButtonTap:)];
                
                backBtn.position=ccp(30, 540);
                setBtn.position=ccp(290, 540);
                
                CCMenu *startMenu=[CCMenu menuWithItems:backBtn,setBtn, nil];
                startMenu.position=CGPointZero;
                [self addChild:startMenu z:3];
            }else{
                //设置和返回按钮
                CCMenuItem *backBtn=[CCMenuItemImage itemWithNormalImage:@"back button.png" selectedImage:@"back button_glow.png" target:self selector:@selector(backButtonTap:)];
                CCMenuItem *setBtn=[CCMenuItemImage itemWithNormalImage:@"settings button.png" selectedImage:@"settings button_glow.png" target:self selector:@selector(setButtonTap:)];
                CCMenuItem *nextBtn=[CCMenuItemImage itemWithNormalImage:@"next button.png" selectedImage:@"next button_glow.png" target:self selector:@selector(nextButtonTap:)];
                backBtn.position=ccp(30, 540);
                setBtn.position=ccp(290, 540);
                nextBtn.position=ccp(210, 45);
                CCMenu *startMenu=[CCMenu menuWithItems:backBtn,setBtn,nextBtn, nil];
                startMenu.position=CGPointZero;
                [self addChild:startMenu z:3];
            }
            

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
            
        }else{
            //添加背景图片
            CGSize size=[[CCDirector sharedDirector]winSize];
            CCSprite *background=[CCSprite spriteWithFile:@"bkgrd3ss.png"];
            [self addChild:background z:3];
            [background setPosition:ccp(size.width/2, size.height/2)];
            if([Status isEqualToString:@"A"]){
                //设置和返回按钮
                CCMenuItem *backBtn=[CCMenuItemImage itemWithNormalImage:@"back button.png" selectedImage:@"back button_glow.png" target:self selector:@selector(backButtonTap:)];
                CCMenuItem *setBtn=[CCMenuItemImage itemWithNormalImage:@"settings button.png" selectedImage:@"settings button_glow.png" target:self selector:@selector(setButtonTap:)];
                
                backBtn.position=ccp(30, 450);
                setBtn.position=ccp(290, 450);
                CCMenu *startMenu=[CCMenu menuWithItems:backBtn,setBtn, nil];
                startMenu.position=CGPointZero;
                [self addChild:startMenu z:3];
            }else{
                //设置和返回按钮
                CCMenuItem *backBtn=[CCMenuItemImage itemWithNormalImage:@"back button.png" selectedImage:@"back button_glow.png" target:self selector:@selector(backButtonTap:)];
                CCMenuItem *setBtn=[CCMenuItemImage itemWithNormalImage:@"settings button.png" selectedImage:@"settings button_glow.png" target:self selector:@selector(setButtonTap:)];
                CCMenuItem *nextBtn=[CCMenuItemImage itemWithNormalImage:@"next button.png" selectedImage:@"next button_glow.png" target:self selector:@selector(nextButtonTap:)];
                backBtn.position=ccp(30, 450);
                setBtn.position=ccp(290, 450);
                nextBtn.position=ccp(210, 45);
                CCMenu *startMenu=[CCMenu menuWithItems:backBtn,setBtn,nextBtn, nil];
                startMenu.position=CGPointZero;
                [self addChild:startMenu z:3];
            }
           
            
            
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
        }
        
        [self addAnswer];
        self.isTouchEnabled=YES;
    }
    return self;
}

-(void)addAnswer{
    cal=[CCSprite spriteWithFile:@"whites.png"];
    cal.position=ccp(160, 0);
    
    [self addChild:cal z:1];
    if(iPhone5){
        //添加题目序号
        self.answerInfo=[GameUtils getCurrentUserInfo].questionArr;
        NSDictionary *site=[self.answerInfo objectAtIndex:0];
        
        CCLabelTTF *labelQ=[CCLabelTTF labelWithString:[NSString stringWithFormat:@"QUESTION %d",[GameUtils getCurrentUserInfo].DoneNum] fontName:@"Helvetica-Bold" fontSize:23];
        [labelQ setColor:ccc3(0, 0, 0)];
        labelQ.position=ccp(40, 360);
        labelQ.anchorPoint=ccp(0, 0);
        [self addChild:labelQ z:3];
       
        //添加题目标题
        CCLabelTTF *label=[CCLabelTTF labelWithString:[site valueForKey:@"FContext"] dimensions:CGSizeMake(250, 400) hAlignment:kCCTextAlignmentLeft fontName:@"Helvetica-Bold" fontSize:16];
        [label setColor:ccc3(0, 0, 0)];
        label.position=ccp(10, 290);
        label.anchorPoint=ccp(0, 0);
        [cal addChild:label z:2];
        NSMutableAttributedString *string0=[[NSMutableAttributedString alloc]initWithString:[site valueForKey:@"FContext"]];
        
        y=[self getAttributedStringHeightWithString:string0 WidthValue:250];
        [string0 release];
        CCLOG(@"%f",y);
        self.answerInfo=[GameUtils getCurrentUserInfo].questionArr;
                
        //添加选项
        NSDictionary *siteQ1=[self.answerInfo objectAtIndex:0];
        CCLabelTTF *labela1=[CCLabelTTF labelWithString:[siteQ1 valueForKey:@"FOption"] dimensions:CGSizeMake(180, 200) hAlignment:kCCTextAlignmentLeft vAlignment:kCCVerticalTextAlignmentTop fontName:@"Helvetica-Bold" fontSize:16];
        [labela1 setColor:ccc3(0, 0, 0)];
        labela1.position=ccp(155, 580-y);
        NSMutableAttributedString *string1=[[NSMutableAttributedString alloc]initWithString:[siteQ1 valueForKey:@"FOption"]];
        y1=[self getAttributedStringHeightWithString:string1 WidthValue:180];
        [string1 release];
        CCLOG(@"%f",y1);
        [cal addChild:labela1 z:2];
        
        NSDictionary *siteQ2=[self.answerInfo objectAtIndex:1];
        CCLabelTTF *labela2=[CCLabelTTF labelWithString:[siteQ2 valueForKey:@"FOption"] dimensions:CGSizeMake(180, 200) hAlignment:kCCTextAlignmentLeft vAlignment:kCCVerticalTextAlignmentTop fontName:@"Helvetica-Bold" fontSize:16];
        [labela2 setColor:ccc3(0, 0, 0)];
        labela2.position=ccp(155, 570-y-y1);
        NSMutableAttributedString *string2=[[NSMutableAttributedString alloc]initWithString:[siteQ2 valueForKey:@"FOption"]];
        y2=[self getAttributedStringHeightWithString:string2 WidthValue:180];
        [string2 release];
        CCLOG(@"%f",y2);
        
        [cal addChild:labela2 z:2];
        
        NSDictionary *siteQ3=[self.answerInfo objectAtIndex:2];
        CCLabelTTF *labela3=[CCLabelTTF labelWithString:[siteQ3 valueForKey:@"FOption"] dimensions:CGSizeMake(180, 200) hAlignment:kCCTextAlignmentLeft vAlignment:kCCVerticalTextAlignmentTop fontName:@"Helvetica-Bold" fontSize:16];
        [labela3 setColor:ccc3(0, 0, 0)];
        labela3.position=ccp(155, 560-y-y1-y2);
        NSMutableAttributedString *string3=[[NSMutableAttributedString alloc]initWithString:[siteQ3 valueForKey:@"FOption"]];
        y3=[self getAttributedStringHeightWithString:string3 WidthValue:180];
        [string3 release];
        CCLOG(@"%f",y3);
        [cal addChild:labela3 z:2];
        
        NSDictionary *siteQ4=[self.answerInfo objectAtIndex:3];
        CCLabelTTF *labela4=[CCLabelTTF labelWithString:[siteQ4 valueForKey:@"FOption"] dimensions:CGSizeMake(180, 200) hAlignment:kCCTextAlignmentLeft vAlignment:kCCVerticalTextAlignmentTop fontName:@"Helvetica-Bold" fontSize:16];
        [labela4 setColor:ccc3(0, 0, 0)];
        labela4.position=ccp(155, 550-y-y1-y2-y3);
        NSMutableAttributedString *string4=[[NSMutableAttributedString alloc]initWithString:[siteQ4 valueForKey:@"FOption"]];
        y4=[self getAttributedStringHeightWithString:string4 WidthValue:180];
        [string4 release];
        CCLOG(@"%f",y4);
        [cal addChild:labela4 z:2];
        
        
    }else{
        //添加题目
        self.answerInfo=[GameUtils getCurrentUserInfo].questionArr;
        NSDictionary *site=[self.answerInfo objectAtIndex:0];
        
        CCLabelTTF *labelQ=[CCLabelTTF labelWithString:[NSString stringWithFormat:@"QUESTION %d",[GameUtils getCurrentUserInfo].DoneNum] dimensions:CGSizeMake(240, 100) hAlignment:kCCTextAlignmentLeft fontName:@"Helvetica-Bold" fontSize:23];
        [labelQ setColor:ccc3(0, 0, 0)];
        labelQ.position=ccp(40, 220);
        labelQ.anchorPoint=ccp(0, 0);
        [self addChild:labelQ z:3];
        
        CCLabelTTF *label=[CCLabelTTF labelWithString:[site valueForKey:@"FContext"] dimensions:CGSizeMake(250, 400) hAlignment:kCCTextAlignmentLeft fontName:@"Helvetica-Bold" fontSize:16];
        [label setColor:ccc3(0, 0, 0)];
        label.position=ccp(10, 220);
        label.anchorPoint=ccp(0, 0);
        [cal addChild:label z:2];
        NSMutableAttributedString *string0=[[NSMutableAttributedString alloc]initWithString:[site valueForKey:@"FContext"]];
        
        y=[self getAttributedStringHeightWithString:string0 WidthValue:250];
        [string0 release];
        self.answerInfo=[GameUtils getCurrentUserInfo].questionArr;
        
        //添加选项
        NSDictionary *siteQ1=[self.answerInfo objectAtIndex:0];
        CCLabelTTF *labela1=[CCLabelTTF labelWithString:[siteQ1 valueForKey:@"FOption"] dimensions:CGSizeMake(180, 200) hAlignment:kCCTextAlignmentLeft vAlignment:kCCVerticalTextAlignmentTop fontName:@"Helvetica-Bold" fontSize:16];
        [labela1 setColor:ccc3(0, 0, 0)];
        labela1.position=ccp(155, 500-y);
        NSMutableAttributedString *string1=[[NSMutableAttributedString alloc]initWithString:[siteQ1 valueForKey:@"FOption"]];
        y1=[self getAttributedStringHeightWithString:string1 WidthValue:180];
        [string1 release];
        [cal addChild:labela1 z:2];
        
        NSDictionary *siteQ2=[self.answerInfo objectAtIndex:1];
        CCLabelTTF *labela2=[CCLabelTTF labelWithString:[siteQ2 valueForKey:@"FOption"] dimensions:CGSizeMake(180, 200) hAlignment:kCCTextAlignmentLeft vAlignment:kCCVerticalTextAlignmentTop fontName:@"Helvetica-Bold" fontSize:16];
        [labela2 setColor:ccc3(0, 0, 0)];
        labela2.position=ccp(155, 490-y-y1);
        NSMutableAttributedString *string2=[[NSMutableAttributedString alloc]initWithString:[siteQ2 valueForKey:@"FOption"]];
        y2=[self getAttributedStringHeightWithString:string2 WidthValue:180];
        [string2 release];
        [cal addChild:labela2 z:2];
        
        NSDictionary *siteQ3=[self.answerInfo objectAtIndex:2];
        CCLabelTTF *labela3=[CCLabelTTF labelWithString:[siteQ3 valueForKey:@"FOption"] dimensions:CGSizeMake(180, 200) hAlignment:kCCTextAlignmentLeft vAlignment:kCCVerticalTextAlignmentTop fontName:@"Helvetica-Bold" fontSize:16];
        [labela3 setColor:ccc3(0, 0, 0)];
        labela3.position=ccp(155, 480-y-y1-y2);
        NSMutableAttributedString *string3=[[NSMutableAttributedString alloc]initWithString:[siteQ3 valueForKey:@"FOption"]];
        y3=[self getAttributedStringHeightWithString:string3 WidthValue:180];
        [string3 release];
        [cal addChild:labela3 z:2];
        
        NSDictionary *siteQ4=[self.answerInfo objectAtIndex:3];
        CCLabelTTF *labela4=[CCLabelTTF labelWithString:[siteQ4 valueForKey:@"FOption"] dimensions:CGSizeMake(180, 200) hAlignment:kCCTextAlignmentLeft vAlignment:kCCVerticalTextAlignmentTop fontName:@"Helvetica-Bold" fontSize:16];
        [labela4 setColor:ccc3(0, 0, 0)];
        labela4.position=ccp(155, 470-y-y1-y2-y3);
        NSMutableAttributedString *string4=[[NSMutableAttributedString alloc]initWithString:[siteQ4 valueForKey:@"FOption"]];
        y4=[self getAttributedStringHeightWithString:string4 WidthValue:180];
        [string4 release];
        [cal addChild:labela4 z:2];
    }
    [self gameQuestion];
    
}

-(void)gameQuestion{
    if([Status isEqualToString:@"A"]){
        CCMenuItem *opt1=[CCMenuItemImage itemWithNormalImage:@"no 1.png" selectedImage:@"no 1_glow.png" target:self selector:@selector(optTap:)];
        opt1.tag=100;
        CCMenuItem *opt2=[CCMenuItemImage itemWithNormalImage:@"no 2.png" selectedImage:@"no 2_glow.png" target:self selector:@selector(optTap:)];
        opt2.tag=101;
        CCMenuItem *opt3=[CCMenuItemImage itemWithNormalImage:@"no 3.png" selectedImage:@"no 3_glow.png" target:self selector:@selector(optTap:)];
        opt3.tag=102;
        CCMenuItem *opt4=[CCMenuItemImage itemWithNormalImage:@"no 4.png" selectedImage:@"no 4_glow.png" target:self selector:@selector(optTap:)];
        opt4.tag=103;
        if(iPhone5){
            opt1.position=ccp(30, 670-y);
            opt2.position=ccp(30, 660-y-y1);
            opt3.position=ccp(30, 650-y-y1-y2);
            opt4.position=ccp(30, 640-y-y1-y2-y3);
        }else{
            opt1.position=ccp(30, 590-y);
            opt2.position=ccp(30, 580-y-y1);
            opt3.position=ccp(30, 570-y-y1-y2);
            opt4.position=ccp(30, 560-y-y1-y2-y3);
        }
        CCRadioMenu *startMenu=[CCRadioMenu menuWithItems:opt1,opt2,opt3,opt4, nil];
        startMenu.position=CGPointZero;
        [cal addChild:startMenu z:2];
        
        CCLabelTTF *itemPoint=[CCLabelTTF labelWithString:[NSString stringWithFormat:@"POINTS:%d/%d",[GameUtils getCurrentUserInfo].CorrectNum,[GameUtils getCurrentUserInfo].SumNum] fontName:@"Marker Felt" fontSize:15];
        if(iPhone5){
            itemPoint.position=ccp(250, 90);}
        else{
            itemPoint.position=ccp(250, 70);
        }
        itemPoint.color=ccc3(0, 0, 0);
        [self addChild:itemPoint z:3];

    }else{
        NSDictionary *DataDict=[self.answerInfo objectAtIndex:0];
        int NumR=[[DataDict valueForKey:@"FAnswer"]characterAtIndex:0]-65;
        int NumU=[[DataDict valueForKey:@"FUserAns"]characterAtIndex:0]-65;
        if(NumR==NumU){
            [GameUtils getCurrentUserInfo].correctOrIncorrect=@"CORRECT ANSWER";
        }else{
            [GameUtils getCurrentUserInfo].correctOrIncorrect=@"INCORRECT ANSWER";
        }
        NSString *str1=@"no 1.png";
        NSString *str2=@"no 2.png";
        NSString *str3=@"no 3.png";
        NSString *str4=@"no 4.png";
        NSMutableArray *arr=[NSMutableArray arrayWithObjects:str1,str2,str3,str4, nil];
        NSString *str=[NSString stringWithFormat:@"no %d_glow.png",NumU+1];
        [arr replaceObjectAtIndex:NumU withObject:str];
        CCMenuItem *opt1=[CCMenuItemImage itemWithNormalImage:[arr objectAtIndex:0] selectedImage:nil];
        opt1.tag=100;
        CCMenuItem *opt2=[CCMenuItemImage itemWithNormalImage:[arr objectAtIndex:1] selectedImage:nil];
        opt2.tag=101;
        CCMenuItem *opt3=[CCMenuItemImage itemWithNormalImage:[arr objectAtIndex:2] selectedImage:nil];
        opt3.tag=102;
        CCMenuItem *opt4=[CCMenuItemImage itemWithNormalImage:[arr objectAtIndex:3] selectedImage:nil];
        opt4.tag=103;
        if(iPhone5){
            opt1.position=ccp(30, 670-y);
            opt2.position=ccp(30, 660-y-y1);
            opt3.position=ccp(30, 650-y-y1-y2);
            opt4.position=ccp(30, 640-y-y1-y2-y3);
        }else{
            opt1.position=ccp(30, 590-y);
            opt2.position=ccp(30, 580-y-y1);
            opt3.position=ccp(30, 570-y-y1-y2);
            opt4.position=ccp(30, 560-y-y1-y2-y3);
            
        }
        CCRadioMenu *startMenu=[CCRadioMenu menuWithItems:opt1,opt2,opt3,opt4, nil];
        startMenu.position=CGPointZero;
        [cal addChild:startMenu z:2];
        
        CCLabelTTF *itemPoint=[CCLabelTTF labelWithString:[NSString stringWithFormat:@"POINTS:%d/%d",[GameUtils getCurrentUserInfo].CorrectNum,[GameUtils getCurrentUserInfo].SumNum] fontName:@"Marker Felt" fontSize:15];
        
        if(iPhone5){
            itemPoint.position=ccp(250, 90);}
        else{
            itemPoint.position=ccp(250, 70);
        }
        itemPoint.color=ccc3(0, 0, 0);
        [self addChild:itemPoint z:3];
    }
    
    
    
}

-(int)getAttributedStringHeightWithString:(NSMutableAttributedString *)string WidthValue:(int)width{
    int total_height=0;
    //创建字体以及字体大小
    CTFontRef helvetica = CTFontCreateWithName(CFSTR("Helvetica-Bold"), 16.0, NULL);
    //添加字体目标字符串从下标0开始到字符串结尾
    [string addAttribute:(id)kCTFontAttributeName
     value:(id)helvetica range:NSMakeRange(0, [string length])];
    
    CTFramesetterRef framesetter=CTFramesetterCreateWithAttributedString((CFAttributedStringRef)string);
    CGRect drawingRect=CGRectMake(0, 0, width, 1000);
    CGMutablePathRef path=CGPathCreateMutable();
    CGPathAddRect(path, NULL, drawingRect);
    CTFrameRef textFrame=CTFramesetterCreateFrame(framesetter, CFRangeMake(0, 0), path, NULL);
    CGPathRelease(path);
    CFRelease(framesetter);
    NSArray *linesArray=(NSArray *)CTFrameGetLines(textFrame);
    CGPoint origins[[linesArray count]];
    CTFrameGetLineOrigins(textFrame, CFRangeMake(0, 0), origins);
    int line_y=(int)origins[[linesArray count]-1 ].y;
    CGFloat ascent;
    CGFloat descent;
    CGFloat leading;
    CTLineRef line=(CTLineRef)[linesArray objectAtIndex:[linesArray count]-1];
    CTLineGetTypographicBounds(line, &ascent, &descent, &leading);
    total_height=1000-line_y+(int)descent+1;
    CFRelease(textFrame);
    return total_height;
}

- (void) ccTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint touchLocation = [self convertTouchToNodeSpace:touch];
    
    //获取之前的活动点
    CGPoint oldTouchLocation = [touch previousLocationInView:touch.view];
    oldTouchLocation = [[CCDirector sharedDirector] convertToGL:oldTouchLocation];
    oldTouchLocation = [self convertToNodeSpace:oldTouchLocation];
    
    //坐标转换
    CGPoint translation = ccpSub(touchLocation, oldTouchLocation);
    if(CGRectContainsPoint(cal.boundingBox, touchLocation)){
        if(iPhone5){
        if(y+y1+y2+y3+y4-150>=0){
            cal.position = [self boundLayerPos:translation];}
        }else{
            if(y+y1+y2+y3+y4-100>=0){
           cal.position = [self boundLayerPos:translation];
            }
        }
    }
}

- (CGPoint)boundLayerPos:(CGPoint)newPos
{
    CGPoint retval = newPos;
    retval.x =newPos.x;
    retval.y = cal.position.y+newPos.y;
    
    CCLOG(@"%f____%f",retval.y,y+y1+y2+y3+y4);
    if(iPhone5){
        if (retval.x>=320) {
            retval.x = 320;
        }else if (retval.x<=160) {
            retval.x = 160;
        }
        
        if (retval.y >=y+y1+y2+y3+y4-150) {
            retval.y =y+y1+y2+y3+y4-150;
        }else if (retval.y <= 0){
            retval.y = 0;
        }
    }else{
        if (retval.x>=320) {
            retval.x = 320;
        }else if (retval.x<=160) {
            retval.x = 160;
        }
        
        if (retval.y >=y+y1+y2+y3+y4-100) {
            retval.y = y+y1+y2+y3+y4-100;
        }else if (retval.y <= 0) {
            retval.y = 0;
        }
    }
    return retval;
}

//返回上一个界面
-(void)backButtonTap:(id)sender{
    [[CCDirector sharedDirector]replaceScene:[MainUIPage scene]];
}

//设置按钮
-(void)setButtonTap:(id)sender{
    //[[CCDirector sharedDirector]replaceScene:[CCTransitionFade transitionWithDuration:1 scene:[SettingPage scene]]];
}

//下一题
-(void)nextButtonTap:(CCMenuItem *)sender{
    [GameUtils getCurrentUserInfo].DoneNum +=1;
    [[CCDirector sharedDirector]replaceScene:[CCTransitionFadeBL transitionWithDuration:1 scene:[NotePage scene]]];
}

//答题选项判断
-(void)optTap:(CCMenuItem *)sender{
    NSDictionary *site=[self.answerInfo objectAtIndex:0];
    NSString *Answer=[site valueForKey:@"FAnswer"];
    int Num=[Answer characterAtIndex:0]-65;
    NSString *Number=[NSString stringWithFormat:@"%c",(char)sender.tag-100+65];
    NSString *uid=[NSString stringWithFormat:@"%d",[GameUtils getCurrentUserInfo].u_id];
    
    if(Num==sender.tag-100){
        [GameUtils getCurrentUserInfo].correctOrIncorrect=@"CORRECT ANSWER";
        [GameUtils getCurrentUserInfo].CorrectNum+=1;
    }else{
        [GameUtils getCurrentUserInfo].correctOrIncorrect=@"INCORRECT ANSWER";
    }
    [GameUtils getCurrentUserInfo].DoneNum+=1;
    
    //上传信息
    /*
     <FUserID>string</FUserID>
     <FNumID>string</FNumID>
     <FAnswer>string</FAnswer>
     */
    NSString *FNumID=[site valueForKey:@"FitemID"];
    Parameter *Param1=[[Parameter alloc]initParamWithName:@"FUserID" AndKey:uid];
    Parameter *Param2=[[Parameter alloc]initParamWithName:@"FNumID" AndKey:FNumID];
    Parameter *Param3=[[Parameter alloc]initParamWithName:@"FAnswer" AndKey:Number];
    
    NSArray *ParamArr=[[NSArray alloc]initWithObjects:Param1,Param2,Param3,nil];
    [Param1 release];[Param2 release];[Param3 release];
    NSString *soapActionURL=[NSString stringWithFormat:@"%@%@",NameSpace,MethodNameInsertNote];
    NetWebServiceRequest *request=[NetWebServiceRequest serviceRequestUrl:URLIP SOAPActionURL:soapActionURL ServiceMethodName:MethodNameInsertNote SoapMessageArr:ParamArr];
    [ParamArr release];
    [request startAsynchronous];
    [request setDelegate:self];
    self.runningRequest=request;

    HUD=[[MBProgressHUD showHUDAddedTo:[CCDirector sharedDirector].view animated:YES]retain];
    
    
}

#pragma mark NetWebServiceRequestDelegate Methods
-(void)netRequestStarted:(NetWebServiceRequest *)request{
    CLog(@"Start");
}

-(void)netRequestFinished:(NetWebServiceRequest *)request finishedInfoToResult:(NSString *)result responseData:(NSData *)requestData{
    CLog(@"Finish");
    [HUD setHidden:YES];
    [[CCDirector sharedDirector]replaceScene:[CCTransitionFadeBL transitionWithDuration:1 scene:[NotePage scene]]];
    
}

-(void)netRequestFailed:(NetWebServiceRequest *)request didRequestError:(NSError *)error{
    CLog(@"%@",error);
    [HUD setHidden:YES];
}

@end
