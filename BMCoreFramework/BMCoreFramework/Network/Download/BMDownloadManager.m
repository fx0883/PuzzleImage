//
//  FSDownloadManager.m
//  MucixDown
//
//  Created by fx on 14-5-20.
//  Copyright (c) 2014年 FS. All rights reserved.
//

#import "BMDownloadManager.h"
#import "BMDownloadFileInfo.h"
#import "AFDownloadRequestOperation.h"
//#define MAXDOWNLOADTHREAD 3
//#define TRYDOWNLOADTIMES 10


//#define filefolderPath ([[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES) lastObject] stringByAppendingPathComponent:musicFolderName])
//#define MUSICFile(name) ([musicfolderPath stringByAppendingPathComponent:name])



#define FILEFOLDERPATH(fileFolderName) ([[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES) lastObject] stringByAppendingPathComponent:fileFolderName])

//#define FILEPATH(name) ([FILEFOLDERPATH stringByAppendingPathComponent:name])

@implementation BMDownloadManager
{
    NSQueue *_queueTranfer;
    NSInteger _maxDownloadThread;
    NSInteger _tryDownloadTimes;
    NSString *_filefloderPath;
    
    NSMutableDictionary *_dicDownloadFileInfo;
    NSMutableArray *_aryFinishedDownloadFileInfo;
}
DEF_SINGLETON(BMDownloadManager)



-(id)init
{
    self = [super init];
    if (self) {
        [self initData];
    }
    return self;
}

-(void)deleteQueueTask:(id)task
{
    [_queueTranfer deleteObj:task];
     _intDownloadThreadCount--;
}



-(void)initData
{
    _dicDownloadRequestOperation = [NSMutableDictionary new];
    _queueTranfer=[[NSQueue alloc]init];
    _dicDownloadFileInfo = [NSMutableDictionary new];
    _aryFinishedDownloadFileInfo= [NSMutableArray new];
   
    BOOL isDir = NO;
    NSFileManager *fileManager=[NSFileManager defaultManager];
    
    //下载文件目录
    _filefloderPath = FILEFOLDERPATH(@"DownloadFloder");
    
    BOOL existed = [fileManager fileExistsAtPath:_filefloderPath isDirectory:&isDir];
    if ( !(isDir == YES && existed == YES) )
    {
        [fileManager createDirectoryAtPath:_filefloderPath withIntermediateDirectories:YES attributes:nil error:nil];
    }

    /**
     * 初始化下载线程数目
     */
    _maxDownloadThread = 3;
    _tryDownloadTimes = 10;
}


-(BOOL)isBreakError:(NSError*)error
{
    BOOL bRet=NO;
    switch (error.code) {
        case -999:
            bRet=YES;
            break;
            
        default:
            break;
    }
    return bRet;
}





-(void)startDownload:(BMDownloadFileInfo*)downloadfileinfo
{
    
    NSString *strSourceUrl = downloadfileinfo.sourceUrlString;
    AFDownloadRequestOperation *operation=nil;
    if (![self canStarDownload]) {
        return;
    }
    downloadfileinfo.tryBeginTaskTimes = [NSNumber numberWithInt:0];
    if ([[_dicDownloadRequestOperation allKeys]containsObject:strSourceUrl])
    {
        operation = [_dicDownloadRequestOperation objectForKey:strSourceUrl];
        [operation resume];
    }
    else
    {
        BMBaseParam *bareparam=[BMBaseParam new];
        bareparam.paramObject = downloadfileinfo;
        [self downloadFileInfoWithBaseParam:bareparam];
    }
    
}

-(BOOL)canStarDownload
{
    BOOL bret=NO;
    bret=_intDownloadThreadCount < _maxDownloadThread;
    return bret;
}

