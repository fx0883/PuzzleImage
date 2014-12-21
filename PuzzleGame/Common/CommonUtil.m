//
//  CommonUtil.m
//  PuzzleGame
//
//  Created by fx on 14/10/28.
//  Copyright (c) 2014年 FS. All rights reserved.
//

#import "CommonUtil.h"

@implementation CommonUtil

+(void)giveMeRate
{
    [Appirater setAppId:@"921615471"];
    [Appirater setDaysUntilPrompt:5];
    [Appirater setUsesUntilPrompt:0];
    [Appirater setSignificantEventsUntilPrompt:-1];
    [Appirater setTimeBeforeReminding:2];
    [Appirater setDebug:YES];
    [Appirater appLaunched:YES];
}

+(NSString *)localStringForImageCategory:(NSString *)category {
    
    return PGLocalString(category);
    
//    if ([category isEqualToString:@"人物"]) {
//        return @"";
//    } else if ([category isEqualToString:@"动漫"]) {
//        return @"";
//    } else if ([category isEqualToString:@"动物"]) {
//        return @"";
//    } else if ([category isEqualToString:@"卡通"]) {
//        return @"";
//    } else if ([category isEqualToString:@"家居"]) {
//        return @"";
//    } else if ([category isEqualToString:@"建筑"]) {
//        return @"";
//    } else if ([category isEqualToString:@"文艺"]) {
//        return @"";
//    } else if ([category isEqualToString:@"风景"]) {
//        return @"";
//    }
//    
//    return nil;
}

@end
