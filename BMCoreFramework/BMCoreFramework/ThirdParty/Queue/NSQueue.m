//
//  NSQueue.m
//  MucixDown
//
//  Created by fx on 14-5-22.
//  Copyright (c) 2014年 FS. All rights reserved.
//

#import "NSQueue.h"


@implementation NSQueue

- (id)init
{
    if( self=[super init] )
    {
        m_array = [[NSMutableArray alloc] init];
        _count = 0;
    }
    return self;
}
- (void)dealloc {
    
    //[self dealloc]; --递你妹的归啊

}

-(void)deleteObj:(id)anObject
{
    [m_array removeObject:anObject];
    _count = m_array.count;
}
- (void)enqueue:(id)anObject
{
    [m_array addObject:anObject];
    _count = m_array.count;
}
- (id)dequeue
{
    id obj = nil;
    if(m_array.count > 0)
    {
        obj = [m_array objectAtIndex:0];
        [m_array removeObjectAtIndex:0];
        _count = m_array.count;
    }
    return obj;
}
- (void)clear
{
    [m_array removeAllObjects];
    _count = 0;
}
@end
