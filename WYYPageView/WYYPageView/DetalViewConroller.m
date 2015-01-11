//
//  DetalViewConroller.m
//  WYYPageView
//
//  Created by wangyangyang on 15/1/11.
//  Copyright (c) 2015年 wangyangyang. All rights reserved.
//

#import "DetalViewConroller.h"
#import "AppDelegate.h"

@interface DetalViewConroller ()

@end

@implementation DetalViewConroller

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self initNavigationView];
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.navigationView.frame.size.height+self.navigationView.frame.origin.y+2, self.view.frame.size.width, self.view.frame.size.height-(self.navigationView.frame.size.height+self.navigationView.frame.origin.y+2))];
    [self.scrollView setShowsVerticalScrollIndicator:NO];
    [self initScrollViewContent];
    [self.view addSubview:self.scrollView];
    // Do any additional setup after loading the view.
}

-(void)initScrollViewContent
{
    for (int i =0; i<3; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"00%d.jpg",i+1]]];
        imageView.frame = CGRectMake(0, i*320, self.view.frame.size.width, 300);
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        imageView.userInteractionEnabled = YES;
        [self.scrollView addSubview:imageView];
    }
    self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width, 320*3);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initNavigationView
{
    AppDelegate *app = [UIApplication sharedApplication].delegate;
    float navHeight = app.navController.navigationBar.frame.size.height;
    float statusBarHeight = [[UIApplication sharedApplication] statusBarFrame].size.height;
    NSLog(@"navHeight :------%f",navHeight);
    self.navigationView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, navHeight+statusBarHeight)];
    self.navigationView.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.navigationView];
    
    self.navigationTitle = [[UILabel alloc] init];
    self.navigationTitle.text = @"内容";
    [self.navigationTitle setTextAlignment:NSTextAlignmentCenter];
    [self.navigationTitle setTextColor:[UIColor whiteColor]];
    [self.navigationTitle setFont:[UIFont systemFontOfSize:20]];
    self.navigationTitle.frame = CGRectMake(0, 0, 200, 30);
    self.navigationTitle.center = CGPointMake(self.navigationView.center.x, self.navigationView.center.y+10);
    [self.navigationView addSubview:self.navigationTitle];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    btn.frame = CGRectMake(0, 0, 40, 25);
    [btn setTitle:@"返回" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.center = CGPointMake(25, self.navigationView.center.y+10);
    [btn addTarget:self action:@selector(leftBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationView addSubview:btn];
}

-(void)leftBtnAction:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
