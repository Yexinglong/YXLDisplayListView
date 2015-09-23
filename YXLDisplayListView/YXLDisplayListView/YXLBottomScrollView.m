//
//  YXLBottomScrollView.m
//  测试
//
//  Created by Yexinglong on 14-9-27.
//  Copyright (c) 2014年 Yexinglong. All rights reserved.
//

#import "YXLBottomScrollView.h"
#import "Common.h"
#import "YXLDisplayView.h"



@interface YXLBottomScrollView()
{
    
    // 可见视图字典
    NSMutableDictionary *_visiblePhotoViewDict;
    
    // 可重用视图集合
    NSMutableSet *_reuseablePhotoViewSet;
    
    // 记录上一次滚动的偏移量
    CGFloat _lastContentOffsetX;
    
}


@end

@implementation YXLBottomScrollView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        // 设置UIScrollView的属性
        self.pagingEnabled = YES;
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        self.bounces = NO;
        // 设置scrollView的代理
        self.delegate = self;
        
        // 添加选中产品分类按钮通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(productClassBtnSelected:) name:kProductClassBtnSelectedNote object:nil];
        
    }
    
    return self;
}

#pragma mark - 设置当前角标和偏移量
- (void)setSelectedIndex:(NSInteger)selectedIndex
{
    _selectedIndex = selectedIndex;
    [self setContentOffset:CGPointMake(_selectedIndex * self.bounds.size.width, 0)];
    
    // 如果选中第一个子控制视图，需要手动调用显示子控制器视图
    if (_selectedIndex == 0) {
        // 显示子控制器视图
        [self showChildControllerView:self];
    }}


- (void)setViewControllers:(NSArray *)viewControllers
{
    _viewControllers = viewControllers;
    
    // 设置滚动视图范围
    self.contentSize = CGSizeMake(viewControllers.count * self.bounds.size.width, self.bounds.size.height);
    if (_visiblePhotoViewDict == nil) {
        
        // 实例化缓存数据
        _visiblePhotoViewDict = [NSMutableDictionary dictionary];
    }
    
    if (_reuseablePhotoViewSet == nil) {
        
        _reuseablePhotoViewSet = [NSMutableSet set];
    }
    
    
    
}

#pragma mark - 滚动视图代理方法
#pragma mark 滚动视图滚动
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
   
    
    
    // 显示子控制器视图
    [self showChildControllerView:scrollView];
    // 发送底部scrollView滚动减速完成通知，更改顶部ScrollView的选中
    
    
    
}

- (void)showChildControllerView:(UIScrollView *)scrollView
{
     
    
        CGFloat offsetX = scrollView.contentOffset.x;
        
        // 获取即将显示第一个子控制视图角标
        NSInteger firstIndex = offsetX / scrollView.bounds.size.width;
        
        // 获取即将显示第二个子控制器视图角标
        NSInteger nextIndex = firstIndex + 1;
        
        // 数值处理
        if (firstIndex < 0) firstIndex = 0;
        if (nextIndex > _viewControllers.count - 1) nextIndex = _viewControllers.count -1;
        
        // 加载照片，为了避免加载相同角标的坐标，可以采用循环加载图片，及可以加载图片又能做判断
        for (NSInteger i = firstIndex; i <= nextIndex; i++) {
            [self showChildControllerViewAtIndex:i];
        }
        
        
        // 如果不需要下划线就不需要执行下面的操作
        if (!_isNeedTopUnderline) return;
        
        // 发送底部scrollView滚动通知，更改顶部ScrollView下划线的位置
        [[NSNotificationCenter defaultCenter] postNotificationName:kBottomScrollViewDidScroll object:nil userInfo:@{kBottomContentoffsetX:@(scrollView.contentOffset.x)}];
    
   
    

    
}

#pragma mark 显示指定索引显示照片
- (void)showChildControllerViewAtIndex:(NSInteger)index
{
    
    YXLDisplayView *displayView = _visiblePhotoViewDict[@(index)];
    
    // 如果可见视图没有，就创建
    if (displayView == nil) {
        // 2.判断是否需要实例化视图
        displayView = [self dequeueReusablePhotoView];
        
        if (displayView == nil) {
            // 实例化视图
            displayView = [[YXLDisplayView alloc] init];
        }
        
        
        // 设置照片视图属性
        CGFloat displayViewW = self.bounds.size.width;
        CGFloat displayViewH = self.bounds.size.height;
        
        // 设置frame
        displayView.frame = CGRectMake(index * displayViewW, 0, displayViewW, displayViewH);
        
        // 加载对应子控制器
        UIViewController *c = _viewControllers[index];
        displayView.viewController = c;
        
        // 添加到视图
        [self addSubview:displayView];
    }
    
    // 添加到可视字典
    [_visiblePhotoViewDict setObject:displayView forKey:@(index)];
    
}

#pragma mark - 查询可重用单元格视图
- (YXLDisplayView *)dequeueReusablePhotoView
{
    // 1. 从缓存集合中查找可重用视图
    YXLDisplayView *displayView = [_reuseablePhotoViewSet anyObject];
    
    // 2. 如果找到，从缓存中删除，并返回照片视图
    if (displayView)
    {
        [_reuseablePhotoViewSet removeObject:displayView];
    }
    
    return displayView;
}


/**
 *  监听scrollView滚动,当减速完成的时候，发出通知告诉顶部scrollView
 */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
    // 计算出正在显示的照片的索引
    NSInteger index = scrollView.contentOffset.x / scrollView.bounds.size.width;
    // 判断如果显示的照片 = 上一次记录的当前索引，就直接返回，不移除
    if (index == _selectedIndex) return;
    
    // 移除上一次记录的索引视图,每次滑动到下一个视图，之前记录的视图我们需要移除视图
    // 取出上一次记录的索引视图
    YXLDisplayView *displayView = _visiblePhotoViewDict[@(_selectedIndex)];
    
    // 将视图移除可见字典视图
    [_visiblePhotoViewDict removeObjectForKey:@(_selectedIndex)];
    
    // 将视图移除根视图
    [displayView removeFromSuperview];
    
    // 将视图添加到可重用集合
    [_reuseablePhotoViewSet addObject:displayView];
    
    // 将正在显示的照片索引设置为当前索引
    _selectedIndex = index;
    
    // 发送底部scrollView滚动减速完成通知，更改顶部ScrollView的选中
    [[NSNotificationCenter defaultCenter] postNotificationName:kBottomScrollViewDidEndDecelerating object:nil userInfo:@{kSelectedIndexKey:@(_selectedIndex)}];
}


/**
 *  当选中产品分类按钮的时候调用
 */
- (void)productClassBtnSelected:(NSNotification *)note
{
    NSDictionary *userInfo = note.userInfo;
    // 记录选中的角标
    self.selectedIndex = [userInfo[kSelectedIndexKey] integerValue];
    
}

- (void)dealloc
{
    // 将通知移除
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end
