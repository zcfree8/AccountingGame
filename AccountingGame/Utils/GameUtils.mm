//
//  GameUtils.m
//  AccountingGame
//
//  Created by 张超 on 13-9-10.
//
//

#import "GameUtils.h"

@implementation GameUtils

+(UserUtils *)getCurrentUserInfo{
    static dispatch_once_t pred;
    static UserUtils *currentUser;
    dispatch_once(&pred, ^{
        currentUser=[[UserUtils alloc]init];
    });
    return currentUser;
}
@end
