//
//  YXLDisplayListView.m
//  测试
//
//  Created by Yexinglong on 14-9-27.
//  Copyright (c) 2014年 Yexinglong. All rights reserved.
//

#import "YXLDisplayListView.h"

#import "Common.h"
@interface YXLDisplayListView ()

@property (nonatomic,assign) NSInteger kMargin;

@end

@implementation YXLDisplayListView

#pragma mark 调用init方法会调用此方法
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initTopFrame];
    }
    return self;
}


#pragma mark 从xib加载会调用这个方法
- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initTopFrame];
    }
    return self;
}

-(void)initTopFrame{
    _kTopScrollH =40;
    _kBtnWInt=2;
    _kBtnWWinInt=4;
    
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
    CGFloat scrollH = self.bounds.size.height - _kTopScrollH;
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
    
    // 分类按钮的间距
    if (_kBtnWInt>_kBtnWWinInt) {
        _kMargin= (CGWidth(self.frame)-(CGWidth(self.frame)/_kBtnWWinInt)*_kBtnWWinInt)/_kBtnWWinInt;
    }else{
        _kMargin= (CGWidth(self.frame)-(CGWidth(self.frame)/_kBtnWInt)*_kBtnWInt)/_kBtnWInt;
    }
    
    CGFloat scrollY = 0;
    
    CGFloat scrollW = self.frame.size.width;
    
    YXLTopScrollView *scroll = [[YXLTopScrollView alloc] initWithFrame:CGRectMake(0, scrollY, scrollW, _kTopScrollH)];
    scroll.kMargin=_kMargin;
    if (_kBtnWInt > _kBtnWWinInt) {
    scroll.kBtnW=CGWidth(self.frame)/_kBtnWWinInt;
    }else{
    scroll.kBtnW=CGWidth(self.frame)/_kBtnWInt;
    }
    
    scroll.isCenterThe=YES;
    
    scroll.topUnderlineBackgroundColor=_topUnderlineBackgroundColor;

    
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
    
#warning 这里设置滑动栏背景颜色

    scroll.backgroundColor=[UIColor whiteColor];
    [self addSubview:scroll];
    
    
    _topScroll = scroll;
}




@end
