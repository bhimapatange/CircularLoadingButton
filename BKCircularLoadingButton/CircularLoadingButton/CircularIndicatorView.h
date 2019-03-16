//  Created by Bhima on 14/03/19.

#import <UIKit/UIKit.h>

@interface CircularIndicatorView : UIView

+(instancetype)viewWithButton:(UIButton *)button heightPercent:(CGFloat)percent circleColor:(UIColor *)circle_color;

@property (nonatomic, assign) BOOL isAnimating;
@property (nonatomic, assign) BOOL hidesWhenStopped;

- (void)startAnimating;
- (void)stopAnimating;

@end
