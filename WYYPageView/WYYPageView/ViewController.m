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
    self.navigationItem.title = @"仿网易客户端";
    
    float navHeight = self.navigationController.navigationBar.frame.size.height;
    float statusBarHeight = [[UIApplication sharedApplication] statusBarFrame].size.height;
    
    self.pageView = [[PageView alloc] initWithFrame:CGRectMake(0, navHeight+statusBarHeight, self.view.frame.size.width, self.view.frame.size.height-navHeight-statusBarHeight)];
    self.pageView.pageViewDelegate = self;
    //这只黑色的时候不能直接是使用[UIColor blackColor],需要使用黑色的rgb    其他的颜色可以随意写
//    [self.pageView setTitleCommonColor:[UIColor blueColor]];//设置title正常现实颜色
//    [self.pageView setTitleSelectedColor:[UIColor redColor]];//设置title选中时的颜色
//    [self.pageView setTitleFont:[UIFont systemFontOfSize:16]];//设置title的字体
    [self.pageView autoDispalyPageMenueTitles:@[@"page1",@"page2",@"page3",@"page4",@"page5",@"page6",@"page7"]];
    [self.view addSubview:self.pageView];
}

#pragma marks pageViewDelegate
-(void)pageViewLoadContentView
{
    float index = self.pageView.pageContentScrollView.contentOffset.x/self.pageView.pageContentScrollView.frame.size.width;
    [self.pageView setSrollViewPageLocation:(int)index];
    UIView *view = self.pageView.pageContents[(int)index];
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
