//
//  NSData+Ext.m
//  PuzzleGame
//
//  Created by fx on 14/12/30.
//  Copyright (c) 2014年 FS. All rights reserved.
//

#import "NSData+Ext.h"
#import <CommonCrypto/CommonDigest.h>
@implementation NSData (Ext)
-(NSString*)md5
{
    unsigned char result[16];
    CC_MD5(self.bytes, self.length, result ); // This is the md5 call
    
    // CC_MD5((__bridge const void *)(self), self.length, result);
    
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}

@end
