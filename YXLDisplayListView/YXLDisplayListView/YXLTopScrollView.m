//
//  YXLTopScrollView.m
//  测试
//
//  Created by Yexinglong on 14-9-27.
//  Copyright (c) 2014年 Yexinglong. All rights reserved.
//

#import "YXLTopScrollView.h"
#import "Common.h"

@interface YXLTopScrollView ()
{
    // 选中的选项卡
    UIButton  * _selectedTabItem;
    
    // 所有选项卡按钮
    NSMutableArray * _tabsArr;
    
    // 顶部下划线
    UIView *_underLine;
    
    
    
}
// 记录住每个按钮对应下划线的frame,需要重写get方法，为了懒加载数组
@property (nonatomic, strong) NSMutableArray *underLineFrames;

@end

@implementation YXLTopScrollView

// 懒加载数组
- (NSMutableArray *)underLineFrames
{
    if (_underLineFrames == nil) {
        _underLineFrames = [NSMutableArray array];
    }
    
    return _underLineFrames;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIView *viewShow =[[UIView alloc]init];
        viewShow.frame =(CGRect){0,frame.size.height-0.5,kWindowWidth,0.3};
        viewShow.alpha=0.3;
        viewShow.backgroundColor=[UIColor blackColor];
        [self addSubview:viewShow];
        // Initialization code
        
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        _tabsArr = [NSMutableArray array];
        
        self.bounces = NO;
        
        // 添加底部scrollView减速完成通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(bottomScrollViewDidEndDecelerating:) name:kBottomScrollViewDidEndDecelerating object:nil];
        
    }
    return self;
}
- (void)setIsNeedTopUnderline:(BOOL)isNeedTopUnderline
{
    _isNeedTopUnderline = isNeedTopUnderline;
    
    if (isNeedTopUnderline) {
        
        // 添加底部scrollView滚动通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(bottomScrollViewDidEndScroll:) name:kBottomScrollViewDidScroll object:nil];
    }
    
}
- (void)bottomScrollViewDidEndScroll:(NSNotification *)note
{
    
    NSDictionary *userInfo = note.userInfo;
    
    CGFloat offsetX = [userInfo[kBottomContentoffsetX] doubleValue];
    
    NSInteger nextIndex;
    // 计算出正在显示的照片的索引
    NSInteger index = offsetX / self.bounds.size.width;
    
    // 实际平移量
    CGFloat transX = offsetX - index * self.bounds.size.width;
   
    
    
    // 将正在显示的照片索引设置为当前索引
    _selectedIndex = index;
    
    if (transX < 0) { // 往右边移动
        nextIndex = _selectedIndex - 1;
    }else if(transX > 0)
    {
        nextIndex = _selectedIndex + 1;
    }
    
    NSInteger count = _underLineFrames.count;
    
    // 当角标越界就不执行了。
    if (nextIndex >= count || nextIndex < 0) return;
    
    
    // 获取当前角标对应按钮的下划线frame
    CGRect currentFrame = [_underLineFrames[_selectedIndex] CGRectValue];
    // 获取下一个角标对应按钮的下划线frame
    CGRect nextFrame = [_underLineFrames[nextIndex] CGRectValue];
    
//    NSLog(@"currentFrame:%@    nextFrame:%@",NSStringFromCGRect(currentFrame),NSStringFromCGRect(nextFrame));
    
    
    CGFloat distance = (CGFloat)fabs(nextFrame.origin.x - currentFrame.origin.x);
    
    // 获取平移比例
    CGFloat translationScale = distance / self.bounds.size.width;
    
    // 获取下划线滚动的偏移量
    CGFloat underLineOffsetX = transX * translationScale;
    
    currentFrame.origin.x += underLineOffsetX;
//    NSLog(@"%lf",currentFrame.origin.x);
    // 获取前后两个角标下划线的尺寸差
    CGFloat sizeGap = nextFrame.size.width - currentFrame.size.width;
    
    // 获取每平移一个坐标点的缩放比例
    CGFloat zoomScale = sizeGap / distance;
    
    // 获取每平移一个坐标点下划线宽度的缩放量
    CGFloat underLineZoomW = (CGFloat)fabs(underLineOffsetX) * zoomScale;
    
//下面需要判断一下！这种错误是在float经过函数运行出了不是数字的值，nan的意思就是not a number
        if (!isnan(underLineZoomW))
        {
        currentFrame.size.width += underLineZoomW;
        }
    
   

    

    _underLine.frame = currentFrame;
    
}

/**
 *  底部scrollView减速完成就调用
 */
- (void)bottomScrollViewDidEndDecelerating:(NSNotification *)note
{
    NSDictionary *userInfo = note.userInfo;
    
    // 获取对应的按钮
    UIButton *tab = _tabsArr[[userInfo[kSelectedIndexKey] integerValue]];
    
    // 点击对应的按钮
    [self tabClick:tab];
    
}
#pragma mark 调整顶部滚动视图x位置,让按钮完整显示出来
- (void)adjustTopScrollViewContentX:(UIButton *)sender
{
    
    
    // 总宽度
    CGFloat frameW = self.frame.size.width;
    
    // 内容宽度
    CGFloat contentW = self.contentSize.width;
    
    // 按钮中点的x
    CGFloat btnCenterX = sender.center.x;
    
    if (btnCenterX + frameW * 0.5 >= contentW) {
        
        [self setContentOffset:CGPointMake(contentW - frameW, 0) animated:YES];
        
    } else {
        
        CGFloat posX = btnCenterX - frameW * 0.5;
        if (posX > 0) {
            [self setContentOffset:CGPointMake(posX, 0) animated:YES];
        } else {
            [self setContentOffset:CGPointZero animated:YES];
        }
    }
}


