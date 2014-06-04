//
//  registerViewController.h
//  AccountingGame
//
//  Created by 张超 on 13-9-23.
//
//

#import <UIKit/UIKit.h>
#import "NetWebServiceRequest.h"
#import "MBProgressHUD.h"
#import "UIPopoverListView.h"

@interface registerViewController : UIViewController<NetWebServiceRequestDelegate,UIPopoverListViewDataSource,UIPopoverListViewDelegate>{
    BOOL tickS;
    MBProgressHUD *HUD;
}

@property(nonatomic,retain) NetWebServiceRequest *runningRequest;

- (IBAction)Login:(id)sender;
- (IBAction)Register:(id)sender;
- (IBAction)keyBoardDismiss:(id)sender;
- (IBAction)tick:(id)sender;
- (IBAction)school:(id)sender;


@property (retain, nonatomic) IBOutlet UITextField *userName;
@property (retain, nonatomic) IBOutlet UITextField *firstName;
@property (retain, nonatomic) IBOutlet UITextField *lastName;
@property (retain, nonatomic) IBOutlet UITextField *school;
@property (retain, nonatomic) IBOutlet UITextField *nickName;
@property (retain, nonatomic) IBOutlet UITextField *passWord;
@property (retain, nonatomic) IBOutlet UITextField *passWordS;

@property (retain, nonatomic) IBOutlet UIButton *createaccount;
@property (retain, nonatomic) IBOutlet UIButton *tick;



@property(retain,nonatomic)NSMutableArray *schoolAndClass;
@property(assign)int sc_id;
@property(assign)int scID;
@property(assign)NSString *className;
@property(retain,nonatomic)NSMutableArray *idArr;
@end