-(void)pauseDownload:(BMDownloadFileInfo*)downloadfileinfo
{
    NSString *strSourceUrl = downloadfileinfo.sourceUrlString;
    AFDownloadRequestOperation *operation=nil;
    if ([[_dicDownloadRequestOperation allKeys]containsObject:strSourceUrl]) {
        operation = [_dicDownloadRequestOperation objectForKey:strSourceUrl];
        if (operation) {
                    [operation pause];
            _intDownloadThreadCount--;
            downloadfileinfo.downloadType=[NSNumber numberWithInt: PAUSE];
            
            if ([_queueTranfer count]>0) {
                [self startDownload:[_queueTranfer dequeue]];
            }

            
        }

        
    }

}




-(void)deleteDownloadTask:(BMDownloadFileInfo*)downloadfileinfo withDeleteFile:(BOOL)isDelete
{
    [self deleteDownloadTask:downloadfileinfo ];
    if (isDelete) {
        NSFileManager *filemanager=[NSFileManager defaultManager];

        
        

        if ([filemanager fileExistsAtPath:downloadfileinfo.localPath])
        {
            [filemanager removeItemAtPath:downloadfileinfo.localPath error:nil];
            //        return;
        }
    }
    
    
}

-(void)deleteDownloadTask:(BMDownloadFileInfo*)downloadfileinfo
{
    NSString *strSourceUrl = downloadfileinfo.sourceUrlString;
    AFDownloadRequestOperation *operation=nil;
    if ([[_dicDownloadRequestOperation allKeys]containsObject:strSourceUrl]) {
        operation = [_dicDownloadRequestOperation objectForKey:strSourceUrl];
        if (operation) {

            if ([operation isExecuting])
            {
                if ([downloadfileinfo.downloadType intValue]!=PAUSE) {
                    _intDownloadThreadCount--;
                }

                [operation cancel];
                
                if ([_queueTranfer count]>0) {
                    [self startDownload:[_queueTranfer dequeue]];
                }

            };
            [_dicDownloadRequestOperation removeObjectForKey:downloadfileinfo.sourceUrlString];
        }
    }
    
    if ([[_dicDownloadFileInfo allKeys] containsObject:downloadfileinfo.sourceUrlString]) {
        [_dicDownloadFileInfo  removeObjectForKey:downloadfileinfo.sourceUrlString];
    }
}




-(void)addDownloadRequestOperationDic:(AFDownloadRequestOperation*)operation
                                  key:(NSString*)strKey
{
    [_dicDownloadRequestOperation setObject:operation forKey:strKey];
}

-(NSString*)getStoreFileName:(BMDownloadFileInfo*)downloadfileinfo
{
    NSString *strRet;
    NSURL *url = [NSURL URLWithString:downloadfileinfo.sourceUrlString];
    NSString* strRelativePath=[url relativePath];
    
    NSString* strName=downloadfileinfo.name;
    NSString *strTargetPath;
    NSFileManager *filemanager=[NSFileManager defaultManager];
    int index=2;
    
    while (1)
    {
        strTargetPath = [NSString stringWithFormat:@"%@.%@",strName,[strRelativePath pathExtension]];
        strTargetPath = [_filefloderPath stringByAppendingString:strTargetPath];
        
//        [musicfolderPath stringByAppendingPathComponent:name])
        if([filemanager fileExistsAtPath:strTargetPath])
        {
            strName=[NSString stringWithFormat:@"%@%d",downloadfileinfo.name,index++];
            
        }
        else
        {
            downloadfileinfo.name=strName;
            downloadfileinfo.localPath=strTargetPath;
            break;
        }
        
        
    }
    
    
    
    
    
    strRet=strTargetPath;
    return strRet;
}


