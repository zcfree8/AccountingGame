//
//  registerViewController.m
//  AccountingGame
//
//  Created by 张超 on 13-9-23.
//
//

#import "registerViewController.h"
#import "loginViewController.h"
#import "CoverPage.h"
#import "LoginPage.h"
#import "GameUtils.h"
#define MethodNameRegister @"Register"



@interface registerViewController ()

@end

@implementation registerViewController

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
    self.view.frame=CGRectMake(0, 0, 320, 568);
    [self.createaccount setImage:[UIImage imageNamed:@"create_account_pressed.png"] forState:UIControlStateHighlighted];
    self.schoolAndClass=[NSMutableArray array];
    self.idArr=[NSMutableArray array];
   

    // Do any additional setup after loading the view from its nib.
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)Login:(id)sender {
    if(self.userName.text.length!=0&&self.nickName.text.length!=0&&self.passWord.text.length!=0&&self.passWordS.text.length!=0&&self.firstName.text.length!=0&&self.lastName.text.length!=0&&self.school.text.length!=0){
        if([self.passWord.text isEqualToString:self.passWordS.text]){
            Parameter *Param1=[[Parameter alloc]initParamWithName:@"UserNumber" AndKey:self.userName.text];
            Parameter *Param2=[[Parameter alloc]initParamWithName:@"PassWord" AndKey:self.passWord.text];
            Parameter *Param3=[[Parameter alloc]initParamWithName:@"Name" AndKey:self.firstName.text];
            Parameter *Param4=[[Parameter alloc]initParamWithName:@"NickName" AndKey:self.nickName.text];
            Parameter *Param5=[[Parameter alloc]initParamWithName:@"School" AndKey:self.school.text];
            NSArray *ParamArr=[[NSArray alloc]initWithObjects:Param1,Param2,Param3,Param4,Param5,nil];
            [Param1 release];[Param2 release];[Param3 release];[Param4 release];[Param5 release];
            NSString *soapActionURL=[NSString stringWithFormat:@"%@%@",NameSpace,MethodNameRegister];
            NetWebServiceRequest *request=[NetWebServiceRequest serviceRequestUrl:URLIP SOAPActionURL:soapActionURL ServiceMethodName:MethodNameRegister SoapMessageArr:ParamArr];
            [ParamArr release];
            [request startAsynchronous];
            [request setDelegate:self];
            self.runningRequest=request;
            HUD=[[MBProgressHUD showHUDAddedTo:self.view animated:YES]retain];
    
       }else{
            UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"密码不对" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles: nil];
            [alertView show];
            }
    }else{
        UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"请输入..." message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles: nil];
        [alertView show];
    }
    
}

#pragma mark NetWebServiceRequestDelegate Methods
-(void)netRequestStarted:(NetWebServiceRequest *)request{
    CLog(@"Start");
}

-(void)netRequestFinished:(NetWebServiceRequest *)request finishedInfoToResult:(NSString *)result responseData:(NSData *)requestData{
    CLog(@"Finish");
    [HUD setHidden:YES];
    
}

-(void)netRequestFailed:(NetWebServiceRequest *)request didRequestError:(NSError *)error{
    CLog(@"%@",error);
    [HUD setHidden:YES];
}



- (IBAction)Register:(id)sender {
    [self.view removeFromSuperview];
    [[CCDirector sharedDirector]replaceScene:[LoginPage scene]];
}

- (IBAction)keyBoardDismiss:(id)sender {
    [self.passWord resignFirstResponder];
    [self.userName resignFirstResponder];
    [self.passWordS resignFirstResponder];
    [self.nickName resignFirstResponder];
    [self.firstName resignFirstResponder];
    [self.lastName resignFirstResponder];
    [self.school resignFirstResponder];
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

- (IBAction)school:(id)sender {
    CGFloat xWidth = self.view.bounds.size.width - 80.0f;
    CGFloat yHeight = 320.0f;
    CGFloat yOffset = (self.view.bounds.size.height - yHeight)/2.0f;
    UIPopoverListView *poplistview = [[UIPopoverListView alloc] initWithFrame:CGRectMake(10, yOffset, xWidth, yHeight)];
    poplistview.delegate = self;
    poplistview.datasource = self;
    poplistview.listView.scrollEnabled = TRUE;
    [poplistview setTitle:@"Select..."];
    [poplistview show];
    [poplistview release];
    
}

#pragma mark - UIPopoverListViewDataSource

- (UITableViewCell *)popoverListView:(UIPopoverListView *)popoverListView
                    cellForIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                    reuseIdentifier:identifier] autorelease];
    
    int row = indexPath.row;
    
    cell.textLabel.text=[self.schoolAndClass objectAtIndex:row];
    
    return cell;
}

- (NSInteger)popoverListView:(UIPopoverListView *)popoverListView
       numberOfRowsInSection:(NSInteger)section
{
    return [self.schoolAndClass count];
}

#pragma mark - UIPopoverListViewDelegate
- (void)popoverListView:(UIPopoverListView *)popoverListView
     didSelectIndexPath:(NSIndexPath *)indexPath
{
    
    self.school.text=[self.schoolAndClass objectAtIndex:indexPath.row];
    self.scID=[[self.idArr objectAtIndex:indexPath.row]intValue];
    NSLog(@"%d",self.scID);
    // your code here
}

- (CGFloat)popoverListView:(UIPopoverListView *)popoverListView
   heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.0f;
}

- (void)dealloc {
    [_userName release];
    [_passWord release];
    [_passWordS release];
    [_nickName release];
    [_firstName release];
    [_lastName release];
    [_school release];
    [_createaccount release];
    [_tick release];
    [_school release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setUserName:nil];
    [self setPassWord:nil];
    [self setPassWordS:nil];
    [self setNickName:nil];
    [self setFirstName:nil];
    [self setLastName:nil];
    [self setSchool:nil];
    [self setCreateaccount:nil];
    [self setTick:nil];
    [self setSchool:nil];
    [super viewDidUnload];
}
@end
