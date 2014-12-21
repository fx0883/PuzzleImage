//
//  FSSplashVC.h
//  MucixDown
//
//  Created by Dong Yiming on 6/7/14.
//  Copyright (c) 2014 FS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FSSplashVC : UIViewController
-(void)hide:(void (^)(BOOL finished))aCompletion;
@end
