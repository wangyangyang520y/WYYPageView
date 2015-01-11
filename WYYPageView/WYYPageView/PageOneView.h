//
//  PageOneView.h
//  WYYPageView
//
//  Created by wangyangyang on 15/1/11.
//  Copyright (c) 2015年 wangyangyang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetalViewConroller.h"
@class MyTableView,MyScrollView;

@interface PageOneView : UIView<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong) MyTableView *tableView;
@property(nonatomic,strong) MyScrollView *scrollView;

@property(nonatomic,strong) DetalViewConroller *detailViewController;
@end

@interface MyTableView : UITableView<UIGestureRecognizerDelegate>

@end

@interface MyScrollView : UIScrollView<UIGestureRecognizerDelegate>

@end