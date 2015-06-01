//
//  YXLDisplayListView.m
//  测试
//
//  Created by Yexinglong on 14-9-27.
//  Copyright (c) 2014年 Yexinglong. All rights reserved.
//

#import "YXLDisplayListView.h"
#import "YXLBottomScrollView.h"
#import "YXLTopScrollView.H"
#import "Common.h"
@interface YXLDisplayListView ()
{
    YXLTopScrollView *_topScroll;
    YXLBottomScrollView *_bottomScroll;
}
@end

@implementation YXLDisplayListView

#pragma mark 调用init方法会调用此方法
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        
    }
    return self;
}


#pragma mark 从xib加载会调用这个方法
- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
    }
    return self;
}


#pragma 初始化视图
- (void)initializeView
{
    // 1.添加topScrollView
    [self addTopScrollView];
    
    // 2.添加bottomScrollView
    [self addBottomScrollview];
    
    
    
}
- (void)setViewControllers:(NSArray *)viewControllers
{
    _viewControllers = viewControllers;
    
    [self initializeView];
}



#pragma mark 添加bottomScrollView
- (void)addBottomScrollview
{
    CGFloat scrollY = CGRectGetMaxY(_topScroll.frame);
    CGFloat scrollW = self.bounds.size.width;
    CGFloat scrollH = self.bounds.size.height - kTopScrollH;
    YXLBottomScrollView *scroll = [[YXLBottomScrollView alloc]  initWithFrame:CGRectMake(0, scrollY, scrollW, scrollH)];
    // 设置背景颜色
    scroll.backgroundColor = _bottomBackgroundColor;
    
    scroll.isNeedTopUnderline = _isNeedTopUnderline;
    
    // 注意：选中的角标需要放在设置控制器数组的前面
    scroll.viewControllers = _viewControllers;
    
    scroll.selectedIndex = _selectedIndex;
    
    [self addSubview:scroll];
    
    _bottomScroll = scroll;
    
}
#pragma mark 添加顶部ScrollView
- (void)addTopScrollView
{
    CGFloat scrollY = 0;
    
    CGFloat scrollW = self.frame.size.width;
    
    YXLTopScrollView *scroll = [[YXLTopScrollView alloc] initWithFrame:CGRectMake(0, scrollY, scrollW, kTopScrollH)];
    
#warning 这里设置滑动栏背景颜色
    scroll.backgroundColor = [UIColor whiteColor];
    
    scroll.tabItemNormalBackgroundImage = self.tabItemNormalBackgroundImage;
    
    scroll.tabItemNormalColor = self.tabItemNormalColor;
    
    scroll.tabItemSelectedBackgroundImage = self.tabItemSelectedBackgroundImage;
    
    scroll.tabItemSelectedColor = self.tabItemSelectedColor;
    
    scroll.isNeedTopUnderline = _isNeedTopUnderline;
    // 是否需要分割线
    scroll.isNeedTopDivider = _isNeedTopDivider;
    // 注意：选中的角标需要放在设置控制器数组的前面
    scroll.selectedIndex = _selectedIndex;
    
    scroll.viewControllers = _viewControllers;
    
    [self addSubview:scroll];
    
    
    _topScroll = scroll;
}




@end
