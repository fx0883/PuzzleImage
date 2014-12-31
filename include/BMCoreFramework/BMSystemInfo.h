/*!
 @header BMSystemInfo
 @abstract BMSystemInfo
 @author FS (作者信息)
 @version 1.00 2014/10/12 Creation (此文档的版本信息)
 */

#pragma mark -

//AS_PACKAGE( BeePackage_System, BeeSystemInfo, info );

#pragma mark -

#if (TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR)

#define IOS8_OR_LATER		( [[[UIDevice currentDevice] systemVersion] compare:@"8.0"] != NSOrderedAscending )
#define IOS7_OR_LATER		( [[[UIDevice currentDevice] systemVersion] compare:@"7.0"] != NSOrderedAscending )
#define IOS6_OR_LATER		( [[[UIDevice currentDevice] systemVersion] compare:@"6.0"] != NSOrderedAscending )
#define IOS5_OR_LATER		( [[[UIDevice currentDevice] systemVersion] compare:@"5.0"] != NSOrderedAscending )
#define IOS4_OR_LATER		( [[[UIDevice currentDevice] systemVersion] compare:@"4.0"] != NSOrderedAscending )
#define IOS3_OR_LATER		( [[[UIDevice currentDevice] systemVersion] compare:@"3.0"] != NSOrderedAscending )

#define IOS7_OR_EARLIER		( !IOS8_OR_LATER )
#define IOS6_OR_EARLIER		( !IOS7_OR_LATER )
#define IOS5_OR_EARLIER		( !IOS6_OR_LATER )
#define IOS4_OR_EARLIER		( !IOS5_OR_LATER )
#define IOS3_OR_EARLIER		( !IOS4_OR_LATER )

#define IS_SCREEN_4_INCH	([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define IS_SCREEN_35_INCH	([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)

#else	// #if (TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR)

#define IOS7_OR_LATER		(NO)
#define IOS6_OR_LATER		(NO)
#define IOS5_OR_LATER		(NO)
#define IOS4_OR_LATER		(NO)
#define IOS3_OR_LATER		(NO)

#define IS_SCREEN_4_INCH	(NO)
#define IS_SCREEN_35_INCH	(NO)

#endif	// #if (TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR)
/*!
 @class
 @abstract BMSystemInfo
 */
@interface BMSystemInfo : NSObject

AS_SINGLETON( BMSystemInfo )
/*!
 *  OSVersion
 *
 *  @return
 */
+ (NSString *)OSVersion;
/*!
 *  appVersion
 *
 *  @return
 */
+ (NSString *)appVersion;
/*!
 *  appIdentifier
 *
 *  @return
 */
+ (NSString *)appIdentifier;
/*!
 *  appSchema
 *
 *  @return
 */
+ (NSString *)appSchema;

/*!
 *  appSchema
 *
 *  @param name
 *
 *  @return
 */
+ (NSString *)appSchema:(NSString *)name;

/*!
 *  deviceModel
 *
 *  @return
 */
+ (NSString *)deviceModel;

/*!
 *  deviceUUID
 *
 *  @return
 */
+ (NSString *)deviceUUID;

/*!
 *  isJailBroken
 *
 *  @return
 */
+ (BOOL)isJailBroken		NS_AVAILABLE_IOS(4_0);

/*!
 *  jailBreaker
 *
 *  @return
 */
+ (NSString *)jailBreaker	NS_AVAILABLE_IOS(4_0);

/*!
 *  isDevicePhone
 *
 *  @return
 */
+ (BOOL)isDevicePhone;

/*!
 *  isDevicePad
 *
 *  @return
 */
+ (BOOL)isDevicePad;

/*!
 *  requiresPhoneOS
 *
 *  @return
 */
+ (BOOL)requiresPhoneOS;

/*!
 *  isPhone
 *
 *  @return
 */
+ (BOOL)isPhone;

/*!
 *  isPhone35
 *
 *  @return
 */
+ (BOOL)isPhone35;

/*!
 *  isPhoneRetina35
 *
 *  @return
 */
+ (BOOL)isPhoneRetina35;

/*!
 *  isPhoneRetina4
 *
 *  @return
 */
+ (BOOL)isPhoneRetina4;

/*!
 *  isPad
 *
 *  @return
 */
+ (BOOL)isPad;

/*!
 *  isPadRetina
 *
 *  @return
 */
+ (BOOL)isPadRetina;

/*!
 *  isScreenSize
 *
 *  @param size
 *
 *  @return
 */
+ (BOOL)isScreenSize:(CGSize)size;

@end
