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
    
    YXLDisplayListView *Display =[[YXLDisplayListView alloc]initWithFrame:(CGRect){0,0,kWindowWidth,kWindowHeight}];
    
    UIViewController * all = [[UIViewController alloc]init];
    all.view.backgroundColor=UIColorRGBA(100, 238, 238, 1);
    all.title=@"全部";
    
    UIViewController * undisbursed = [[UIViewController alloc]init];
    undisbursed.view.backgroundColor=UIColorRGBA(50, 238, 238, 1);
    undisbursed.title=@"未支付";
    
    UIViewController * noConsume = [[UIViewController alloc]init];
    noConsume.view.backgroundColor=UIColorRGBA(200, 238, 238, 1);
    noConsume.title=@"未消费";
    
    UIViewController * toBeEvaluated = [[UIViewController alloc]init];
    toBeEvaluated.view.backgroundColor =UIColorRGBA(250, 238, 238, 1);
    toBeEvaluated.title=@"待评价";
    
    UIViewController * refunds = [[UIViewController alloc]init];
    refunds.view.backgroundColor=UIColorRGBA(0, 238, 238, 1);
    refunds.title=@"退款";
    
    NSArray * controllers = @[all,undisbursed,noConsume,toBeEvaluated,refunds];
    //是否需要顶部下划线
    Display.isNeedTopUnderline = YES;
    //这里是更改顶部滑动字体颜色
    Display.tabItemSelectedColor = [UIColor blackColor];
    //添加控制器到数组
    Display.viewControllers = controllers;
    
    [self.view addSubview:Display];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
