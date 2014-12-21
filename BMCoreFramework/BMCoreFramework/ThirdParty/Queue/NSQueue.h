//
//  NSQueue.h
//  MucixDown
//
//  Created by fx on 14-5-22.
//  Copyright (c) 2014年 FS. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface NSQueue : NSObject {
    NSMutableArray* m_array;
}
- (void)enqueue:(id)anObject;
- (id)dequeue;
- (void)clear;
-(void)deleteObj:(id)anObject;
@property (nonatomic, readonly) int count;
@end