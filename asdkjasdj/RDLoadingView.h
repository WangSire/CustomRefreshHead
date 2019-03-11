//
//  RDLoadingView.h
//  asdkjasdj
//
//  Created by zhangjian on 2018/7/9.
//  Copyright © 2018年 Roadoor. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CircleProgressLayer.h"

typedef enum : NSUInteger {
    RefreshStateIdle, /** 普通闲置状态 */
    RefreshStatePulling, /** 松开就可以进行刷新的状态 */
    RefreshStateLoad, /** 正在刷新中的状态 */
} RefreshState;

@interface RDLoadingView : UIView
@property (nonatomic, assign) CGFloat progress;

/** 记录当前刷新状态 */
@property (nonatomic, assign) RefreshState state;
@end
