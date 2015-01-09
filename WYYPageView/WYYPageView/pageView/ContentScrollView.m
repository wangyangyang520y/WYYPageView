//
//  PatientContentScrollView.m
//  MMP.iPhone.RMYY
//
//  Created by wangyangyang on 14/11/15.
//  Copyright (c) 2014年 wangyangyang. All rights reserved.
//

#import "ContentScrollView.h"
#import <objc/runtime.h>


@implementation ContentScrollView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

//-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
//{
//    {
//        [[self nextResponder] touchesBegan:touches withEvent:event];
//    }
//    [super touchesBegan:touches withEvent:event];
//}
//
//-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
//{
//    {
//        [[self nextResponder] touchesMoved:touches withEvent:event];
//    }
//    [super touchesMoved:touches withEvent:event];
//}

-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
//    if (!self.interceptGesgure) {
//        NSString *gestureClassName = [NSString stringWithUTF8String:object_getClassName(gestureRecognizer)];
//        NSString *gestureViewClassName = [NSString stringWithUTF8String:object_getClassName([touch.view superview])];
//        NSLog(@"className:%@",[NSString stringWithUTF8String:object_getClassName(gestureRecognizer)]);
//        NSLog(@"touchView:%@",[NSString stringWithUTF8String:object_getClassName(touch.view)]);
//    NSLog(@"touch的gesture数量：%ld",touch.gestureRecognizers.count);
//    NSLog(@"prePt:%f----pt:%f",[touch previousLocationInView:touch.view].x,[touch locationInView:touch.view].x);
    
    return YES;
}

-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
//    NSLog(@"gestureRecognizer.className:%@",[NSString stringWithUTF8String:object_getClassName(gestureRecognizer)]);
//    NSLog(@"otherGestureRecognizer.className:%@",[NSString stringWithUTF8String:object_getClassName(otherGestureRecognizer)]);
//    NSLog(@"otherGestureRecognizer.view.className:%@",[NSString stringWithUTF8String:object_getClassName(otherGestureRecognizer.view)]);
    if (self.pageLocation == firstLocation) {
        return YES;
    }
    return NO;
}


@end
