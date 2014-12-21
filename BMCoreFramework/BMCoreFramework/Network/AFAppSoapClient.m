//
//  AFAppSoapClient.m
//  BMCoreFramework
//
//  Created by fx on 14/10/24.
//  Copyright (c) 2014年 bluemobi. All rights reserved.
//

#import "AFAppSoapClient.h"
#import "AFNetworking.h"
@implementation AFAppSoapClient


+(AFHTTPRequestOperationManager*)sharedSoapManager
{
    
    
    static AFHTTPRequestOperationManager *_sharedSoapManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        _sharedSoapManager = [AFHTTPRequestOperationManager manager];
        
//        _sharedSoapManager.responseSerializer.acceptableContentTypes= [NSSet setWithObjects:@"text/html",@"application/json", @"text/json", @"text/javascript",@"text/plain",@"" nil];
        
        
        _sharedSoapManager.responseSerializer = [[AFHTTPResponseSerializer alloc] init];
        NSLog(@"manager.responseSerializer = %@", _sharedSoapManager.responseSerializer);
        [_sharedSoapManager.requestSerializer setValue:@"application/soap+xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//        _sharedSoapManager.responseSerializer.acceptableContentTypes =[NSSet setWithObjects:@"text/html",@"application/json", @"text/json", @"text/javascript",@"text/plain",@"",@"application/soap+xml", nil];
        [_sharedSoapManager.requestSerializer setValue:@"length" forHTTPHeaderField:@"Content-Length"];
        
        
        
    });
    
    return _sharedSoapManager;
    

}

+(NSMutableURLRequest*)createUrlRequest2:(NSDictionary*)dicParam
                                 invokemethod:(NSString*)strMethod
                              urlString:(NSString*)strUrl
{
    NSMutableArray *ary = [NSMutableArray new];

    
    NSArray *keys;
    NSInteger i, count;
    id key, value;
    
    keys = [dicParam allKeys];
    count = [keys count];
    for (i = 0; i < count; i++)
    {
        key = [keys objectAtIndex: i];
        value = [dicParam objectForKey: key];
        
        [ary addObject:[NSDictionary dictionaryWithObjectsAndKeys:value,key, nil]];
    }
    
    NSString *soapMsg=[SoapHelper arrayToDefaultSoapMessage:ary methodName:strMethod];
    
//    NSString *soapMsg=@"<?xml version=\"1.0\" encoding=\"utf-8\"?>"
//    
//    "<soap12:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:"
//    
//    
//    "xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap12=\"http://www.w3.org/2003/05/soap-envelope\">"
//    "<soap12:Body>"
//    "<getRegionCountry xmlns=\"http://WebXml.com.cn/\" >"
//
//    "</soap12:Body>"
//    "</soap12:Envelope>";
    
//    NSString *soapMsg=@"<?xml version=\"1.0\" encoding=\"utf-8\"?>"
//    
//    "<soap12:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:"
//    
//    
//    "xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap12=\"http://www.w3.org/2003/05/soap-envelope\">"
//    "<soap12:Body>"
//    "<getRegionCountry xmlns=\"http://WebXml.com.cn/\" >"
//    "</getRegionCountry>"
//    "</soap12:Body>"
//    "</soap12:Envelope>";
    
    
    NSMutableURLRequest* request=nil;
    
    AFHTTPRequestOperationManager *manager = [AFAppSoapClient sharedSoapManager];
    
    
    strUrl = [NSString stringWithFormat:@"%@/%@",[SharedBMContext getContextDicForKey:DEFBASESOAPURL],strUrl];
    
    
    
    //    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:baseUrl];
    //    manager.responseSerializer = [[AFHTTPResponseSerializer alloc] init];
    //    NSLog(@"manager.responseSerializer = %@", manager.responseSerializer);
    //    [manager.requestSerializer setValue:@"application/soap+xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    //    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/soap+xml"];
    //    [manager.requestSerializer setValue:@"length" forHTTPHeaderField:@"Content-Length"];
    
    request = [manager.requestSerializer requestWithMethod:@"POST" URLString:strUrl parameters:nil error:nil];
    [request setHTTPBody:[soapMsg dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    
    
    return request;
  
}



+(NSMutableURLRequest*)createUrlRequest:(NSString*)strSoapMsg
                                 method:(NSString*)strMethod
                              urlString:(NSString*)strUrl
{
    NSMutableURLRequest* request=nil;
    
    AFHTTPRequestOperationManager *manager = [AFAppSoapClient sharedSoapManager];
    
    
    strUrl = [NSString stringWithFormat:@"%@/%@",[SharedBMContext getContextDicForKey:DEFBASESOAPURL],strUrl];
    

    
    //    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:baseUrl];
//    manager.responseSerializer = [[AFHTTPResponseSerializer alloc] init];
//    NSLog(@"manager.responseSerializer = %@", manager.responseSerializer);
//    [manager.requestSerializer setValue:@"application/soap+xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/soap+xml"];
//    [manager.requestSerializer setValue:@"length" forHTTPHeaderField:@"Content-Length"];
    
    request = [manager.requestSerializer requestWithMethod:strMethod URLString:strUrl parameters:nil error:nil];
    [request setHTTPBody:[strSoapMsg dataUsingEncoding:NSUTF8StringEncoding]];

    
    
    
    return request;
}

@end


