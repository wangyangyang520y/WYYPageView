//
//  BaseNavigationController.h
//  WYYPageView
//
//  Created by wangyangyang on 15/1/11.
//  Copyright (c) 2015年 wangyangyang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AnimatedTransitioning;

@interface BaseNavigationController : UINavigationController<UINavigationControllerDelegate>
{
    UIPercentDrivenInteractiveTransition *interactiveTransition;
    AnimatedTransitioning *animatedTransition;
}
@end

@interface AnimatedTransitioning : NSObject<UIViewControllerAnimatedTransitioning>

@property(nonatomic,assign)BOOL isPopSuccess;
@property(nonatomic,assign)UINavigationControllerOperation operation;

@end
