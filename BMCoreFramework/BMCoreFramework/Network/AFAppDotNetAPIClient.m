// AFAppDotNetAPIClient.h
//
// Copyright (c) 2012 Mattt Thompson (http://mattt.me/)
// 
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
// 
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
// 
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "AFAppDotNetAPIClient.h"
#import "AFHTTPSessionManager.h"
//static NSString * const AFAppDotNetAPIBaseURLString = @"https://alpha-api.app.net/";

@implementation AFAppDotNetAPIClient
static NSString *strBaseUrl=nil;
+(void)setBaseUrl:(NSString*)urlString
{
    strBaseUrl = urlString;
}


+ (instancetype)sharedClient {
    static AFAppDotNetAPIClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{

        if (strBaseUrl==nil) {
            strBaseUrl = [SharedBMContext getContextDicForKey:DEFBASEURL];
        }
        
        _sharedClient = [[AFAppDotNetAPIClient alloc] initWithBaseURL:[NSURL URLWithString:strBaseUrl]];
//       _sharedClient.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",/*@"text/plain",*/ nil];
        
        _sharedClient.responseSerializer.acceptableContentTypes= [NSSet setWithObjects:@"text/html",@"application/json", @"text/json", @"text/javascript",@"text/plain", nil];
        

    });
    
    return _sharedClient;
}

+ (instancetype)sharedClient2 {
    static AFAppDotNetAPIClient *_sharedClient2 = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        NSString *strBaseUrl2 = [SharedBMContext getContextDicForKey:DEFBASEURL2];
        
        _sharedClient2 = [[AFAppDotNetAPIClient alloc] initWithBaseURL:[NSURL URLWithString:strBaseUrl2]];
        
        _sharedClient2.responseSerializer.acceptableContentTypes= [NSSet setWithObjects:@"text/html",@"application/json", @"text/json", @"text/javascript",@"text/plain", nil];
    });
    
    return _sharedClient2;
}


+ (instancetype)sharedClient3 {
    static AFAppDotNetAPIClient *_sharedClient3 = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        NSString *strBaseUrl3 = [SharedBMContext getContextDicForKey:DEFBASEURL3];
        
        _sharedClient3 = [[AFAppDotNetAPIClient alloc] initWithBaseURL:[NSURL URLWithString:strBaseUrl3]];
        
        _sharedClient3.responseSerializer.acceptableContentTypes= [NSSet setWithObjects:@"text/html",@"application/json", @"text/json", @"text/javascript",@"text/plain", nil];
    });
    
    return _sharedClient3;
}






#pragma mark- http 返回


+ (instancetype)sharedHttpClient {
    static AFAppDotNetAPIClient *_sharedHttpClient2 = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (strBaseUrl==nil) {
            strBaseUrl = [SharedBMContext getContextDicForKey:DEFBASEURL];
        }
        _sharedHttpClient2 = [[AFAppDotNetAPIClient alloc] initWithBaseURL:[NSURL URLWithString:strBaseUrl]];
        
        _sharedHttpClient2.responseSerializer = [AFHTTPResponseSerializer serializer];
    });
    
    return _sharedHttpClient2;
}

+ (instancetype)sharedHttpClient2 {
    static AFAppDotNetAPIClient *_sharedHttpClient2 = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSString *strBaseUrl2 = [SharedBMContext getContextDicForKey:DEFBASEURL2];
        _sharedHttpClient2 = [[AFAppDotNetAPIClient alloc] initWithBaseURL:[NSURL URLWithString:strBaseUrl2]];
        
        _sharedHttpClient2.responseSerializer = [AFHTTPResponseSerializer serializer];
    });
    
    return _sharedHttpClient2;
}

+ (instancetype)sharedHttpClient3 {
    static AFAppDotNetAPIClient *_sharedHttpClient3 = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSString *strBaseUrl3 = [SharedBMContext getContextDicForKey:DEFBASEURL3];
        _sharedHttpClient3 = [[AFAppDotNetAPIClient alloc] initWithBaseURL:[NSURL URLWithString:strBaseUrl3]];

        _sharedHttpClient3.responseSerializer = [AFHTTPResponseSerializer serializer];
    });
    
    return _sharedHttpClient3;
}






@end
