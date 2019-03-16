//
//  BKCircularLoadingButton.m
//  BKCircularLoadingButton
//
//  Created by Bhima on 14/03/19.
//  Copyright © 2019 Bhima Patange. All rights reserved.
//

#import "BKCircularLoadingButton.h"
#import "CircularIndicatorView.h"

@interface BKCircularLoadingButton ()
@property (nonatomic, strong) CircularIndicatorView* circleView;
@property (nonatomic, assign) CGRect origionRect;
@end

@implementation BKCircularLoadingButton

- (CircularIndicatorView *)circleView
{
    if (!_circleView) {
        if(self.circleColor == nil){
            //default circle color
            self.circleColor = UIColor.blackColor;
        }
        if(_circleHeightPercent == 0){
            _circleHeightPercent = 0.7;
        }
        _circleView = [CircularIndicatorView viewWithButton:self heightPercent:self.circleHeightPercent circleColor:self.circleColor];
        [self addSubview:_circleView];
    }
    return _circleView;
}

-(void)awakeFromNib{
    [super awakeFromNib];
}
-(instancetype)initWithFrame:(CGRect)frame{
   
    if (self = [super initWithFrame:frame]) {
        self.frame = frame;
        self.layer.masksToBounds = YES;
        self.clipsToBounds = NO;
        self.origionRect = self.frame;
        self.originalTitle = self.currentTitle ;
        self.translatesAutoresizingMaskIntoConstraints = YES;
        [self updateLayerProperties];
    }
    return  self;
}
-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        self.layer.masksToBounds = YES;
        self.clipsToBounds = NO;
        self.origionRect = self.frame;
        self.originalTitle = self.currentTitle ;
        self.translatesAutoresizingMaskIntoConstraints = YES;
        [self updateLayerProperties];
    }
    return  self;
}
+(instancetype)buttonWithFrame:(CGRect)frame{
    BKCircularLoadingButton* button = [BKCircularLoadingButton buttonWithType:UIButtonTypeCustom];
    
    button.frame = frame;
    button.layer.masksToBounds = YES;
    button.clipsToBounds = NO;
    button.origionRect = button.frame;
    button.translatesAutoresizingMaskIntoConstraints = YES;
    [button updateLayerProperties];
    return button;
}
-(void)layoutSubviews {
    [super layoutSubviews];
    [self updateLayerProperties];
}
- (void)setBorderWidth:(CGFloat)borderWidth {
    if (borderWidth != _borderWidth) {
        _borderWidth = borderWidth;
        [self updateLayerProperties];
    }
}

- (void)setBorderColor:(UIColor *)borderColor {
    if (borderColor != _borderColor) {
        _borderColor = borderColor;
        [self updateLayerProperties];
    }
}
- (void)setCornerRadius:(CGFloat)cornerRadius {
    if (cornerRadius != _cornerRadius) {
        _cornerRadius = cornerRadius;
        [self updateLayerProperties];
    }
}
- (void)setOriginalTitle:(NSString*)originalTitle {
    if (originalTitle != _originalTitle) {
        _originalTitle = originalTitle;
        [self updateLayerProperties];
    }
}
- (void)setCircleColor:(UIColor *)circleColor {
    if (circleColor != _circleColor) {
        _circleColor = circleColor;
        [self updateLayerProperties];
    }
}
- (void)setCircleHeightPercent:(CGFloat)circleHeightPercent {
    if (circleHeightPercent != _circleHeightPercent) {
        _circleHeightPercent = circleHeightPercent;
    }
}
- (void)setWidthPercentWhenLoading:(CGFloat)widthPercentWhenLoading {
    if (widthPercentWhenLoading != _widthPercentWhenLoading) {
        _widthPercentWhenLoading = widthPercentWhenLoading;
    }
}
- (void)updateLayerProperties {
    
    self.layer.borderWidth = self.borderWidth;
    self.layer.borderColor = self.borderColor.CGColor;
    self.layer.cornerRadius = self.cornerRadius;
    self.layer.masksToBounds = YES;
}
-(void)startAnimation{
    CGPoint center = self.center;
    if(_widthPercentWhenLoading == 0){
        _widthPercentWhenLoading = 0.5;
    }
    CGFloat width = self.frame.size.width*_widthPercentWhenLoading;
    CGFloat height = self.frame.size.height;
    CGRect desFrame = CGRectMake(center.x - width / 2, center.y - height / 2, width, height);
    
    self.userInteractionEnabled = NO;
    
    [UIView animateWithDuration:0.3 animations:^{
       [self setTitle:@"" forState:UIControlStateNormal];
        self.frame = desFrame;
    } completion:^(BOOL finished) {

        [self.circleView startAnimating];
    }];
}

-(void)stopAnimation{
    self.userInteractionEnabled = YES;
    [self.circleView removeFromSuperview];
    self.circleView = nil;
    [UIView animateWithDuration:0.3 animations:^{
        self.frame = self.origionRect;
       
       
    } completion:^(BOOL finished) {
        [self setTitle:self.originalTitle forState:UIControlStateNormal];
    }];
    
}
@end
