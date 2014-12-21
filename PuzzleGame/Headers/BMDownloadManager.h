/*!
 @header BMDownloadManager
 @abstract 下载管理类
 @author FS (作者信息)
 @version 1.00 2014/10/12 Creation (此文档的版本信息)
 */

typedef NS_ENUM(NSInteger, DOWNLOADTYPE)
{
    //以下是枚举成员
    READY = 0,
    EXECUTING = 1,
    STOP = 2,
    PAUSE = 3,
    ENDTRANSFER=4
};


@class BMDownloadFileInfo;

/*!
 @class
 @abstract 下载管理类
 */
@interface BMDownloadManager : BMBaseAction
AS_SINGLETON(BMDownloadManager)


/*!
 @property
 @abstract dicDownloadRequestOperation
 */
@property (nonatomic,strong) NSMutableDictionary *dicDownloadRequestOperation;

-(void)downloadFileInfoWithBaseParam:(BMBaseParam*)baseparam;
-(void)downloadFileWithBaseParam:(BMBaseParam*)baseparam;

/*!
 *  开始下载
 *
 *  @param musicEntity
 */
-(void)startDownload:(BMDownloadFileInfo*)musicEntity;
/*!
 *  暂停下载
 *
 *  @param musicEntity
 */
-(void)pauseDownload:(BMDownloadFileInfo*)musicEntity;


/*!
 *  删除下载任务
 *
 *  @param downloadfileinfo
 *  @param isDelete
 */
-(void)deleteDownloadTask:(BMDownloadFileInfo*)downloadfileinfo withDeleteFile:(BOOL)isDelete;

/*!
 *  删除下载任务
 *
 *  @param downloadfileinfo
 */
-(void)deleteDownloadTask:(BMDownloadFileInfo*)downloadfileinfo;

/*!
 *  删除下载队列
 *
 *  @param task
 */
-(void)deleteQueueTask:(id)task;

/*!
 @property intDownloadThreadCount
 @abstract 下载线程数
 */
@property (readwrite) NSInteger intDownloadThreadCount;

@end

/*!
 *  SharedBMDownloadManager
 */
#define SharedBMDownloadManager   ([BMDownloadManager sharedInstance])