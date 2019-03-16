
#import "CircularIndicatorView.h"

@interface CircularIndicatorView ()

@property (nonatomic, strong) CAShapeLayer *shapeLayer;
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, assign) CGFloat duration;

@end

@implementation CircularIndicatorView

+(instancetype)viewWithButton:(UIButton *)button heightPercent:(CGFloat)percent circleColor:(UIColor *)circle_color{
    
    CGFloat heightForCicle =  button.frame.size.height*percent;
    CGFloat circleX = (button.frame.size.width/2) - heightForCicle/2;
    CGFloat circleY = (button.frame.size.height/2) - heightForCicle/2;
    CGRect frame = CGRectMake( circleX, circleY, heightForCicle,heightForCicle);
    
    CircularIndicatorView* animationView = [[CircularIndicatorView alloc] initWithFrame:frame];

//    animationView.frame = CGRectMake( 4,  4, button.frame.size.width - 8, button.frame.size.height - 8);
    animationView.shapeLayer.strokeColor = [circle_color CGColor];
    return animationView;
}

-(instancetype)initWithFrame:(CGRect)frame{
    CGFloat lineWidth = 1.5;
    CGFloat duration = 0.8;
    if (self = [super initWithFrame:frame]) {
        
        self.contentView = [[UIView alloc] initWithFrame:self.bounds];
        [self addSubview:self.contentView];
        
        CGFloat radius = frame.size.width / 2;
        
        self.shapeLayer = [CAShapeLayer layer];
        self.shapeLayer.frame = self.bounds;
        self.shapeLayer.lineWidth = lineWidth;
        self.shapeLayer.fillColor = [[UIColor clearColor] CGColor];
        self.shapeLayer.path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, 2.0 * radius, 2.0 * radius) cornerRadius:radius].CGPath;
        self.shapeLayer.lineCap = kCALineCapSquare;
        self.shapeLayer.hidden = YES;
        [self.contentView.layer insertSublayer:self.shapeLayer atIndex:0];
        
        // Defaults
        self.hidesWhenStopped = YES;
        self.duration = duration;
    }
    return self;
}


- (void)startAnimating
{
    if (self.isAnimating) {
        return;
    }
    
    _isAnimating = YES;
    
    CAKeyframeAnimation *inAnimation = [CAKeyframeAnimation animationWithKeyPath:@"strokeEnd"];
    inAnimation.duration = self.duration;
    inAnimation.values = @[@(0), @(0.8)];

    CAKeyframeAnimation *outAnimation = [CAKeyframeAnimation animationWithKeyPath:@"strokeStart"];
    outAnimation.duration = self.duration;
    outAnimation.values = @[@(0), @(0.8), @(1)];
    outAnimation.beginTime = self.duration / 1.5;
    
    CAAnimationGroup *groupAnimation = [CAAnimationGroup animation];
    groupAnimation.animations = @[inAnimation, outAnimation];
    groupAnimation.duration = self.duration + outAnimation.beginTime;
    groupAnimation.repeatCount = INFINITY;
   
    CABasicAnimation *rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.fromValue = @(0);
    rotationAnimation.toValue = @(M_PI * 2);
    rotationAnimation.duration = self.duration * 1.5;
    rotationAnimation.repeatCount = INFINITY;
    
    [self.shapeLayer addAnimation:rotationAnimation forKey:nil];
    [self.shapeLayer addAnimation:groupAnimation forKey:nil];
    
    self.shapeLayer.hidden = NO;
}

- (void)stopAnimating
{
    [UIView animateWithDuration:0.5 animations:^{
        
        self.contentView.transform = CGAffineTransformMakeScale(1.2, 1.2);
        self.contentView.alpha = 0.0;
        
    } completion:^(BOOL finished) {
        
        self.isAnimating = NO;
        self.contentView.transform = CGAffineTransformMakeScale(1.0, 1.0);
        self.contentView.alpha = 1.0;
        self.shapeLayer.hidden = self.hidesWhenStopped;
        [self.shapeLayer removeAllAnimations];
    }];
}



@end
