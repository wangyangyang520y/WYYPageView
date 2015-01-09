//
//  ViewController.m
//  WYYPageView
//
//  Created by wangyangyang on 15/1/2.
//  Copyright (c) 2015年 wangyangyang. All rights reserved.
//

#import "ViewController.h"


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
//    self.navigationItem.title = @"仿网易客户端";
    [self.navigationController setNavigationBarHidden:YES];
//    
//    float navHeight = self.navigationController.navigationBar.frame.size.height;
//    float statusBarHeight = [[UIApplication sharedApplication] statusBarFrame].size.height;
    
    self.pageView = [[PageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    self.pageView.pageViewDelegate = self;
    //这只黑色的时候不能直接是使用[UIColor blackColor],需要使用黑色的rgb    其他的颜色可以随意写
//    [self.pageView setTitleCommonColor:[UIColor blueColor]];//设置title正常现实颜色
//    [self.pageView setTitleSelectedColor:[UIColor redColor]];//设置title选中时的颜色
//    [self.pageView setTitleFont:[UIFont systemFontOfSize:16]];//设置title的字体
    [self.pageView autoDispalyPageMenueTitles:@[@"page1",@"page2",@"page3",@"page4",@"page5",@"page6",@"page7"]];
    [self.view addSubview:self.pageView];
}

//-(void)viewWillAppear:(BOOL)animated
//{
//    [super viewWillAppear:animated];
//    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
//}



-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

#pragma marks pageViewDelegate
-(void)pageViewLoadContentView
{
    float index = self.pageView.pageContentScrollView.contentOffset.x/self.pageView.pageContentScrollView.frame.size.width;
    [self.pageView setSrollViewPageLocation:(int)index];//必须调用
    
    
    UIView *view = self.pageView.pageContents[(int)index];
    
    //自定义每个page的view
    if ((int)index%2==0) {
        view.backgroundColor = [UIColor redColor];
    }else{
        view.backgroundColor = [UIColor yellowColor];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
