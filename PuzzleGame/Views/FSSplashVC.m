//
//  FSSplashVC.m
//  MucixDown
//
//  Created by Dong Yiming on 6/7/14.
//  Copyright (c) 2014 FS. All rights reserved.
//
#import "UIView+FLKAutoLayout.h"
#import "FSSplashVC.h"
#import "PuzzleGame-Swift.h"
#import "CommonUtil.h"

@interface FSSplashVC () {
    UIImageView  *_ivSplash;
    UILabel      *_label;
    UIViewController *_mainController;
}

@end

@implementation FSSplashVC


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    _ivSplash = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg"]];
    _ivSplash.contentMode = UIViewContentModeScaleAspectFit;
    _ivSplash.alpha = 0;
    [self.view addSubview:_ivSplash];
    [_ivSplash alignToView:self.view];
    
    UIToolbar *mask = [[UIToolbar alloc] init];
    mask.barStyle = UIBarStyleBlack;
    //mask.barTintColor = [UIColor colorWithWhite:.3f alpha:.5f];
    [self.view addSubview:mask];
    [mask alignToView:self.view];
    
    _label = [UILabel new];
    NSString *string = PGLocalString(@"welcome");
    _label.text = string;
    _label.textColor = [UIColor whiteColor];
    _label.font = [UIFont systemFontOfSize:12.f];
    [self.view addSubview:_label];
    [_label alignCenterWithView:self.view];
    
    [UIView animateWithDuration:.5f animations:^{
        _ivSplash.alpha = 1.f;
    }];
    
    
    [self hide:^(BOOL finished) {
//        _mainController = [MainController new];

        
        
        UIStoryboard * storyBoard;
//        UIViewController *vc;
        //获得UITabBarController
//        tb = self.tabBarController;
//        viewControllers =[[NSMutableArray alloc] initWithArray: tb.viewControllers];
        storyBoard  = [UIStoryboard
                       storyboardWithName:@"Main" bundle:nil];
        
        _mainController = [storyBoard instantiateViewControllerWithIdentifier:@"MainNav"];
        
        [UIApplication sharedApplication].keyWindow.rootViewController = _mainController;
        
        [CommonUtil giveMeRate];
    }];
    
}

-(void)hide:(void (^)(BOOL finished))aCompletion {
    
    _ivSplash.alpha = 1.f;
    [UIView animateWithDuration:.5f animations:^{
        _ivSplash.alpha = 0.f;
    } completion:^(BOOL finished) {
        if (aCompletion) {
            aCompletion(finished);
        }
       
        
    }];
}


@end
