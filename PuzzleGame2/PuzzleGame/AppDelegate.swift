//
//  AppDelegate.swift
//  PuzzleGame
//
//  Created by fx on 14-10-10.
//  Copyright (c) 2014年 FS. All rights reserved.
//

import UIKit
let kPuzzleDBName:String = "PuzzleImageDb.sqlite"
let COREBUNDLENAME:String = "CoreBundle"

//用户文件夹id
let CUSTOMFOLDERID:String = "CUSTOMFOLDERID"

let CustomFolderPath:String = NSString(format: "%@/%@", BMSandbox.sharedInstance().docPath,"CUSTOMFOLDERID");

//let CustomFolderPathImage:String = "customFolder"

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, handleOpenURL url: NSURL) -> Bool {
        return ShareSDK.handleOpenURL(url, wxDelegate: self);
    }
    
    func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject?) -> Bool {
        return ShareSDK.handleOpenURL(url, sourceApplication: sourceApplication, annotation: annotation, wxDelegate: self);
    }

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
//        [self copyDefaultStoreIfNecessary];
//        [MagicalRecord setLoggingLevel:MagicalRecordLoggingLevelVerbose];
//        [MagicalRecord setupCoreDataStackWithStoreNamed:kRecipesStoreName];
        self.copyDefaultStoreIfNecessary()
 //       MagicalRecord.setLoggingLevel(MagicalRecordLoggingLevel.Verbose)
        MagicalRecord.setupCoreDataStackWithStoreNamed(kPuzzleDBName)
        
        self.loadData()
        
        UIApplication.sharedApplication().setStatusBarStyle(UIStatusBarStyle.LightContent, animated: false)
        
//        AdmobManager.sharedInstance();
        
//        CommonUtil.giveMeRate()
        
//        ShareSDK.registerApp(ShareSdkAppKey);
//            [ShareSDK registerApp:@"api20"];
        ShareSDKManager.sharedInstance().registSDKkey();
        
        return true
    }
    
    func loadUIACPReminder()
    {

        let localNotifications:ACPReminder = ACPReminder.sharedManager()
        let strExample1:String =  NSLocalizedString("The difference between ordinary and extraordinary is that little extra.", comment: "")
                let strExample2:String =  NSLocalizedString("People who cannot find time for recreation are obliged sooner or later to find time for illness.", comment: "")
                let strExample3:String =  NSLocalizedString("It is better to have loved and lost than never to have loved at all.", comment: "")
                let strExample4:String =  NSLocalizedString("It doesn't matter what others think of you. It only matters what you think of yourself.", comment: "")
                let strExample5:String =  NSLocalizedString("Success, it is not the position where you are standing, but which direction you are going.", comment: "")
        
        
        localNotifications.messages = [strExample1, strExample2,strExample3, strExample4, strExample5]
        localNotifications.timePeriods = [(10)]//[(1),(2),(3),(4),(5),(6),(7),(8),(9),(10),(11),(12),(13),(14),(15),(16),(17),(18),(19),(20),(21),(22),(23),(24),(25),(26),(27),(28)]
        
           //     localNotifications.timePeriods = [(1)]

        localNotifications.appDomain = "com.CrazyPuzzle.app2"
        localNotifications.randomMessage = true //By default is NO (optional)
        localNotifications.testFlagInSeconds = true //By default is NO (optional) --> For testing purpose only!
        localNotifications.circularTimePeriod = true // By default is NO (optional)
        //
        //        [localNotifications createLocalNotification];
        localNotifications.createLocalNotification()
        
    }
    
    func loadData()
    {
        
        
        let bundlePath:NSString? = NSBundle.mainBundle().pathForResource(COREBUNDLENAME, ofType: "bundle")
        
        
        let bundle:NSBundle? = NSBundle(path:bundlePath!)
        BMContext.sharedInstance().setContextDic(bundlePath, forKey: COREBUNDLENAME)
        let ary:NSArray = ImageCategory.MR_findAll()
        let intCount:Int = ary.count
        if(intCount > 0)
        {
            return
        }
        
        let aryImageCategory:NSArray = bundle!.pathsForResourcesOfType("", inDirectory: "ImageCategory") as NSArray
        
        for imageCategoryitem in aryImageCategory
        {
            let item:ImageCategory = ImageCategory.MR_createEntity()
            item.name=imageCategoryitem as NSString;
            item.id = NSUUID().UUIDString;
            
            item.name = item.name.lastPathComponent
            
            let strSubDirctory:String = "ImageCategory/"+item.name
            
            println("\(strSubDirctory)")
            
            let aryImageInfo:NSArray = bundle!.pathsForResourcesOfType("jpg", inDirectory: strSubDirctory) as NSArray
            
            for imageInfoitem in aryImageInfo
            {
                let itemImageInfo:ImageInfo = ImageInfo.MR_createEntity()
                itemImageInfo.id = NSUUID().UUIDString;
                itemImageInfo.categoryid = item.id
                itemImageInfo.fastesttime=nil
                
                var strPath:NSString = imageInfoitem as NSString
                
                itemImageInfo.path = strPath
                itemImageInfo.isfinished = NSNumber(bool: false)
                
                
                strPath = strPath.lastPathComponent
//                println("\(itemImageInfo.path)")
                
                itemImageInfo.path = strSubDirctory+"/"+strPath
                
                println("\(itemImageInfo.path)")
            }
            
        }
        
        loadCustomPic()
        
        NSManagedObjectContext.MR_defaultContext().MR_saveToPersistentStoreAndWait()
        

    }
    
    //add custom Pic
    func loadCustomPic()
    {
        let item:ImageCategory = ImageCategory.MR_createEntity()
        item.name="我的图片"
        item.id = CUSTOMFOLDERID
        item.imagepath = "customFolder"
        let strDocPath:String = BMSandbox.sharedInstance().docPath
        
//        NSFileManager *fileManager = [NSFileManager defaultManager];
//        NSError *error = nil;
//        NSArray *fileList = [[NSArray alloc] init];
//        //fileList便是包含有该文件夹下所有文件的文件名及文件夹名的数组
//        fileList = [fileManager contentsOfDirectoryAtPath:[self imageSavedPath:nil] error:&error];
//        NSLog(@"路径==%@,fileList%@",[self imageSavedPath:nil],fileList);
        
        

        var isDir:ObjCBool = false;
        let existed:Bool = NSFileManager.defaultManager().fileExistsAtPath(CustomFolderPath, isDirectory: &isDir);
        
        if(!(isDir.boolValue==true&&existed==true))
        {
            NSFileManager.defaultManager().createDirectoryAtPath(CustomFolderPath, withIntermediateDirectories: true, attributes: nil, error: nil);
        }
        
        
        //        NSFileManager *fileManager = [NSFileManager defaultManager];
//        BOOL existed = [fileManager fileExistsAtPath:imageDir isDirectory:&isDir];
//        if ( !(isDir == YES && existed == YES) )
//        {
//            [fileManager createDirectoryAtPath:imageDir withIntermediateDirectories:YES attributes:nil error:nil];
//        }

    }
    
    
    
    
    
    func copyDefaultStoreIfNecessary()
    {
        let fileManager:NSFileManager = NSFileManager.defaultManager()
        //
        //    NSURL *storeURL = [NSPersistentStore MR_urlForStoreName:kRecipesStoreName];
        
        let storeURL:NSURL = NSPersistentStore.MR_urlForStoreName(kPuzzleDBName)
        
        if(!fileManager.fileExistsAtPath(storeURL.path!))
        {
            let defaultStorePath:NSString? = NSBundle.mainBundle().pathForResource(kPuzzleDBName.stringByDeletingPathExtension, ofType: kPuzzleDBName.pathExtension)
            
            if(defaultStorePath  != nil)
            {
                var error:NSErrorPointer? = nil
                let success:Bool = fileManager.copyItemAtPath(defaultStorePath!, toPath: storeURL.path!, error: error!)
                
                if(!success)
                {
                    println("Failed to install default recipe store")
                }
                
            }
            
        }
        //
        //    // If the expected store doesn't exist, copy the default store.
        //    if (![fileManager fileExistsAtPath:[storeURL path]])
        //    {
        //    NSString *defaultStorePath = [[NSBundle mainBundle] pathForResource:[kRecipesStoreName stringByDeletingPathExtension] ofType:[kRecipesStoreName pathExtension]];
        //
        //    if (defaultStorePath)
        //    {
        //    NSError *error;
        //    BOOL success = [fileManager copyItemAtPath:defaultStorePath toPath:[storeURL path] error:&error];
        //    if (!success)
        //    {
        //    NSLog(@"Failed to install default recipe store");
        //    }
        //    }
        //    }
    }
    
