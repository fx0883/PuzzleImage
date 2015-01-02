/*!
 @header UIView+Effect
 @abstract UIView Effect
 @author FS (作者信息)
 @version 1.00 2012/01/20 Creation (此文档的版本信息)
 */
#import <Foundation/Foundation.h>

/*!
 @category
 @abstract UIView Effect
 */
@interface UIView (Effect)

/*!
 *  applyEffectCircleSilverBorder
 *
 *  @param color
 */
-(void)applyEffectCircleSilverBorder:(UIColor*) color;
/*!
 *  applyEffectRoundRectSilverBorder
 *
 *  @param color
 */
-(void)applyEffectRoundRectSilverBorder:(UIColor*) color;
/*!
 *  applyEffectRoundRect
 */
-(void)applyEffectRoundRect;
/*!
 *  applyEffectRoundRectShadow
 *
 *  @param color
 */
-(void)applyEffectRoundRectShadow:(UIColor*) color;

/*!
 *  applyEffectShadowAndBorder
 */
-(void)applyEffectShadowAndBorder;

/*!
 *  applyEffectRoundRectGray
 */
-(void)applyEffectRoundRectGray;


/*!
 *  applyEffectRoundRectNoBorder
 */
-(void)applyEffectRoundRectNoBorder;


@end
