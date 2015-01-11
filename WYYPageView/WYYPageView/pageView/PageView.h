//
//  PageViewBase.h
//  MMP.iPhone.RMYY
//
//  Created by wangyangyang on 14/11/11.
//  Copyright (c) 2014年 wangyangyang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ContentScrollView.h"
@class ColorRgb;

#define pageMenueHeight 40.0
#define pageMenueBtnGap 30.0
#define pageMenueBtnMarginLeft 20.0
#define pageMenueBtnHeightS 20.0 
#define pageMenueBtnHeightB 35.0

#define pageContentMarginLeft 5.0

#define scaleBigValue 1.3
#define colorScaleValue (1.0/(scaleBigValue-1))


#define leftViewWidth (self.frame.size.width*2/3)
#define leftViewHeigth (self.frame.size.height)

#define animationDuration 0.3
#define coverAlpha 0.5
typedef enum {
    autonamic,
    fix
}PageViewState;

typedef enum {
    wait_hidden,
    hidden,
    h_middle,
    s_middle,
    show
}LeftViewState;

@protocol PageViewDelegate <NSObject>

-(void)pageViewLoadContentView;

@end

@interface PageView : UIView<UIScrollViewDelegate>
{
    BOOL isIntercept;
    
    PageViewState pageViewState;
    
    
    float preContentOffsetX;
    
    CGPoint hitPt;
    UIEvent *hitEvent;
    
    CGPoint firstPt;
    CGPoint prePt;
    CGPoint nowPt;
    
    UISwipeGestureRecognizer *leftViewSwipe;
    UIPanGestureRecognizer *leftViewPan;
}

@property(nonatomic,assign)LeftViewState leftViewState;

@property(nonatomic,strong)UIView *lineView;
@property(nonatomic,strong)UIColor *lineColor;

@property(nonatomic,strong)UIFont *titleFont;

@property(nonatomic,strong)UIColor *titleSelectedColor;
@property(nonatomic,strong)UIColor *titleCommonColor;

@property(nonatomic,strong)ColorRgb *commonRgb;
@property(nonatomic,strong)ColorRgb *selectedRgb;

@property(nonatomic,strong)UIView *navigationView;
@property(nonatomic,strong)UILabel *navigationTitle;

@property(nonatomic,strong)ContentScrollView *pageMenueView;
@property(nonatomic,strong)ContentScrollView *pageContentScrollView;

@property(nonatomic,strong)UIView *coverView;
@property(nonatomic,strong)UIView *leftView;
@property(nonatomic,strong)UIView *rightView;

@property(nonatomic,strong)NSArray *pageMenueTitles;
@property(nonatomic,strong)NSMutableArray *pageMenueBtns;
@property(nonatomic,strong)NSMutableArray *pageContents;

@property(nonatomic,assign)id<PageViewDelegate> pageViewDelegate;

@property(nonatomic,assign)NSInteger currentIndex;
-(void)autoDispalyPageMenueTitles:(NSArray *)pageMenueTitles;
-(void)fixPageMenueTitles:(NSArray *)pageMenueTitles withFixWidth:(float)width;

-(void)setSrollViewPageLocation:(int)index;
@end


@interface ColorRgb : NSObject

@property (nonatomic,assign)float R;
@property (nonatomic,assign)float G;
@property (nonatomic,assign)float B;
@property (nonatomic,assign)float A;

-(void)getRgb:(UIColor *)color;

@end


