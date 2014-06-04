//
//  loginViewController.m
//  AccountingGame
//
//  Created by 张超 on 13-9-23.
//
//

#import "loginViewController.h"
#import "registerViewController.h"
#import "CoverPage.h"
#import "RegisterPage.h"
#import "GameUtils.h"
#import "MainUIPage.h"
#import "LoginPage.h"
#define MethodNameLogin @"Login"
#define MethodNameGetUserGameNote @"GetUserGameNote"

@interface loginViewController ()

@end

@implementation loginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.dataMutArr=[NSMutableArray array];
    self.view.frame=CGRectMake(0, 0, 320, 568);
    self.passWord.secureTextEntry=YES;
    [self.signIn setImage:[UIImage imageNamed:@"sign_commit_pressed.png"] forState:UIControlStateHighlighted];
    [self.regis setBackgroundColor:[UIColor clearColor]];
    self.regis.shouldUnderline=YES;
    self.regis.highlightedColor=[UIColor grayColor];
    
    [self.regis setText:@"Sign up for an account!" andCenter:CGPointMake(200, 180)];
    [self.forget setText:@"Forget your password?" andCenter:CGPointMake(200, 280)];
    
    [self.regis addTarget:self action:@selector(Register:)];
    
    [self.forget setBackgroundColor:[UIColor clearColor]];
    self.forget.shouldUnderline=YES;
    self.forget.highlightedColor=[UIColor grayColor];
    
    [self.forget addTarget:self action:@selector(forget:)];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)Login:(id)sender {
    if(self.userName.text.length!=0&&self.passWord.text.length!=0){
        Parameter *Param1=[[Parameter alloc]initParamWithName:@"UserNumber" AndKey:self.userName.text];
        Parameter *Param2=[[Parameter alloc]initParamWithName:@"PassWord" AndKey:self.passWord.text];
        NSArray *ParamArr=[[NSArray alloc]initWithObjects:Param1,Param2, nil];
        [Param1 release];[Param2 release];
        NSString *soapActionURL=[NSString stringWithFormat:@"%@%@",NameSpace,MethodNameLogin];
        NetWebServiceRequest *request=[NetWebServiceRequest serviceRequestUrl:URLIP SOAPActionURL:soapActionURL ServiceMethodName:MethodNameLogin SoapMessageArr:ParamArr];
        [ParamArr release];
        [request startAsynchronous];
        [request setDelegate:self];
        self.runningRequest=request;
        HUD=[[MBProgressHUD showHUDAddedTo:self.view animated:YES]retain];

    }else{
        UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"请输入..." message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:nil];
        [alertView show];
        [alertView release];
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
        self.u_id=[[[DataArr objectAtIndex:0]valueForKey:@"FItemID"]intValue];
        [GameUtils getCurrentUserInfo].u_id=self.u_id;
        [self category];
    }
}

-(void)netRequestFailed:(NetWebServiceRequest *)request didRequestError:(NSError *)error{
    CLog(@"%@",error);
    [HUD setHidden:YES];
}


-(void)category{
    //请求网络数据
    NSString *uid=[NSString stringWithFormat:@"%d",self.u_id];
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
    [self.view removeFromSuperview];
    [[CCDirector sharedDirector]replaceScene:[MainUIPage scene]];
    
}

- (void)Register:(id)sender {
    [self.view removeFromSuperview];
    [[CCDirector sharedDirector]replaceScene:[RegisterPage scene]];
}

-(void)forget:(id)sender{
    
}

- (IBAction)keyBoardDissmiss:(id)sender {
    [self.userName resignFirstResponder];
    [self.passWord resignFirstResponder];
    
}

- (IBAction)tick:(id)sender {
    if(!tickS){
        [self.tick setImage:[UIImage imageNamed:@"tick.png"] forState:UIControlStateNormal];
        tickS=YES;
    }else{
        [self.tick setImage:nil forState:UIControlStateNormal];
        tickS=NO;
    }
}

- (IBAction)textFieldDoneEditing:(id)sender {
    [sender resignFirstResponder];
}



- (void)dealloc {
    [_userName release];
    [_passWord release];
    [_signIn release];
    [_tick release];
    [_regis release];
    [_forget release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setUserName:nil];
    [self setPassWord:nil];
    [self setSignIn:nil];
    [self setTick:nil];
    [self setRegis:nil];
    [self setForget:nil];
    [super viewDidUnload];
}
@end
