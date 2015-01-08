//
//  ImageCategory.h
//  PuzzleGame
//
//  Created by fx on 14-10-10.
//  Copyright (c) 2014年 FS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface ImageCategory : NSManagedObject

@property (nonatomic, retain) NSString * id;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * imagepath;

@end