//    - (void) copyDefaultStoreIfNecessary;
//    {
//    NSFileManager *fileManager = [NSFileManager defaultManager];
//    
//    NSURL *storeURL = [NSPersistentStore MR_urlForStoreName:kRecipesStoreName];
//    
//    // If the expected store doesn't exist, copy the default store.
//    if (![fileManager fileExistsAtPath:[storeURL path]])
//    {
//    NSString *defaultStorePath = [[NSBundle mainBundle] pathForResource:[kRecipesStoreName stringByDeletingPathExtension] ofType:[kRecipesStoreName pathExtension]];
//    
//    if (defaultStorePath)
//    {
//    NSError *error;
//    BOOL success = [fileManager copyItemAtPath:defaultStorePath toPath:[storeURL path] error:&error];
//    if (!success)
//    {
//    NSLog(@"Failed to install default recipe store");
//    }
//    }
//    }
//    
//    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        self.loadUIACPReminder()
        NSManagedObjectContext.MR_defaultContext().MR_saveToPersistentStoreAndWait()
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
        
        Appirater.appEnteredForeground(true)
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        
        
//        [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
//        [[ACPReminder sharedManager] checkIfLocalNotificationHasBeenTriggered];

        
        UIApplication.sharedApplication().applicationIconBadgeNumber = 0
        ACPReminder.sharedManager().checkIfLocalNotificationHasBeenTriggered()
        
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    
    
//    (BOOL)application:(UIApplication *)application
//    openURL:(NSURL *)url
//    sourceApplication:(NSString *)sourceApplication
//    annotation:(id)annotation
//    {
//    return [ShareSDK handleOpenURL:url
//    sourceApplication:sourceApplication
//    annotation:annotation
//    wxDelegate:self];
//    
//    }
    
    
//    func appl
    
    
//    func giveMeRate()
//    {
//    Appirater.setAppId("909949742")
//    Appirater.setDaysUntilPrompt(5)
//    Appirater.setUsesUntilPrompt(0)
//    Appirater.setSignificantEventsUntilPrompt(-1)
//    Appirater.setTimeBeforeReminding(2)
//    Appirater.setDebug(true)
//    }


}

