//
//  ViewController.h
//  WYYPageView
//
//  Created by wangyangyang on 15/1/2.
//  Copyright (c) 2015年 wangyangyang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PageView.h"
#import "PageOneView.h"

@interface ViewController : UIViewController<PageViewDelegate>

@property(nonatomic,strong) PageView *pageView;
@property(nonatomic,strong) PageOneView *oneView;
@property(nonatomic,strong) PageOneView *twoView;

@end

