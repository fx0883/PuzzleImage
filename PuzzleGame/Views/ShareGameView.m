//
//  ShareGameView.m
//  PuzzleGame
//
//  Created by fx on 14/10/31.
//  Copyright (c) 2014年 FS. All rights reserved.
//

#import "ShareGameView.h"

//#define STRTITLE  @"过关了"

//#define STRDESCRIPTION  @"愉快地游戏"

#define STRURL @"https://itunes.apple.com/us/app/puzzle-crazy/id921615471?l=zh&ls=1&mt=8"
#import "ShareSDKManager.h"

@implementation ShareGameView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (IBAction)closeClick:(id)sender {
    [ASDepthModalViewController dismiss];
}

- (IBAction)shareButtonClick:(id)sender {
    
//        ShareSDKManager.sharedInstance()noneUIShareAllButtonClickHandler(sender,title: STRTITLE, content: self.msgContentLabel.text, description: STRDESCRIPTION, imagecontent: self.sharedImage, url: STRURL)
    NSString *strShowContent = [NSString stringWithFormat:@"%@ %@",self.msgContentLabel.text,STRURL];
    
    [[ShareSDKManager sharedInstance] noneUIShareAllButtonClickHandler:sender title:PGLocalString(@"you_did_it") content:strShowContent description:PGLocalString(@"play_happyly") imagecontent:self.sharedImage url:STRURL];
}


@end
