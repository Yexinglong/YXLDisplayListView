//
//  YXLTopScrollView.h
//  测试
//
//  Created by Yexinglong on 14-9-27.
//  Copyright (c) 2014年 Yexinglong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YXLTopScrollView : UIScrollView
/* 主视图的子视图控制器数组 */
@property (nonatomic, strong) NSArray *viewControllers;
/* 选中角标 */
@property (nonatomic, assign) NSInteger selectedIndex;
/* 选中角标 */
@property (nonatomic, assign) NSInteger beitai;
/* 选项卡普通状态颜色 */
@property (nonatomic, strong) UIColor *tabItemNormalColor;
/* 选项卡选中状态颜色 */
@property (nonatomic, strong) UIColor *tabItemSelectedColor;
/* 选项卡普通状态图片 */
@property (nonatomic, strong) UIImage *tabItemNormalBackgroundImage;
/* 选项卡选中状态图片 */
@property (nonatomic, strong) UIImage *tabItemSelectedBackgroundImage;
/* 是否需要顶部分割线*/
@property (nonatomic, assign) BOOL isNeedTopDivider;
/* 是否需要顶部下划线*/
@property (nonatomic, assign) BOOL isNeedTopUnderline;
/* 设置顶部按钮下划线背景*/
@property (nonatomic, strong) UIColor *topUnderlineBackgroundColor;
/*是否居中显示完整按钮 默认NO不居中  只用于按钮个数超过屏幕*/
@property (nonatomic ,assign) BOOL isCenterThe;

@property (nonatomic ,assign) NSInteger kMargin;

@property (nonatomic ,assign) NSInteger kBtnW;



@end
