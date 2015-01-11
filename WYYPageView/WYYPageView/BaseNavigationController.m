//
//  BaseNavigationController.m
//  WYYPageView
//
//  Created by wangyangyang on 15/1/11.
//  Copyright (c) 2015年 wangyangyang. All rights reserved.
//

#import "BaseNavigationController.h"

@implementation BaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate = self;
    animatedTransition = [[AnimatedTransitioning alloc] init];
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panHandle:)];
    [self.view addGestureRecognizer:pan];
}

-(void)panHandle:(UIPanGestureRecognizer *)gesture
{
    float translation = [gesture translationInView:gesture.view].x;
    float progress = translation/self.view.bounds.size.width;
    
    if (gesture.state == UIGestureRecognizerStateBegan) {
        interactiveTransition = [[UIPercentDrivenInteractiveTransition alloc] init];
        [self popViewControllerAnimated:YES];
    }else if (gesture.state == UIGestureRecognizerStateChanged){
        [interactiveTransition updateInteractiveTransition:progress];
    }else if (gesture.state == UIGestureRecognizerStateCancelled || gesture.state == UIGestureRecognizerStateEnded){
        
        if (fabsf([gesture velocityInView:gesture.view].x)>1000) {
            float v_x = [gesture velocityInView:gesture.view].x;
            if (v_x>0) {
                [animatedTransition setIsPopSuccess:YES];
                [interactiveTransition finishInteractiveTransition];
            }else{
                [animatedTransition setIsPopSuccess:NO];
                [interactiveTransition cancelInteractiveTransition];
            }
        }else{
            if (progress>1.0/3.0) {
                [animatedTransition setIsPopSuccess:YES];
                [interactiveTransition finishInteractiveTransition];
            }else{
                [animatedTransition setIsPopSuccess:NO];
                [interactiveTransition cancelInteractiveTransition];
            }
        }
        interactiveTransition = nil;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma marks UINavigationControllerDelegate
-(id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC
{
    [animatedTransition setOperation:operation];
    return animatedTransition;
}

-(id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController
{
    return interactiveTransition;
}
@end

@implementation AnimatedTransitioning

-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 0.5;
}

-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIView *containerView = [transitionContext containerView];
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    CGRect fromVCRect = fromVC.view.frame;
    CGRect toVCRect = toVC.view.frame;
    
    float width = [UIScreen mainScreen].bounds.size.width;
    float fromVC_final_X = 0.0;
    
    if (self.operation == UINavigationControllerOperationPush) {
        fromVC_final_X = -2.0/3.0*width;
        toVC.view.frame = CGRectMake(width, 0, toVCRect.size.width, toVCRect.size.height);
        [containerView addSubview:toVC.view];
    }
    
    if (self.operation == UINavigationControllerOperationPop) {
        fromVC_final_X = width;
        toVC.view.frame = CGRectMake(-2.0/3.0*width, 0, toVCRect.size.width, toVCRect.size.height);
        [containerView insertSubview:toVC.view belowSubview:fromVC.view];
    }
    
    if (fromVC_final_X==0.0) {
        return;
    }
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext]  animations:^{
        fromVC.view.frame = CGRectMake(fromVC_final_X, 0, fromVCRect.size.width, fromVCRect.size.height);
        toVC.view.frame = CGRectMake(0, 0,toVCRect.size.width, toVCRect.size.height);
    } completion:^(BOOL finished) {
        if (self.operation == UINavigationControllerOperationPop) {
            [transitionContext completeTransition:self.isPopSuccess];
        }
        if (self.operation == UINavigationControllerOperationPush) {
            [transitionContext completeTransition:YES];
        }
    }];
}

@end
