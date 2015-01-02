/*!
 @header AFAppAPIClient
 @abstract ios6 访问网络调用
 @author FS (作者信息)
 @version 1.00 2014/10/12 Creation (此文档的版本信息)
 */
#import <Foundation/Foundation.h>

/*!
 *  AFHTTPRequestOperationManager
 */
@class AFHTTPRequestOperationManager;

@interface AFAppAPIClient : NSObject

/*!
 *  设置BaseUrl,现在一般都配置用
 *
 *  @param urlString
 */
+(void)setBaseUrl:(NSString*)urlString;

/*!
 *  sharedHttpManager
 *
 *  @return 返回单例
 */
+(AFHTTPRequestOperationManager*)sharedHttpManager;
@end