-(void)downloadFileInfoWithBaseParam:(BMBaseParam*)baseparam
{
    BMDownloadFileInfo* downloadfileinfo=nil;

    //id obj = someInstance;
    if ([baseparam.paramObject isKindOfClass:[BMDownloadFileInfo class]])
    {
        downloadfileinfo=(BMDownloadFileInfo*)baseparam.paramObject;
        if (downloadfileinfo.sourceUrlString==nil ||
            [downloadfileinfo.sourceUrlString length]==0)
        {
            return;
        }
        if (![[_dicDownloadFileInfo allKeys] containsObject:downloadfileinfo.sourceUrlString])
        {
            [_dicDownloadFileInfo setObject:downloadfileinfo forKey:downloadfileinfo.sourceUrlString];
        }
    }
    else
    {
        //传入参数不正确返回哦
        return;
    }
    downloadfileinfo.downloadType = [NSNumber numberWithInt:READY];
    if (_intDownloadThreadCount>=_maxDownloadThread)
    {
        //加入缓冲队列
        [_queueTranfer enqueue:downloadfileinfo];
        return;
    }
    else
    {
        _intDownloadThreadCount++;
        
    }
    
    NSString *urlStr = downloadfileinfo.sourceUrlString;
    
    NSURL *url = [NSURL URLWithString:urlStr];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:3600];
    
    NSString *strTargetPath = [self getStoreFileName:downloadfileinfo];
    AFDownloadRequestOperation *operation = [[AFDownloadRequestOperation alloc] initWithRequest:request targetPath:strTargetPath shouldResume:YES];
    
    
    [self addDownloadRequestOperationDic:operation key:downloadfileinfo.sourceUrlString];
    
    __weak BMDownloadManager *weakSelf = self;
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         
         
         [_dicDownloadRequestOperation removeObjectForKey:downloadfileinfo.sourceUrlString];
         downloadfileinfo.downloadType = [NSNumber numberWithInt:ENDTRANSFER];
         downloadfileinfo.localPath=strTargetPath;
         
         
         [_dicDownloadFileInfo removeObjectForKey:downloadfileinfo.sourceUrlString];
         [_aryFinishedDownloadFileInfo addObject:downloadfileinfo];
//         [musicentity MR_deleteEntity];
//         [weakSelf FinishedFileEntityWithMusicEntity:musicentity];
         
         
         _intDownloadThreadCount--;
         
         if ([_queueTranfer count]>0) {
             [weakSelf startDownload:[_queueTranfer dequeue]];
         }
         
         baseparam.isFinished = YES;
         NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
         [notificationCenter postNotificationName:DEF_NOTIFICATION_DOWNLOADFILE object:baseparam];
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         
         NSLog(@"Error: %@", error);
         
         if ([weakSelf isBreakError:error]) {
             return;
         }
         _intDownloadThreadCount--;
         if (downloadfileinfo.sourceUrlString.length) {
             [_dicDownloadRequestOperation removeObjectForKey:downloadfileinfo.sourceUrlString];
         }
         
         
         int inttryBeginTask=[downloadfileinfo.tryBeginTaskTimes intValue];
         
         if (inttryBeginTask<_tryDownloadTimes)
         {
             downloadfileinfo.tryBeginTaskTimes = [NSNumber numberWithInt:++inttryBeginTask];
             BMBaseParam *bareparam2=[BMBaseParam new];
             bareparam2.paramObject = downloadfileinfo;
             [weakSelf performSelector:@selector(downloadFileInfoWithBaseParam:) withObject:bareparam2 afterDelay:15.0f];
         }
         else
         {
             downloadfileinfo.downloadType = [NSNumber numberWithInt: PAUSE];
             //开启新的任务
             if ([_queueTranfer count]>0) {
                 [weakSelf startDownload:[_queueTranfer dequeue]];
             }
         }
         baseparam.isFinished = NO;
