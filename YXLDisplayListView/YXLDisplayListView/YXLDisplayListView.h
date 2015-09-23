//
//  YXLDisplayListView.h
//  测试
//
//  Created by Yexinglong on 14-9-27.
//  Copyright (c) 2014年 Yexinglong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YXLBottomScrollView.h"
#import "YXLTopScrollView.h"
@class YZDisplayListView;

@interface YXLDisplayListView : UIView

@property (nonatomic, strong)YXLTopScrollView *topScroll;
@property (nonatomic, strong)YXLBottomScrollView *bottomScroll;
/**
 *  是否需要顶部分割线
 */
@property (nonatomic, assign) BOOL isNeedTopDivider;
/**
 *  选项卡普通状态颜色
 */
@property (nonatomic, strong) UIColor *tabItemNormalColor;
/**
 *  选项卡选中状态颜色
 */
@property (nonatomic, strong) UIColor *tabItemSelectedColor;
/**
 *  选项卡普通状态图片
 */
@property (nonatomic, strong) UIImage *tabItemNormalBackgroundImage;
/**
 *  选项卡选中状态图片
 */
@property (nonatomic, strong) UIImage *tabItemSelectedBackgroundImage;
/**
 *  选中角标
 */
@property (nonatomic, assign) NSInteger selectedIndex;
/**
 *  顶部背景颜色
 */
@property (nonatomic, strong) UIColor *topBackgroundColor;
/**
 *  底部背景颜色
 */
@property (nonatomic, strong) UIColor *bottomBackgroundColor;
/**
 *  子控制器数组
 */
@property (nonatomic, strong) NSArray *viewControllers;
/**
 *  是否需要顶部下划线
 */
@property (nonatomic, assign) BOOL isNeedTopUnderline;
/**
 *  设置顶部按钮下划线背景
 */
@property (nonatomic, strong) UIColor *topUnderlineBackgroundColor;
/**
 *  默认40
 */
@property (nonatomic, assign) NSInteger kTopScrollH;
/**
 *  上面是几个按钮 默认2个一个屏幕上最多四个显示
 */
@property (nonatomic, assign) NSInteger kBtnWInt;
/**
 *  更改一个屏幕上最多显示按钮个数
 */
@property (nonatomic ,assign) NSInteger kBtnWWinInt;


@end
