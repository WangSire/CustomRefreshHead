//
//  RDLoadingView.m
//  asdkjasdj
//
//  Created by zhangjian on 2018/7/9.
//  Copyright © 2018年 Roadoor. All rights reserved.
//

#import "RDLoadingView.h"

@interface RDLoadingView()<CAAnimationDelegate>
@property (nonatomic, strong) UIImageView *iconImageView;
@property (strong,nonatomic) CircleProgressLayer * circleProgressLayer;
@end

@implementation RDLoadingView


-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}
-(void)setupUI
{
    self.iconImageView = [[UIImageView alloc]init];
    self.iconImageView.image = [UIImage imageNamed:@"global_Enter"];
    self.iconImageView.center = CGPointMake(self.bounds.size.width * 0.5, self.bounds.size.height * 0.5);
    self.iconImageView.bounds = CGRectMake(0, 0, 8, 9);
    [self addSubview:self.iconImageView];
    
    
    CALayer *layer = [self createRoundLayerWithColor:[UIColor lightGrayColor] EndAngle:M_PI * 2];
    [self.layer addSublayer:layer];
    
    self.circleProgressLayer = [CircleProgressLayer layer];
    self.circleProgressLayer.frame = self.bounds;
    //像素大小比例
    self.circleProgressLayer.contentsScale = [UIScreen mainScreen].scale;
    [self.layer addSublayer:self.circleProgressLayer];
    
}
- (void)setProgress:(CGFloat)progress {
    CABasicAnimation * ani = [CABasicAnimation animationWithKeyPath:@"progress"];
    ani.duration = 5.0 * fabs(progress - _progress);
    ani.toValue = @(progress);
    ani.removedOnCompletion = YES;
    ani.fillMode = kCAFillModeForwards;
    ani.delegate = self;
    [self.circleProgressLayer addAnimation:ani forKey:@"progressAni"];
    _progress = progress;
}
-(CALayer *)createRoundLayerWithColor:(UIColor *)color EndAngle:(CGFloat)angle
{
    CGFloat parameter = self.bounds.size.width/2;
    CALayer *layer = [CALayer layer];
    layer.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
    layer.backgroundColor = color.CGColor;
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(parameter, parameter) radius:parameter - 1 startAngle:0 endAngle:angle clockwise:YES];
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.strokeColor = [UIColor whiteColor].CGColor;
    shapeLayer.lineWidth = 1;
    shapeLayer.strokeStart = 0;
    shapeLayer.strokeEnd = 1;
    shapeLayer.lineCap = kCALineCapRound;
    shapeLayer.lineDashPhase = 0.8;
    shapeLayer.path = bezierPath.CGPath;
    [layer setMask:shapeLayer];
    return layer;
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    self.circleProgressLayer.progress = self.progress;
}

-(void)setState:(RefreshState)state
{
    switch (state) {
        case RefreshStatePulling:
            self.iconImageView.transform = CGAffineTransformMakeRotation(M_PI);
            break;
        case RefreshStateIdle:
            self.iconImageView.transform = CGAffineTransformIdentity;
            break;
            
        default:
            break;
    }
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
