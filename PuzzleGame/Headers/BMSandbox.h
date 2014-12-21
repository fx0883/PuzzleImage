/*!
 @header BMSandbox
 @abstract BMSandbox
 @author FS (作者信息)
 @version 1.00 2014/10/12 Creation (此文档的版本信息)
 */



/*!
 @class
 @abstract BMSandbox
 */
@interface BMSandbox : NSObject

/*!
 @property
 @abstract appPath
 */
@property (nonatomic, readonly) NSString *	appPath;
/*!
 @property
 @abstract docPath
 */
@property (nonatomic, readonly) NSString *	docPath;
/*!
 @property
 @abstract libPrefPath
 */
@property (nonatomic, readonly) NSString *	libPrefPath;
/*!
 @property
 @abstract libCachePath
 */
@property (nonatomic, readonly) NSString *	libCachePath;

/*!
 @property
 @abstract tmpPath
 */
@property (nonatomic, readonly) NSString *	tmpPath;

AS_SINGLETON( BMSandbox )


/*!
 *  程序目录，不能存任何东西
 *
 *  @return
 */
+ (NSString *)appPath;
/*!
 *  文档目录，需要ITUNES同步备份的数据存这里
 *
 *  @return
 */
+ (NSString *)docPath;
/*!
 *  配置目录，配置文件存这里
 *
 *  @return
 */
+ (NSString *)libPrefPath;
/*!
 *  缓存目录，系统永远不会删除这里的文件，ITUNES会删除
 *
 *  @return
 */
+ (NSString *)libCachePath;
/*!
 *  缓存目录，APP退出后，系统可能会删除这里的内容
 *
 *  @return
 */
+ (NSString *)tmpPath;

/*!
 *  touch
 *
 *  @param path
 *
 *  @return
 */
+ (BOOL)touch:(NSString *)path;
/*!
 *  touchFile
 *
 *  @param file file
 *
 *  @return
 */
+ (BOOL)touchFile:(NSString *)file;

@end
