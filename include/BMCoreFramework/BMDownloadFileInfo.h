/*!
 @header BMDownloadFileInfo
 @abstract BMDownloadFileInfo 简单实体类
 @author FS (作者信息)
 @version 1.00 2014/10/12 Creation (此文档的版本信息)
 */
#import <Foundation/Foundation.h>

/*!
 @class
 @abstract 用于下载的简单实体类
 */
@interface BMDownloadFileInfo : NSObject

@property (nonatomic, retain) NSString * id;
@property (nonatomic, retain) NSNumber * curSize;
@property (nonatomic, retain) NSDate * curTime;
@property (nonatomic, retain) NSNumber * downloadType;
@property (nonatomic, retain) NSString * duration;

@property (nonatomic, retain) NSNumber * fileSize;
@property (nonatomic, retain) NSString * imageURLString;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * sourceUrlString;

@property (nonatomic, retain) NSNumber * speed;
@property (nonatomic, retain) NSNumber * tryBeginTaskTimes;
@property (nonatomic, retain) NSDate * modifyDate;
@property (nonatomic, retain) NSString * localFolderPath;
@property (nonatomic, retain) NSString * localPath;
@end
