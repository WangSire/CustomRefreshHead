//
//  WXHeader.m
//  asdkjasdj
//
//  Created by zhangjian on 2018/7/9.
//  Copyright © 2018年 Roadoor. All rights reserved.
//

#import "WXHeader.h"
#import "RDLoadingView.h"

@interface WXHeader()
@property (nonatomic, strong) RDLoadingView *logo;
@property (weak, nonatomic) UILabel *label;
@end

@implementation WXHeader

-(void)prepare
{
    [super prepare];
    
    // 设置控件的高度
    self.mj_h = 65;
    
    // 添加label
    UILabel *label = [[UILabel alloc] init];
    label.textColor = [UIColor colorWithRed:1.0 green:0.5 blue:0.0 alpha:1.0];
    label.font = [UIFont boldSystemFontOfSize:12];
    label.textAlignment = NSTextAlignmentCenter;
    [self addSubview:label];
    self.label = label;
    
    self.logo = [[RDLoadingView alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
    [self addSubview:self.logo];
}

#pragma mark 在这里设置子控件的位置和尺寸
- (void)placeSubviews
{
    [super placeSubviews];
    self.logo.center = CGPointMake(self.mj_w * 0.5, self.mj_h * 0.5 - 10);
    
    self.label.bounds = self.bounds;
    self.label.center = CGPointMake(self.mj_w * 0.5, self.mj_h * 0.5 + 20);

}

#pragma mark 监听scrollView的contentOffset改变
- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change
{
    [super scrollViewContentOffsetDidChange:change];
    id newPoint = [change objectForKey:@"new"];
    CGPoint point = [newPoint CGPointValue];
    if (-point.y < 75) {
       self.logo.progress = -point.y / 65;
    }
    
}

#pragma mark 监听scrollView的contentSize改变
- (void)scrollViewContentSizeDidChange:(NSDictionary *)change
{
    [super scrollViewContentSizeDidChange:change];
}

#pragma mark 监听scrollView的拖拽状态改变
- (void)scrollViewPanStateDidChange:(NSDictionary *)change
{
    [super scrollViewPanStateDidChange:change];
    
}

#pragma mark 监听控件的刷新状态
- (void)setState:(MJRefreshState)state
{
    MJRefreshCheckState;
    
    switch (state) {
        case MJRefreshStateIdle:
            self.label.text = @"阳光互金白名单五星企业";
            self.logo.state = RefreshStateIdle;
            break;
        case MJRefreshStatePulling:
            self.label.text = @"赶紧放开我吧";
            self.logo.state = RefreshStatePulling;
            break;
        case MJRefreshStateRefreshing:
            self.label.text = @"加载数据中";
            self.logo.state = RefreshStateLoad;
            break;
        default:
            break;
    }
}

#pragma mark 监听拖拽比例（控件被拖出来的比例）
- (void)setPullingPercent:(CGFloat)pullingPercent
{
    [super setPullingPercent:pullingPercent];
    
    // 1.0 0.5 0.0
    // 0.5 0.0 0.5
    CGFloat red = 1.0 - pullingPercent * 0.5;
    CGFloat green = 0.5 - 0.5 * pullingPercent;
    CGFloat blue = 0.5 * pullingPercent;
    self.label.textColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
