//
//  UIView+Effect.m
//  babylon
//
//  Created by fx on 2/24/14.
//  Copyright (c) 2014 FS. All rights reserved.
//

#import "UIView+Effect.h"


@implementation UIView (Effect)

-(void)applyEffectCircleSilverBorder:(UIColor*) color
{
    self.layer.cornerRadius = self.frame.size.width / 2;
    self.layer.borderColor = color.CGColor;
    self.layer.borderWidth = 1.f;
    self.layer.masksToBounds = YES;
}

-(void)applyEffectRoundRectSilverBorder:(UIColor*) color
{
    self.layer.cornerRadius = 5;
    self.layer.borderColor = color.CGColor;
    self.layer.borderWidth = 1;
    self.layer.masksToBounds = YES;
}





-(void)applyEffectRoundRect
{
    self.layer.cornerRadius = 5;
    self.layer.borderColor = self.backgroundColor.CGColor;
    self.layer.borderWidth = 1;
    self.layer.masksToBounds = YES;
    self.layer.shadowColor=[UIColor clearColor].CGColor;

}

-(void)applyEffectRoundRectShadow:(UIColor*) color
{
    self.layer.cornerRadius = 8;
    self.layer.shadowColor = color.CGColor;
    self.layer.shadowOffset = CGSizeMake(2, 2);
    self.layer.shadowRadius = 4;
    self.layer.shadowOpacity = .1f;
    self.layer.masksToBounds = NO;
}

-(void)applyEffectShadowAndBorder
{
    self.layer.borderColor = [UIColor grayColor].CGColor;
    self.layer.borderWidth = 1;
    
    self.layer.shadowColor =  [UIColor lightGrayColor].CGColor;
    self.layer.shadowOpacity = .3f;
    self.layer.shadowOffset = CGSizeMake(0, 1);
    self.layer.shadowRadius = 1;
    self.layer.cornerRadius = 0.f;
}

-(void)applyEffectRoundRectGray
{
    self.layer.cornerRadius = 6;
    self.layer.masksToBounds = YES;
   
}


-(void)applyEffectRoundRectNoBorder
{
    self.layer.cornerRadius = 6;
    self.layer.borderColor = [UIColor clearColor].CGColor;
    self.layer.borderWidth = 0;
    self.layer.masksToBounds = YES;
    self.layer.shadowColor=[UIColor clearColor].CGColor;
}
@end
