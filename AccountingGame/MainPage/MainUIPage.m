//
//  MainUIPage.m
//  AccountingGame
//
//  Created by 张超 on 13-9-9.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import "MainUIPage.h"
#import "CoverPage.h"
#import "MainPage.h"
#import "UserUtils.h"
#import "GameUtils.h"
#import "SettingPage.h"
#import "QuestionPage.h"
#define MethodNameGetQuestion @"GetQuestion"

@implementation MainUIPage

+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	MainUIPage *layer = [MainUIPage node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

//添加category信息
-(void)gameItem{
    //获取题目类型
    self.dataMutArr=[GameUtils getCurrentUserInfo].dataArr;
    //显示图片
    NSString *imgPath1;
    NSString *imgPath2;
    //题目总数和已做题目数
    int SumNum=0;
    int DoneNum=0;
    int CorrectNum=0;
    //添加scrollview
    if(iPhone5){
    scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(20, 230, 280, 260)];
    }else{
    scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(20, 190, 280, 230)];
    }
    scrollView.backgroundColor=[UIColor clearColor];
    scrollView.delegate=self;
    scrollView.showsVerticalScrollIndicator=NO;
    
    [scrollView setContentSize:CGSizeMake(280, 430)];
    [[CCDirector sharedDirector].view addSubview:scrollView];
    float x,y;
    x=145;
    
    
    //添加category
    for(int i=0;i<self.dataMutArr.count;i++){
        if(iPhone5){
            y=90*i;
        }else{
            y=80*i;
        }
       
        NSDictionary *site=[self.dataMutArr objectAtIndex:i];
        SumNum=[[site valueForKey:@"FSumNum"]intValue];
        DoneNum=[[site valueForKey:@"FDoneNum"]intValue];
        CorrectNum=[[site valueForKey:@"FCorrectNum"]intValue];
        
        if(DoneNum>=SumNum){
          
            imgPath1=@"bar_glow.png";
            imgPath2=@"bar.png";
        }else{
        
            imgPath1=@"bar.png";
            imgPath2=@"bar_glow.png";
        }
        
        //添加题目类型底色
        UIButton *items=[[UIButton alloc]initWithFrame:CGRectMake(10, y, 260, 70)];
        [items setImage:[UIImage imageNamed:imgPath1] forState:UIControlStateNormal];
        [items addTarget:self action:@selector(itemTap:) forControlEvents:UIControlEventTouchUpInside];
        items.tag=[[site valueForKey:@"FType"] characterAtIndex:0]-65;
        [scrollView addSubview:items];
      
        //添加题目
        UILabel *itemLabels=[[UILabel alloc]initWithFrame:CGRectMake(10, 10, 160, 30)];
        itemLabels.text=[site valueForKey:@"FTopic"];
        itemLabels.font=[UIFont fontWithName:@"Helvetica-Bold" size:20];
        itemLabels.backgroundColor=[UIColor clearColor];
        
        //添加得分
        UILabel *itemPoints=[[UILabel alloc]initWithFrame:CGRectMake(10, 30, 200, 30)];
        itemPoints.backgroundColor=[UIColor clearColor];
        
        if(DoneNum==0){
            itemPoints.text=[NSString stringWithFormat:@"POINTS:?/%d",SumNum];
        }else{
            itemPoints.text=[NSString stringWithFormat:@"POINTS:%d/%d",CorrectNum,SumNum];
        }
        itemPoints.font=[UIFont fontWithName:@"Helvetica-Bold" size:15];
        
        //添加图标
        UIImageView *images=[[[UIImageView alloc]init]autorelease];
        NSString *strImage=nil;
        //判断是否通关
        if(DoneNum>=SumNum){
            strImage=@"tap to review flag.png";
            images.Frame=CGRectMake(150, 15, 100, 40);
            
        }else{
            itemLabels.textColor=[UIColor whiteColor];
            itemPoints.textColor=[UIColor whiteColor];
            strImage=@"lock.png";
            images.Frame=CGRectMake(200, 10, 50, 50);
        }
        images.image=[UIImage imageNamed:strImage];
        
        [items addSubview:images];
        [items addSubview:itemLabels];
        [items addSubview:itemPoints];
    }
}

