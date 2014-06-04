//
//  loginViewController.h
//  AccountingGame
//
//  Created by 张超 on 13-9-23.
//
//

#import <UIKit/UIKit.h>
#import "cocos2d.h"
#import "NetWebServiceRequest.h"
#import "UnderLineLabel.h"
#import "MBProgressHUD.h"
@interface loginViewController : UIViewController<NetWebServiceRequestDelegate>{
    BOOL Login;
    BOOL tickS;
    MBProgressHUD *HUD;
}

- (IBAction)Login:(id)sender;
@property (retain, nonatomic) IBOutlet UnderLineLabel *regis;
@property (retain, nonatomic) IBOutlet UnderLineLabel *forget;


- (IBAction)keyBoardDissmiss:(id)sender;
- (IBAction)tick:(id)sender;
- (IBAction)textFieldDoneEditing:(id)sender;


@property (retain, nonatomic) IBOutlet UITextField *userName;
@property (retain, nonatomic) IBOutlet UITextField *passWord;
@property (retain, nonatomic) IBOutlet UIButton *signIn;
@property (retain, nonatomic) IBOutlet UIButton *tick;

@property(nonatomic,retain) NetWebServiceRequest *runningRequest;

@property(assign)int u_id;

@property(nonatomic,retain)NSArray *dataMutArr;

@end
