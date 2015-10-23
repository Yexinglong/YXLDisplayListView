//
//  ViewController.m
//  YXLDisplayListView
//
//  Created by 叶星龙 on 15/6/1.
//  Copyright (c) 2015年 叶星龙. All rights reserved.
//

#import "ViewController.h"
#import "YXLDisplayListView.h"
#import "Common.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //ScrollView 不支持自适应UINavigationController 需自己去设置位子
    self.automaticallyAdjustsScrollViewInsets=NO;
    
    YXLDisplayListView *Display =[[YXLDisplayListView alloc]initWithFrame:(CGRect){{0,0},self.view.frame.size}];
    
    UIViewController * item1 = [[UIViewController alloc]init];
    item1.view.backgroundColor=[UIColor cyanColor];
    item1.title=@"我很帅";
    
    UIViewController * item2 = [[UIViewController alloc]init];
    item2.view.backgroundColor=[UIColor yellowColor];
    item2.title=@"是啊";
    
    UIViewController * item3 = [[UIViewController alloc]init];
    item3.view.backgroundColor=[UIColor cyanColor];
    item3.title=@"确实很帅";
    
    UIViewController * item4 = [[UIViewController alloc]init];
    item4.view.backgroundColor =[UIColor yellowColor];
    item4.title=@"左边说没错";
    
    UIViewController * item5 = [[UIViewController alloc]init];
    item5.view.backgroundColor=[UIColor cyanColor];
    item5.title=@"哈哈哈";
    
    UIViewController * item6 = [[UIViewController alloc]init];
    item6.view.backgroundColor=[UIColor cyanColor];
    item6.title=@"帅醒";
    
    NSArray * controllers = @[item1,item2,item3,item4,item5,item6];
    Display.kBtnWInt=controllers.count;
    Display.kBtnWWinInt=3;
    //是否需要顶部下划线
    Display.isNeedTopUnderline = YES;
    //这里是更改顶部滑动字体颜色
    Display.tabItemSelectedColor = [UIColor redColor];
    Display.topUnderlineBackgroundColor =[UIColor lightGrayColor];
    Display.topBackgroundColor=[UIColor whiteColor];
    //添加控制器到数组topBackgroundColor
    Display.viewControllers = controllers;
    [self.view addSubview:Display];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
