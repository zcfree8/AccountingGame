//
//  GCHelper.h
//  AccountingGame
//
//  Created by 张超 on 13-9-15.
//
//

#import <Foundation/Foundation.h>
#import <GameKit/GameKit.h>



@interface GCHelper : NSObject  {
    BOOL gameCenterAvailable;
    BOOL userAuthenticated;
    
    
}

@property (assign, readonly) BOOL gameCenterAvailable;


+ (GCHelper *)sharedInstance;
- (void)authenticateLocalUser;

@end