//         if(baseparam.withresultobjectblock)
//         {
//             baseparam.withresultobjectblock(0,error,[NSNumber numberWithBool:YES]);
//         }
         NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
         [notificationCenter postNotificationName:DEF_NOTIFICATION_DOWNLOADFILE object:baseparam];
         
     }];
    
    [operation setProgressiveDownloadProgressBlock:^(AFDownloadRequestOperation *operation, NSInteger bytesRead, long long totalBytesRead, long long totalBytesExpected, long long totalBytesReadForFile, long long totalBytesExpectedToReadForFile)
     {
         
         NSTimeInterval interval;
         long long speed=0;
         if (downloadfileinfo.modifyDate==nil)
         {
             downloadfileinfo.modifyDate=[NSDate date];
             downloadfileinfo.curSize=[NSNumber numberWithLongLong:totalBytesReadForFile];
             downloadfileinfo.fileSize=[NSNumber numberWithLongLong:totalBytesExpectedToReadForFile];
             //     long long ddd=(long long)speed;
             downloadfileinfo.downloadType=[NSNumber numberWithInt:EXECUTING];
         }
         else
         {
             
             NSDate *preDate = downloadfileinfo.modifyDate;
             interval = -[preDate timeIntervalSinceNow];
             
         }
         
         if (interval>0.5 )
         {
             long long offsetOfPreUploading=[downloadfileinfo.curSize longLongValue];
             
             double speed = (totalBytesReadForFile-offsetOfPreUploading)/interval;
             
             
             
             downloadfileinfo.curSize=[NSNumber numberWithLongLong:totalBytesReadForFile];
             downloadfileinfo.fileSize=[NSNumber numberWithLongLong:totalBytesExpectedToReadForFile];
             //     long long ddd=(long long)speed;
             downloadfileinfo.modifyDate=[NSDate date];
             long long longSpeed=(long long)speed;
             downloadfileinfo.speed=[NSNumber numberWithLongLong:longSpeed];
             downloadfileinfo.downloadType=[NSNumber numberWithInt:EXECUTING];
             
         }
         
//        float percentDone = totalBytesReadForFile/(float)totalBytesExpectedToReadForFile;
         
//         if(baseparam.withresultobjectblock)
//         {
//             baseparam.withresultobjectblock(0,nil,nil);
//         }
         
         
         NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
         [notificationCenter postNotificationName:DEF_NOTIFICATION_DOWNLOADFILE object:baseparam];

         NSLog(@"--------------%lld",[downloadfileinfo.curSize longLongValue]);
         
     }];
    [operation start];

}


-(void)downloadFileWithBaseParam:(BMBaseParam*)baseparam
{
    
    
    NSString *urlStr = [baseparam.paramDic objectForKey:DEF_UTIL_SOURCEURL];
    NSString *folderName=[baseparam.paramDic objectForKey:DEF_UTIL_FOLDERNAME];
    NSString *fileName=[baseparam.paramDic objectForKey:DEF_UTIL_FILENAME];
    
    
    NSURL *url = [NSURL URLWithString:urlStr];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:3600];
    
    
    NSFileManager *fileManager=[NSFileManager defaultManager];
    
    //创建文件夹
    folderName=[DocumentsDir stringByAppendingPathComponent:folderName];
    BOOL isDir = NO;
    
    BOOL existed = [fileManager fileExistsAtPath:folderName isDirectory:&isDir];
    if ( !(isDir == YES && existed == YES) )
    {
        [fileManager createDirectoryAtPath:folderName withIntermediateDirectories:YES attributes:nil error:nil];
    }
    NSString *strTargetPath =[folderName stringByAppendingPathComponent:fileName];
    
    
    //  每次都重新下载
    if ([fileManager fileExistsAtPath:strTargetPath])
    {
        [fileManager removeItemAtPath:strTargetPath error:nil];
        //        return;
    }
    
    AFDownloadRequestOperation *operation = [[AFDownloadRequestOperation alloc] initWithRequest:request targetPath:strTargetPath shouldResume:YES];
    
    
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         
         if (baseparam.baseblock) {
             baseparam.baseblock(0, nil);
         }
         
         // NSLog(@"Successfully downloaded file to %@", MUSICFile);
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         //_intDownloadThreadCount--;
         NSLog(@"Error: %@", error);
         if (baseparam.baseblock) {
             baseparam.baseblock(0, error);
         }
         
         
     }];
    
    [operation setProgressiveDownloadProgressBlock:^(AFDownloadRequestOperation *operation, NSInteger bytesRead, long long totalBytesRead, long long totalBytesExpected, long long totalBytesReadForFile, long long totalBytesExpectedToReadForFile)
     {
         
         
         
         
     }];
    [operation start];
    
}



@end
