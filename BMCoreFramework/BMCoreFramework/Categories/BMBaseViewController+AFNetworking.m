//
//  BMBaseViewController+AFNetworking.m
//  BMUtilFramework
//
//  Created by fx on 14-8-19.
//  Copyright (c) 2014年 bluemobi. All rights reserved.
//

#import "BMBaseViewController+AFNetworking.h"

#import "SVPullToRefresh.h"
@implementation BMBaseViewController (AFNetworking)




-(void)addPullToTopRefresh:(UIScrollView*)scrollview
{
    __weak BMBaseViewController *weakSelf = self;
    __weak UIScrollView *weakScrollview = scrollview;
    
    int64_t delayInSeconds = 1.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [weakScrollview addPullToRefreshWithActionHandler:^{
            [weakSelf insertRowAtTop];
        }];
        
    });
}

-(void)addPullToBottomRefresh:(UIScrollView*)scrollview
{
    __weak BMBaseViewController *weakSelf = self;
    __weak UIScrollView *weakScrollview = scrollview;
    
    int64_t delayInSeconds = 1.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        
        // setup infinite scrolling
        [weakScrollview addInfiniteScrollingWithActionHandler:^{
            [weakSelf insertRowAtBottom];
        }];
        
    });
}


-(void)addPullToRefresh:(UIScrollView*)scrollview
{
    
    
    // setup pull-to-refresh
    
    __weak BMBaseViewController *weakSelf = self;
    __weak UIScrollView *weakScrollview = scrollview;
    
    int64_t delayInSeconds = 1.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [weakScrollview addPullToRefreshWithActionHandler:^{
            [weakSelf insertRowAtTop];
        }];
        
        // setup infinite scrolling
        [weakScrollview addInfiniteScrollingWithActionHandler:^{
            [weakSelf insertRowAtBottom];
        }];
        
    });
}

-(void)endPullToRefresh:(UIScrollView*)scrollview
{
    //    scrollview.originalTopInset=44;
    [scrollview.pullToRefreshView stopAnimating];
    [scrollview.infiniteScrollingView stopAnimating];
}


/**
 *  下拉刷新的回调
 */
-(void)insertRowAtTop
{
    
}
/**
 *  上拉刷新的回调
 */
-(void)insertRowAtBottom
{
    
}

@end