-(id) init {
    if(self=[super init]){
        if(iPhone5){
            //添加背景图片
            CGSize size=[[CCDirector sharedDirector]winSize];
            CCSprite *background=[CCSprite spriteWithFile:@"bkgrd2.png"];
            [self addChild:background z:4];
            [background setPosition:ccp(size.width/2, size.height/2)];
            
            //添加girl头像
            CCSprite *girlIcon=[CCSprite spriteWithFile:@"girl icon.png"];
            [self addChild:girlIcon z:4];
            girlIcon.position=ccp(160, 430);
            
            //设置和返回按钮
            CCMenuItem *backBtn=[CCMenuItemImage itemWithNormalImage:@"back button.png" selectedImage:@"back button_glow.png" target:self selector:@selector(backButtonTap:)];
            CCMenuItem *setBtn=[CCMenuItemImage itemWithNormalImage:@"settings button.png" selectedImage:@"settings button_glow.png" target:self selector:@selector(setButtonTap:)];
            backBtn.position=ccp(30, 540);
            setBtn.position=ccp(290, 540);
            CCMenu *startMenu=[CCMenu menuWithItems:backBtn,setBtn, nil];
            startMenu.position=CGPointZero;
            [self addChild:startMenu z:4];
            
        }else{
            //添加背景图片
            CGSize size=[[CCDirector sharedDirector]winSize];
            CCSprite *background=[CCSprite spriteWithFile:@"bkgrd2s.png"];
            [self addChild:background z:4];
            [background setPosition:ccp(size.width/2, size.height/2)];
            
            //添加girl头像
            CCSprite *girlIcon=[CCSprite spriteWithFile:@"girl icon.png"];
            [self addChild:girlIcon z:4];
            girlIcon.position=ccp(160, 355);
            
            //设置和返回按钮
            CCMenuItem *backBtn=[CCMenuItemImage itemWithNormalImage:@"back button.png" selectedImage:@"back button_glow.png" target:self selector:@selector(backButtonTap:)];
            CCMenuItem *setBtn=[CCMenuItemImage itemWithNormalImage:@"settings button.png" selectedImage:@"settings button_glow.png" target:self selector:@selector(setButtonTap:)];
            backBtn.position=ccp(30, 450);
            setBtn.position=ccp(290, 450);
            CCMenu *startMenu=[CCMenu menuWithItems:backBtn,setBtn, nil];
            startMenu.position=CGPointZero;
            [self addChild:startMenu z:4];
        
        }
        self.isTouchEnabled=YES;

        [self gameItem];
    }
    
    return self;
    
}

//返回开始界面
-(void)backButtonTap:(id)sender{
    
    [[CCDirector sharedDirector]replaceScene:[CoverPage scene]];
}

//设置按钮
-(void)setButtonTap:(id)sender{
    
    [[CCDirector sharedDirector]replaceScene:[SettingPage scene]];
}

//点击进入答题界面
-(void)itemTap:(UIButton *)sender{
    CCLOG(@"%ld",(long)sender.tag);
    [GameUtils getCurrentUserInfo].cID=sender.tag;
  
    [self category];
    
}


-(void)category{

    NSString *UserID=[NSString stringWithFormat:@"%d",[GameUtils getCurrentUserInfo].u_id];
    NSString *Type=[NSString stringWithFormat:@"%c",[GameUtils getCurrentUserInfo].cID+65];
   
    int Num=1;
    [GameUtils getCurrentUserInfo].SumNum=[[[self.dataMutArr objectAtIndex:[GameUtils getCurrentUserInfo].cID]valueForKey:@"FSumNum"]intValue];
    [GameUtils getCurrentUserInfo].CorrectNum=[[[self.dataMutArr objectAtIndex:[GameUtils getCurrentUserInfo].cID]valueForKey:@"FCorrectNum"]intValue];
    [GameUtils getCurrentUserInfo].DoneNum=[[[self.dataMutArr objectAtIndex:[GameUtils getCurrentUserInfo].cID]valueForKey:@"FDoneNum"]intValue];
    if([GameUtils getCurrentUserInfo].DoneNum>=[GameUtils getCurrentUserInfo].SumNum){
        Num=1;
        [GameUtils getCurrentUserInfo].DoneNum=Num;
        [GameUtils getCurrentUserInfo].Status=@"B";
    }else{
        Num=[[[self.dataMutArr objectAtIndex:[GameUtils getCurrentUserInfo].cID ]valueForKey:@"FDoneNum"]intValue]+1;
        [GameUtils getCurrentUserInfo].DoneNum=Num;
        [GameUtils getCurrentUserInfo].Status=@"A";
    }
    NSString *Status=[GameUtils getCurrentUserInfo].Status;
    NSString *Number=[NSString stringWithFormat:@"%d",Num];
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

#pragma mark NetWebServiceRequestDelegate Methods
-(void)netRequestStarted:(NetWebServiceRequest *)request{
    CLog(@"Start");
}

-(void)netRequestFinished:(NetWebServiceRequest *)request finishedInfoToResult:(NSString *)result responseData:(NSData *)requestData{
    CLog(@"Finish");
    [HUD setHidden:YES];
    if(result.length!=0){
        [GameUtils getCurrentUserInfo].questionArr=[result strToArr];
        if([[GameUtils getCurrentUserInfo].Status isEqualToString:@"A"]){
            [[CCDirector sharedDirector]replaceScene:[MainPage scene]];
        }else{
            [[CCDirector sharedDirector]replaceScene:[QuestionPage scene]];
        }
    }
}

-(void)netRequestFailed:(NetWebServiceRequest *)request didRequestError:(NSError *)error{
    CLog(@"%@",error);
    [HUD setHidden:YES];
}



-(void)dealloc{
    [scrollView removeFromSuperview];
    [scrollView release];

    [super dealloc];
}

@end
