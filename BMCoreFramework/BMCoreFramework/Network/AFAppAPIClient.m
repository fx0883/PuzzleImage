//
//  AFAppAPIClient.m
//  HaixinProject
//
//  Created by fx on 14-8-15.
//  Copyright (c) 2014年 bluemobi. All rights reserved.
//

#import "AFAppAPIClient.h"
#import "AFNetworking.h"
@implementation AFAppAPIClient

static NSString *strBaseUrl=nil;
+(void)setBaseUrl:(NSString*)urlString
{
    strBaseUrl = urlString;
}
+(AFHTTPRequestOperationManager*)sharedHttpManager
{

    
    static AFHTTPRequestOperationManager *_sharedHttpManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        if (strBaseUrl==nil) {
            strBaseUrl = [SharedBMContext getContextDicForKey:DEFBASEURL];
        }
        NSURL *baseUrl= [NSURL URLWithString:strBaseUrl];
        
        
        _sharedHttpManager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:baseUrl];
        
        _sharedHttpManager.responseSerializer.acceptableContentTypes= [NSSet setWithObjects:@"text/html",@"application/json", @"text/json", @"text/javascript",@"text/plain", nil];
    });
    
    return _sharedHttpManager;

}
@end
