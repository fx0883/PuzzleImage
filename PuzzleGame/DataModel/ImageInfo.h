//
//  ImageInfo.h
//  PuzzleGame
//
//  Created by fx on 14/10/30.
//  Copyright (c) 2014年 FS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface ImageInfo : NSManagedObject

@property (nonatomic, retain) NSString * categoryid;
@property (nonatomic, retain) NSString * id;
@property (nonatomic, retain) NSNumber * isfinished;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * path;
@property (nonatomic, retain) NSNumber * fastesttime;

@end
