//
//  PatientContentScrollView.h
//  MMP.iPhone.RMYY
//
//  Created by wangyangyang on 14/11/15.
//  Copyright (c) 2014年 wangyangyang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    firstLocation,
    noneLocation,
    lastLocation
}PageLocation;



@interface ContentScrollView : UIScrollView<UIGestureRecognizerDelegate>

@property(nonatomic,assign)PageLocation pageLocation;

@end
