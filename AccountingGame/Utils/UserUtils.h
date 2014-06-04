//
//  UserUtils.h
//  AccountingGame
//
//  Created by 张超 on 13-9-11.
//
//



#import <Foundation/Foundation.h>


@interface UserUtils : NSObject
   

@property(assign)int u_id;
@property(assign)int cID;
@property(assign,nonatomic) BOOL isLogin;
@property(nonatomic,retain)NSString *Status; //A: 答题模式  B:复习模式

@property(nonatomic,retain)NSArray *dataArr;
@property(nonatomic,retain)NSArray *questionArr;

@property(assign)int SumNum;
@property(assign)int DoneNum;
@property(assign)int CorrectNum;

@property(nonatomic,retain)NSString *correctOrIncorrect;


@end
