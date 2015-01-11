//
//  AppDelegate.h
//  WYYPageView
//
//  Created by wangyangyang on 15/1/2.
//  Copyright (c) 2015年 wangyangyang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"
#import "BaseNavigationController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>


@property(strong,nonatomic) ViewController *viewController;
@property (strong,nonatomic)BaseNavigationController *navController;

@property (strong, nonatomic) UIWindow *window;



@end