- (void)dealloc
{
    // 将通知移除
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark 加载子控制器对应的
- (void)setViewControllers:(NSArray *)viewControllers
{
    _viewControllers = viewControllers;
    
    NSInteger count = viewControllers.count;
    
    
    self.contentSize = CGSizeMake((kBtnW +kMargin) * count, 0);
    
    for (int i = 0; i < count; i++) {
        
        UIButton *tabItem = [UIButton buttonWithType:UIButtonTypeCustom];
        
        
        
        
        [tabItem setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        if (self.tabItemNormalColor) {
            [tabItem setTitleColor:self.tabItemNormalColor forState:UIControlStateNormal];
        }
        if (self.tabItemSelectedColor) {
            [tabItem setTitleColor:self.tabItemSelectedColor forState:UIControlStateSelected];
        }
        [tabItem setBackgroundImage:self.tabItemNormalBackgroundImage forState:UIControlStateNormal];
        [tabItem setBackgroundImage:self.tabItemSelectedBackgroundImage forState:UIControlStateSelected];
        
        
        CGFloat tabX = (kBtnW +kMargin) * i;
        
        tabItem.tag = i;
        
        tabItem.frame = CGRectMake(tabX, 0, kBtnW, kBtnH);
        
        UIViewController *c = viewControllers[i];
        
        [tabItem setTitle:c.title forState:UIControlStateNormal];
        
        // 选中当前选中分类
        if (i == _selectedIndex) {
            [self tabClick:tabItem];
        }
        // 如果需要下划线，就记录住每个按钮对应的下划线frame
        if (_isNeedTopUnderline) {
            // 计算当前按钮对应的下划线frame
            
            CGRect frame = [self getUnderLineFrameWithButton:tabItem];
        
            [self.underLineFrames addObject:[NSValue valueWithCGRect:frame]];
        }
        //这里可以给btn后面添加背后图片
#warning 待做  这个功能貌似有点问题哈
//        [tabItem setBackgroundImage:[UIImage imageNamed:@"girl4"] forState:UIControlStateSelected];
        
        // 监听按钮点击
        [tabItem addTarget:self action:@selector(tabClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [_tabsArr addObject:tabItem];
        
        
        [self addSubview:tabItem];
        
        if (_isNeedTopDivider) {
            // 3.添加一个分割线
            [self addDivider:tabItem];
        }
        
    }
    
}


- (void)tabClick:(UIButton *)tabItem
{
#warning 顶部按钮根据你得项目需求如果总个数超过显示区域需要将这个打开，没超过就注释掉
    // 调整顶部按钮文字显示范围：居中还是刚好显示全
//    [self adjustTopScrollViewContentX:tabItem];

    // 防止点击同一个按钮
    if (_selectedTabItem == tabItem) return;
    
    _selectedTabItem.selected = NO;
    tabItem.selected = YES;
    _selectedTabItem = tabItem;
    
    _selectedIndex = tabItem.tag;
    
    // 发送通知，告诉底部ScrollView滚动到对应的界面
    [[NSNotificationCenter defaultCenter] postNotificationName:kProductClassBtnSelectedNote object:nil userInfo:@{kSelectedIndexKey:@(_selectedTabItem.tag)}];
    
    
    // 判断是否需要下划线
    if (_isNeedTopUnderline)  {
        
        // 根据指定按钮添加/移动线条
        [self moveUnderLineWithButton:tabItem];
        
    }
}

#pragma mark 根据指定按钮添加/移动线条
- (void)moveUnderLineWithButton:(UIButton *)button
{
    
    // 获取顶部下划线的frame
    CGRect lineRect = [self getUnderLineFrameWithButton:button];
    
    // 懒加载下划线
    if (_underLine == nil) {
        _underLine = [[UIView alloc] initWithFrame:lineRect];
        _underLine.backgroundColor = [UIColor redColor];
        _underLine.layer.masksToBounds=YES;
        _underLine.layer.cornerRadius=1.5;
        if (_topUnderlineBackgroundColor) {
            _underLine.backgroundColor = _topUnderlineBackgroundColor;
        }
        
        [self addSubview:_underLine];
    }
    
 
    [UIView animateWithDuration:0.2f animations:^{
        [_underLine setFrame:lineRect];
    }];
    
}

/**
 *  获取顶部下划线的frame
 *
 *  @param button 即将出现在哪个button下
 *
 *  @return 下划线frame
 */
- (CGRect)getUnderLineFrameWithButton:(UIButton *)button
{
    UIFont *font= kTabItemFont;
    
     [button.titleLabel setFont:font];
    
      NSDictionary *dic=[NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName, nil];
    
    CGSize strSize=[button.titleLabel.text boundingRectWithSize:button.frame.size options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
 
//    int btnY = kBtnH / 2 + FontInt / 2;
  
            int btnX;
    if (button.tag == 0) {
        btnX = (kBtnW - strSize.width) / 2;
    }
    else
    btnX = (kBtnW - strSize.width) / 2+ kBtnW *(int)button.tag ;
  
   
            return  CGRectMake(btnX, self.frame.size.height-3, (int)strSize.width, 3);

}

/**
 *  添加分割线
 *
 */
- (void)addDivider:(UIButton *)tab
{
    UIView *divider = [[UIView alloc] init];
    
    CGFloat dividerH = kBtnH / 2;
    CGFloat dividerY = (self.bounds.size.height - dividerH) / 2;
    CGFloat dividerW = 1;
    CGFloat dividerX = CGRectGetMaxX(tab.frame) - 1;
    divider.alpha = 0.5;
    divider.frame = CGRectMake(dividerX, dividerY, dividerW, dividerH);
    divider.backgroundColor = [UIColor grayColor];
    [self addSubview:divider];
}

@end
