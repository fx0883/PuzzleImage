/*!
 @header AFHTTPRequestOperationManager
 @abstract ios6 访问网络调用
 @author FS (作者信息)
 @version 1.00 2014/10/12 Creation (此文档的版本信息)
 */

#import <Foundation/Foundation.h>



/*!
 *  AFHTTPRequestOperationManager
 */
@class AFHTTPRequestOperationManager;

@interface AFAppSoapClient : NSObject

+(NSMutableURLRequest*)createUrlRequest:(NSString*)strSoapMsg
                                 method:(NSString*)strMethod
                              urlString:(NSString*)strUrl;
+(AFHTTPRequestOperationManager*)sharedSoapManager;

+(NSMutableURLRequest*)createUrlRequest2:(NSDictionary*)dicParam
                           invokemethod:(NSString*)strMethod
                              urlString:(NSString*)strUrl;
@end
