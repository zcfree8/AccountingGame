//
//  NSString+Array.m
//  AccountingGame
//
//  Created by OPSOFT on 14-6-3.
//
//

#import "NSString+Array.h"

@implementation NSString (Array)


-(NSArray *)strToArr{
    NSString *str=self;
    NSData *data=[str dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *resultDic=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    NSArray *DataArr=[resultDic valueForKey:[[resultDic allKeys]objectAtIndex:0]];
    return DataArr;
}

@end
