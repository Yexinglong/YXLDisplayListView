//
//  YXLBottomScrollView.h
//  测试
//
//  Created by Yexinglong on 14-9-27.
//  Copyright (c) 2014年 Yexinglong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YXLBottomScrollView : UIScrollView<UIScrollViewDelegate>

/* 主视图的子视图控制器数组 */
@property (nonatomic, strong) NSArray *viewControllers;
/* 选中角标 */
@property (nonatomic, assign) NSInteger selectedIndex;

/* 是否需要顶部下划线*/
@property (nonatomic, assign) BOOL isNeedTopUnderline;
@end
