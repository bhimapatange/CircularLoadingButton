//
//  BKCircularLoadingButton.h
//  BKCircularLoadingButton
//
//  Created by Bhima on 14/03/19.
//  Copyright © 2019 Bhima Patange. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
IB_DESIGNABLE
@interface BKCircularLoadingButton : UIButton
-(void)startAnimation;
-(void)stopAnimation;

@property (nonatomic, assign) IBInspectable CGFloat borderWidth;
/**
 The color of the bar border. Default is black.
 */
@property (nonatomic, copy)   IBInspectable UIColor *borderColor;
@property (nonatomic) IBInspectable CGFloat cornerRadius;
@property (nonatomic, copy)   IBInspectable UIColor *circleColor;
@property (nonatomic) IBInspectable CGFloat circleHeightPercent;
@property (nonatomic, copy)   IBInspectable NSString *originalTitle;
@property (nonatomic) IBInspectable CGFloat widthPercentWhenLoading;
+(instancetype)buttonWithFrame:(CGRect)frame;
@end

NS_ASSUME_NONNULL_END
