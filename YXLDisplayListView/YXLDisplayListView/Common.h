//
//  Common.h
//  YXLDisplayListView
//
//  Created by 叶星龙 on 15/6/1.
//  Copyright (c) 2015年 叶星龙. All rights reserved.
//


/*******************/
// 顶部滚动视图的高度
//#define kTopScrollH 40
//
////设置按钮显示区域多少个
//#define kBtnWInt 4
//
//// 分类按钮的宽度
//#define kBtnW kWindowWidth/kBtnWInt
//// 分类按钮的间距
//#define kMargin (kWindowWidth-kBtnW*kBtnWInt)/kBtnWInt
//
//// 分类按钮的高度
//#define kBtnH 40

#ifndef CGWidth
#define CGWidth(rect)                   rect.size.width
#endif

#ifndef CGHeight
#define CGHeight(rect)                  rect.size.height
#endif

#ifndef CGOriginX
#define CGOriginX(rect)                 rect.origin.x
#endif

#ifndef CGOriginY
#define CGOriginY(rect)                 rect.origin.y
#endif


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

