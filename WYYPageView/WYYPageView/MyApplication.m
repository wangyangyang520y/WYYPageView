//
//  MyApplication.m
//  WYYPageView
//
//  Created by wangyangyang on 15/1/7.
//  Copyright (c) 2015年 wangyangyang. All rights reserved.
//

#import "MyApplication.h"

@implementation MyApplication


//次方法是在hittest确定具体的响应对象后，然后被调用，把event发送到处理的对象上
//hittest的方法在被调用的时候event是还没有包装好的，调用此方法的时候event已经包装好了
//利用次方法可以拦截事件，然后做相应的处理，常见的是发送通知
-(void)sendEvent:(UIEvent *)event
{
    if (event.type==UIEventTypeTouches) {
//        if ([[event.allTouches anyObject] phase]==UITouchPhaseBegan) {
//            UITouch *touch = [[event allTouches] anyObject];
//            CGPoint prePt = [touch previousLocationInView:touch.view];
//            CGPoint pt = [touch locationInView:touch.view];
//            if (prePt.x-pt.x<0) {
                //响应触摸事件（手指刚刚放上屏幕）
//                [[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:@"interceptNotice" object:nil userInfo:[NSDictionary dictionaryWithObject:event forKey:@"data"]]];
                //发送一个名为‘nScreenTouch’（自定义）的事件
//            }
//        }
    }
    [super sendEvent:event];
}



@end
