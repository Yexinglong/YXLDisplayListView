//
//  Common.h
//  YXLDisplayListView
//
//  Created by 叶星龙 on 15/6/1.
//  Copyright (c) 2015年 叶星龙. All rights reserved.
//

#define kWindowWidth                        ([[UIScreen mainScreen] bounds].size.width)
#define kWindowHeight                       ([[UIScreen mainScreen] bounds].size.height)

// 标准的RGBA设置
#define UIColorRGBA(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]

/*******************/
// 顶部滚动视图的高度
#define kTopScrollH 40

#warning 设置按钮显示区域多少个
//设置按钮显示区域多少个
#define kBtnWInt 5

// 分类按钮的宽度
#define kBtnW kWindowWidth/kBtnWInt
// 分类按钮的间距
#define kMargin (kWindowWidth-kBtnW*kBtnWInt)/kBtnWInt

// 分类按钮的高度
#define kBtnH 40




//选中中了分类按钮的通知
#define kProductClassBtnSelectedNote @"ProductClassSelected"

// 底部滚动视图停止滚动
#define kBottomScrollViewDidEndDecelerating @"scrollViewDidEndDecelerating"

// 底部滚动视图滚动
#define kBottomScrollViewDidScroll @"scrollViewDidScroll"



// 当前选中角标
#define kSelectedIndexKey @"selectedIndex"

// 底部滚动的区域
#define kBottomContentoffsetX @"bottomContentoffsetX"

#define BAPopViewControllerNotification @"popToVC"

//字体数字
#define FontInt 15
// 选择卡字体
#define kTabItemFont [UIFont systemFontOfSize:FontInt]
/**************/

