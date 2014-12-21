/*!
 @header AFAppDotNetAPIClient
 @abstract ios6 访问网络调用
 @author FS (作者信息)
 @version 1.00 2014/10/12 Creation (此文档的版本信息)
 */

#import <Foundation/Foundation.h>
#import "AFHTTPSessionManager.h"

/*!
 @class
 @abstract 用于IOS7网络访问
 */
@interface AFAppDotNetAPIClient : AFHTTPSessionManager
+(void)setBaseUrl:(NSString*)urlString;


/*!
 *  服务器地址1，Json 返回
 *
 *  @return 返回用于访问服务器1的单例
 */
+ (instancetype)sharedClient;
/*!
 *  服务器地址2，Json 返回
 *
 *  @return 返回用于访问服务器2的单例
 */
+ (instancetype)sharedClient2;
/*!
 *  服务器地址3，Json 返回
 *
 *  @return 返回用于访问服务器3的单例
 */
+ (instancetype)sharedClient3;






/*!
 *  服务器地址1，http 返回
 *
 *  @return 返回用于访问服务器1的单例
 */
+ (instancetype)sharedHttpClient;
/*!
 *  服务器地址2，http 返回
 *
 *  @return 返回用于访问服务器2的单例
 */
+ (instancetype)sharedHttpClient2;
/*!
 *  服务器地址3，http 返回
 *
 *  @return 返回用于访问服务器3的单例
 */
+ (instancetype)sharedHttpClient3;

@end
