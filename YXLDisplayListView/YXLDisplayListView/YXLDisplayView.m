//
//  YXLDisplayView.m
//  测试
//
//  Created by Yexinglong on 14-9-27.
//  Copyright (c) 2014年 Yexinglong. All rights reserved.
//

#import "YXLDisplayView.h"

@implementation YXLDisplayView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setViewController:(UIViewController *)viewController
{
    _viewController = viewController;
    
    viewController.view.frame = self.bounds;
    
    // 先把之前的控制器视图移除
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    // 添加新的控制器视图
    [self addSubview:viewController.view];
    
}

@end
