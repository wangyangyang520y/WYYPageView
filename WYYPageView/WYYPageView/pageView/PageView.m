//
//  PageViewBase.m
//  MMP.iPhone.RMYY
//
//  Created by wangyangyang on 14/11/11.
//  Copyright (c) 2014年 wangyangyang. All rights reserved.
//

#import "PageView.h"
#import "AppDelegate.h"




@implementation PageView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        [self initNavigationView];
        
        self.pageMenueView = [[ContentScrollView alloc] initWithFrame:CGRectMake(0, self.navigationView.frame.origin.y+self.navigationView.frame.size.height, frame.size.width, pageMenueHeight)];
        [self addSubview:self.pageMenueView];
        self.pageMenueView.delegate = self;
        [self.pageMenueView setShowsHorizontalScrollIndicator:NO];
        [self.pageMenueView setShowsVerticalScrollIndicator:YES];
        
        self.pageContentScrollView = [[ContentScrollView alloc] initWithFrame:CGRectMake(0, self.pageMenueView.frame.origin.y+self.pageMenueView.frame.size.height, frame.size.width, frame.size.height-self.pageMenueView.frame.size.height)];
        [self addSubview:self.pageContentScrollView];
        self.pageContentScrollView.delegate = self;
        [self.pageContentScrollView setShowsHorizontalScrollIndicator:NO];
        [self.pageContentScrollView setShowsVerticalScrollIndicator:NO];
        [self.pageContentScrollView setBounces:NO];
        self.pageContentScrollView.pagingEnabled = YES;

        self.lineView = [[UIView alloc] initWithFrame:CGRectMake(0, self.pageMenueView.frame.origin.y+self.pageMenueView.frame.size.height-0.5, frame.size.width, 0.5)];
        self.lineView.backgroundColor = [UIColor colorWithRed:171/255.0 green:171/255.0 blue:171/255.0 alpha:1.0];
        [self addSubview:self.lineView];
        
        self.coverView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        self.coverView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
        
        self.leftView = [[UIView alloc] initWithFrame:CGRectMake(-leftViewWidth, 0, leftViewWidth,leftViewHeigth )];
        self.leftView.backgroundColor = [UIColor blueColor];
        [self addSubview:self.leftView];
        
        self.pageMenueBtns = [[NSMutableArray alloc] init];
        self.pageContents = [[NSMutableArray alloc] init];
        
        
        
//        leftViewSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(leftSwipe:)];
//        [leftViewSwipe setDirection:UISwipeGestureRecognizerDirectionRight];
        
        leftViewPan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(nLeftPan:)];
        
//        [leftViewPan requireGestureRecognizerToFail:leftViewSwipe];
        
//        [self addGestureRecognizer:leftViewSwipe];
        [self addGestureRecognizer:leftViewPan];
        
        
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(leftTap:)];
        tap.numberOfTapsRequired =1;
        tap.numberOfTouchesRequired = 1;
        [self.coverView addGestureRecognizer:tap];
        
        
        
        [self initPt];
        [self initState];
    
    }
    return self;
}

-(void)initNavigationView
{
    AppDelegate *app = [UIApplication sharedApplication].delegate;
    float navHeight = app.navController.navigationBar.frame.size.height;
    float statusBarHeight = [[UIApplication sharedApplication] statusBarFrame].size.height;
    NSLog(@"navHeight :------%f",navHeight);
    self.navigationView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, navHeight+statusBarHeight)];
    self.navigationView.backgroundColor = [UIColor redColor];
    [self addSubview:self.navigationView];
    
    self.navigationTitle = [[UILabel alloc] init];
    self.navigationTitle.text = @"仿网易客户端";
    [self.navigationTitle setTextAlignment:NSTextAlignmentCenter];
    [self.navigationTitle setTextColor:[UIColor whiteColor]];
    [self.navigationTitle setFont:[UIFont systemFontOfSize:20]];
    self.navigationTitle.frame = CGRectMake(0, 0, 200, 30);
    self.navigationTitle.center = CGPointMake(self.navigationView.center.x, self.navigationView.center.y+10);
    [self.navigationView addSubview:self.navigationTitle];
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 25, 25)];
    [btn setTitle:@"lt" forState:UIControlStateNormal];
    btn.layer.borderWidth = 1;
    btn.layer.borderColor = [[UIColor whiteColor] CGColor];
    btn.layer.cornerRadius = 10;
    btn.center = CGPointMake(25, self.navigationView.center.y+10);
    [btn addTarget:self action:@selector(leftBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationView addSubview:btn];
}

-(void)initPt
{
    firstPt = CGPointZero;
    prePt = CGPointZero;
    nowPt = CGPointZero;
    isIntercept = YES;
}

-(void)initState
{
    self.leftViewState = hidden;
}

-(void)leftBtnAction:(UIButton *)sender
{
    if (self.leftViewState!=hidden) {
        return;
    }
    if(![self.coverView superview]){
        [self insertSubview:self.coverView belowSubview:self.leftView];
    }
    [UIView animateWithDuration:animationDuration animations:^{
        self.leftView.frame = CGRectMake(0, 0, self.leftView.frame.size.width, self.leftView.frame.size.height);
        self.coverView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:coverAlpha];
    } completion:^(BOOL finished) {
        self.leftViewState = show;
    }];
    
}

//-(UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
//{
//    hitEvent = event;
//    hitPt = point;
//    if (isIntercept) {
//        return self;
//    }else{
//        return [super hitTest:point withEvent:event];
//    }
//}
//-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
//{
//    NSLog(@"touchbegan------");
//}

//-(void)leftSwipe:(UISwipeGestureRecognizer *)gesture
//{
//    if (self.leftViewState!=hidden) {
//        return;
//    }
//
//    if (gesture.state == UIGestureRecognizerStateCancelled || gesture.state == UIGestureRecognizerStateEnded ) {
//        [self insertSubview:self.coverView belowSubview:self.leftView];
//        [UIView animateWithDuration:animationDuration animations:^{
//            self.leftView.frame = CGRectMake(0, 0, self.leftView.frame.size.width, self.leftView.frame.size.height);
//            self.coverView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:coverAlpha];
//        } completion:^(BOOL finished) {
//            self.leftViewState = show;
//        }];
//    }
//    
//}


-(void)nLeftPan:(UIPanGestureRecognizer *)gesture
{
    
    float v_x = [gesture velocityInView:gesture.view].x;
    if (gesture.state == UIGestureRecognizerStateBegan || gesture.state == UIGestureRecognizerStatePossible) {
        [self initPt];
    }
    nowPt = [gesture locationInView:gesture.view];
    if (firstPt.x == CGPointZero.x && firstPt.y == CGPointZero.y) {
        firstPt = nowPt;
        prePt = nowPt;
    }

    
    if (self.leftViewState==hidden && nowPt.x-firstPt.x>0) {
        self.leftViewState = h_middle;
    }
    if (self.leftViewState ==show && nowPt.x - firstPt.x < 0) {
        self.leftViewState = s_middle;
    }
    
    float newX;
    
    if (self.leftView.frame.origin.x+nowPt.x-prePt.x<-leftViewWidth) {
        newX = -leftViewWidth;
    }else if (self.leftView.frame.origin.x+nowPt.x-prePt.x>0){
        newX = 0;
    }else{
        newX = self.leftView.frame.origin.x+nowPt.x-prePt.x;
    }
    
    if (![self.coverView superview]) {
        [self insertSubview:self.coverView belowSubview:self.leftView];
    }
    
    if ((self.leftViewState == hidden || self.leftViewState ==h_middle) ) {
        
        float allXMove = nowPt.x-firstPt.x>leftViewWidth?leftViewWidth:nowPt.x-firstPt.x;
    
        self.leftView.frame = CGRectMake(newX, 0, self.leftView.frame.size.width, self.leftView.frame.size.height);
        self.coverView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:coverAlpha*(allXMove/leftViewWidth)];
        
        if(nowPt.x-firstPt.x<=leftViewWidth){
            prePt = nowPt;
        }
    }
    
    if ((self.leftViewState == show ||self.leftViewState == s_middle)) {
        
        float allXMove = firstPt.x-nowPt.x>leftViewWidth?leftViewWidth:firstPt.x-nowPt.x;
        
        self.leftView.frame = CGRectMake(newX, 0, self.leftView.frame.size.width, self.leftView.frame.size.height);
        self.coverView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:coverAlpha*(1-allXMove/leftViewWidth)];
        
        if (firstPt.x-nowPt.x<=leftViewWidth) {
            prePt = nowPt;
        }
    }
    
    if (gesture.state == UIGestureRecognizerStateCancelled || gesture.state == UIGestureRecognizerStateEnded) {
        
            if (self.leftViewState == h_middle && nowPt.x-firstPt.x<0) {
                if ([self.coverView superview]) {
                    [self.coverView removeFromSuperview];
                }
                self.leftViewState = hidden;
                return;
            }
        
        if (fabsf(v_x)>1000) {
            
            CGPoint v = [gesture velocityInView:gesture.view];
            float magnitude = sqrtf(v.x*v.x + v.y*v.y);
//            float slideMult = magnitude / 1000;
//            NSLog(@"magnitude: %f, slideMult: %f", magnitude, slideMult);
            NSLog(@"magnitude: %f", magnitude);
            float duration;
            if(v_x > 0){
                duration  = fabsf(self.leftView.frame.origin.x)/(magnitude/2);
            }
            
            if (duration<0) {
                duration = (self.leftView.frame.origin.x+leftViewWidth)/(magnitude/2);
            }
            
            NSLog(@"duration: %f", duration);
            
            [UIView animateWithDuration:duration delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
                self.leftView.frame = CGRectMake(v_x>0?0:-leftViewWidth, 0, self.leftView.frame.size.width, self.leftView.frame.size.height);
                self.coverView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:v_x>0?coverAlpha:0];
            } completion:^(BOOL finished) {
                self.leftViewState = v_x>0?show:hidden;
            }];

        }else{
            float x = self.leftView.frame.origin.x;
            if (x<-leftViewWidth/2) {
                [UIView animateWithDuration:animationDuration/2 animations:^{
                    self.leftView.frame = CGRectMake(-leftViewWidth, 0, self.leftView.frame.size.width, self.leftView.frame.size.height);
                    self.coverView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
                } completion:^(BOOL finished) {
                    [self.coverView removeFromSuperview];
                    self.leftViewState = hidden;
                }];
            }else{
                [UIView animateWithDuration:animationDuration/2 animations:^{
                    self.leftView.frame = CGRectMake(0, 0, self.leftView.frame.size.width, self.leftView.frame.size.height);
                    self.coverView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:coverAlpha];
                } completion:^(BOOL finished) {
                    self.leftViewState = show;
                }];
            }
        }
        
    }
    
}

-(void)leftPan:(UIPanGestureRecognizer *)gesture
{
    if (self.leftViewState==hidden) {
        self.leftViewState = h_middle;
    }
    if (self.leftViewState ==show) {
        self.leftViewState = s_middle;
    }
    float v_x = [gesture velocityInView:gesture.view].x;
//    NSLog(@"pan的速度：%f",fabsf(v_x) );
    if (gesture.state == UIGestureRecognizerStateBegan || gesture.state == UIGestureRecognizerStatePossible) {
        [self initPt];
    }
    
    nowPt = [gesture locationInView:gesture.view];
    if (firstPt.x == CGPointZero.x && firstPt.y == CGPointZero.y) {
        firstPt = nowPt;
        prePt = nowPt;
    }
    
    
    if ((self.leftViewState == hidden || self.leftViewState ==h_middle) && nowPt.x-firstPt.x>0) {
        
        float allXMove = nowPt.x-firstPt.x>leftViewWidth?leftViewWidth:nowPt.x-firstPt.x;
        
        if (![self.coverView superview]) {
            [self insertSubview:self.coverView belowSubview:self.leftView];
        }

        self.leftView.frame = CGRectMake(self.leftView.frame.origin.x+nowPt.x-prePt.x>0?0:self.leftView.frame.origin.x+nowPt.x-prePt.x, 0, self.leftView.frame.size.width, self.leftView.frame.size.height);
        self.coverView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:coverAlpha*(allXMove/leftViewWidth)];
        
        if(nowPt.x-firstPt.x<=leftViewWidth){
            prePt = nowPt;
        }
        
        if (gesture.state == UIGestureRecognizerStateCancelled || gesture.state == UIGestureRecognizerStateEnded) {
            
            if (fabsf(v_x)>1000) {
                [UIView animateWithDuration:animationDuration*(1-allXMove/leftViewWidth) animations:^{
                    self.leftView.frame = CGRectMake(0, 0, self.leftView.frame.size.width, self.leftView.frame.size.height);
                    self.coverView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:coverAlpha];
                } completion:^(BOOL finished) {
                    self.leftViewState = show;
                }];
                return;
            }
            
            
            float x ;
            if (allXMove>leftViewWidth/2) {
                x = 0;
            }else{
                x = -leftViewWidth;
            }
            
            [UIView animateWithDuration:animationDuration*(x==0?1-allXMove/leftViewWidth:allXMove/leftViewWidth) animations:^{
                self.leftView.frame = CGRectMake(x, 0, self.leftView.frame.size.width, self.leftView.frame.size.height);
                self.coverView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:coverAlpha*(x/leftViewWidth+1)];
            } completion:^(BOOL finished) {
                if (x!=0) {
                    [self.coverView removeFromSuperview];
                    self.leftViewState = hidden;
                }else {
                    self.leftViewState = show;
                }
            }];
//            if(self.leftView.frame.origin.x==0){
//                leftViewState = show;
//            }
//            if(self.leftView.frame.origin.x == -leftViewWidth){
//                [self.coverView removeFromSuperview];
//                leftViewState = hidden;
//            }
            [self initPt];
        }
    }
    
    if ((self.leftViewState == show ||self.leftViewState == s_middle)&& nowPt.x-firstPt.x<0) {
        
        float allXMove = firstPt.x-nowPt.x>leftViewWidth?leftViewWidth:firstPt.x-nowPt.x;
        
        self.leftView.frame = CGRectMake(self.leftView.frame.origin.x+nowPt.x-prePt.x<-leftViewWidth?-leftViewWidth:self.leftView.frame.origin.x+nowPt.x-prePt.x, 0, self.leftView.frame.size.width, self.leftView.frame.size.height);
        self.coverView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:coverAlpha*(1-allXMove/leftViewWidth)];
        
//        NSLog(@"leftView的x:%f",self.leftView.frame.origin.x);
        
        if (firstPt.x-nowPt.x<=leftViewWidth) {
            prePt = nowPt;
        }
        
        if (gesture.state == UIGestureRecognizerStateCancelled || gesture.state == UIGestureRecognizerStateEnded) {
            
            if (fabsf(v_x)>1000) {
                [UIView animateWithDuration:animationDuration*(1-allXMove/leftViewWidth) animations:^{
                    self.leftView.frame = CGRectMake(-leftViewWidth, 0, self.leftView.frame.size.width, self.leftView.frame.size.height);
                    self.coverView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
                } completion:^(BOOL finished) {
                    [self.coverView removeFromSuperview];
                    self.leftViewState = hidden;
                }];
                return;
            }
            
            
            float x ;
            if (firstPt.x-nowPt.x>leftViewWidth/2) {
                x = -leftViewWidth;
            }else{
                x = 0;
            }
            [UIView animateWithDuration:animationDuration*(x==0?allXMove/leftViewWidth:1-allXMove/leftViewWidth) animations:^{
                self.leftView.frame = CGRectMake(x, 0, self.leftView.frame.size.width, self.leftView.frame.size.height);
                self.coverView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:coverAlpha*(x/leftViewWidth+1)];
            } completion:^(BOOL finished) {
                if (x!=0) {
                    [self.coverView removeFromSuperview];
                    self.leftViewState = hidden;
                }else {
                    self.leftViewState = show;
                }
            }];
//            NSLog(@"leftView的frame.x：%f",self.leftView.frame.origin.x);
//            NSLog(@"leftView的-leftViewWidth：%f",-leftViewWidth);
//            if(self.leftView.frame.origin.x==0){
//                leftViewState = show;
//            }
//            if(self.leftView.frame.origin.x == -leftViewWidth){
//                [self.coverView removeFromSuperview];
//                leftViewState = hidden;
//            }
            [self initPt];
        }
    }
    
    
}


-(void)leftTap:(UITapGestureRecognizer *)gesture
{
    [UIView animateWithDuration:animationDuration animations:^{
        self.leftView.frame = CGRectMake(-self.leftView.frame.size.width, 0, self.leftView.frame.size.width, self.leftView.frame.size.height);
        self.coverView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
    } completion:^(BOOL finished) {
        [self.coverView removeFromSuperview];
        self.leftViewState = hidden;
    }];
}

-(void)autoDispalyPageMenueTitles:(NSArray *)pageMenueTitles
{
    _pageMenueTitles = pageMenueTitles;
    pageViewState = autonamic;
    UILabel *preBtn;
    UIView *preView;
    if (!self.titleFont) {
        self.titleFont = [UIFont fontWithName:@"Heiti SC" size:16];
    }
    if (!self.titleCommonColor) {
        self.titleCommonColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:1];
    }
    for (int i=0; i<_pageMenueTitles.count; i++) {
        UILabel *btn = [[UILabel alloc] init];
        btn.userInteractionEnabled = YES;
        btn.text = _pageMenueTitles[i];
        btn.textColor = self.titleCommonColor;
        [btn setFont:self.titleFont];
        [btn setTextAlignment:NSTextAlignmentCenter];
        btn.tag = i;
        float width = [self getWidthOflabelText:btn];
        btn.frame = CGRectMake(preBtn==nil?pageMenueBtnMarginLeft:preBtn.frame.size.width+preBtn.frame.origin.x+pageMenueBtnGap, (pageMenueHeight-pageMenueBtnHeightS)/2, width, pageMenueBtnHeightS);
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(btnClick:)];
        tap.numberOfTapsRequired = 1;
        tap.numberOfTouchesRequired = 1;
        [btn addGestureRecognizer:tap];
        preBtn = btn;
        [self.pageMenueView addSubview:btn];
        [self.pageMenueBtns addObject:btn];
        
        UIView *view = [[UIView alloc] init];
        view.tag = i;
        view.frame = CGRectMake(preView==nil?pageContentMarginLeft:preView.frame.size.width+preView.frame.origin.x+pageContentMarginLeft*2, 0, self.frame.size.width-2*pageContentMarginLeft, self.pageContentScrollView.frame.size.height);
        preView = view;
        [self.pageContentScrollView addSubview:view];
        [self.pageContents addObject:view];
    }
    self.pageMenueView.contentSize = CGSizeMake(preBtn.frame.size.width+preBtn.frame.origin.x+pageMenueBtnMarginLeft, pageMenueHeight);
    self.pageContentScrollView.contentSize = CGSizeMake(preView.frame.size.width+preView.frame.origin.x+pageContentMarginLeft, self.pageContentScrollView.frame.size.height);
    [self initSelected];
}

-(void)fixPageMenueTitles:(NSArray *)pageMenueTitles withFixWidth:(float)width
{
    _pageMenueTitles = pageMenueTitles;
    pageViewState = fix;
    NSInteger count = _pageMenueTitles.count;
    if (self.frame.size.width/count<width) {
        return;
    }
    float btnMargin = (self.frame.size.width/count-width)/2;
    UILabel *preBtn;
    UIView *preView;
    if (!self.titleFont) {
        self.titleFont = [UIFont fontWithName:@"Heiti SC" size:16];
    }
    if (!self.titleCommonColor) {
        self.titleCommonColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:1];
    }
    for (int i=0; i<_pageMenueTitles.count; i++) {
        UILabel *btn = [[UILabel alloc] init];
        btn.userInteractionEnabled = YES;
        btn.text = _pageMenueTitles[i];
        btn.textColor = self.titleCommonColor;
        [btn setFont:self.titleFont];
        [btn setTextAlignment:NSTextAlignmentCenter];
        btn.tag = i;
        btn.frame = CGRectMake(preBtn==nil?btnMargin:preBtn.frame.size.width+preBtn.frame.origin.x+btnMargin*2, (pageMenueHeight-pageMenueBtnHeightS)/2, width, pageMenueBtnHeightS);
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(btnClick:)];
        tap.numberOfTapsRequired = 1;
        tap.numberOfTouchesRequired = 1;
        [btn addGestureRecognizer:tap];
        preBtn = btn;
        [self.pageMenueView addSubview:btn];
        [self.pageMenueBtns addObject:btn];
        
        UIView *view = [[UIView alloc] init];
        view.tag = i;
        view.frame = CGRectMake(preView==nil?pageContentMarginLeft:preView.frame.size.width+preView.frame.origin.x+pageContentMarginLeft*2, 0, self.frame.size.width-2*pageContentMarginLeft, self.pageContentScrollView.frame.size.height);
        preView = view;
        [self.pageContentScrollView addSubview:view];
        [self.pageContents addObject:view];
    }
    self.pageMenueView.contentSize = CGSizeMake(preBtn.frame.size.width+preBtn.frame.origin.x+pageMenueBtnMarginLeft, pageMenueHeight);
    self.pageContentScrollView.contentSize = CGSizeMake(preView.frame.size.width+preView.frame.origin.x+pageContentMarginLeft, self.pageContentScrollView.frame.size.height);
    [self initSelected];
}

-(void)initSelected
{
    UILabel *btn = self.pageMenueBtns[0];
    btn.transform = CGAffineTransformMakeScale(scaleBigValue, scaleBigValue);
    if (!self.titleSelectedColor) {
        self.titleSelectedColor = [UIColor colorWithRed:74/255.0 green:158/255.0 blue:184/255.0 alpha:1.0];
    }
    [btn setTextColor:self.titleSelectedColor];
    self.currentIndex = 0;
    preContentOffsetX = 0;
    
    if ([self.pageViewDelegate respondsToSelector:@selector(pageViewLoadContentView)]) {
        [self.pageViewDelegate pageViewLoadContentView];
    }
}

-(float)getWidthOflabelText:(UILabel *)label
{
    
    // label的字体 HelveticaNeue  Courier
    label.font = self.titleFont;
    label.numberOfLines = 1;
    label.lineBreakMode = NSLineBreakByWordWrapping;
    // iOS7中用以下方法替代过时的iOS6中的sizeWithFont:constrainedToSize:lineBreakMode:方法
    CGRect tmpRect = [label.text boundingRectWithSize:CGSizeMake(150, pageMenueBtnHeightS) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObjectsAndKeys:self.titleFont,NSFontAttributeName, nil] context:nil];
//    NSLog(@"字的宽度:%f",tmpRect.size.width);
    return tmpRect.size.width;
}

-(void)btnChangeAnimation:(UILabel *)currentBtn next:(UILabel *)nextBtn andScale:(float)scaleValue
{
    if (!self.commonRgb) {
        self.commonRgb = [[ColorRgb alloc] init];
        [self.commonRgb getRgb:self.titleCommonColor];
    }
    if (!self.selectedRgb) {
        self.selectedRgb = [[ColorRgb alloc] init];
        [self.selectedRgb getRgb:self.titleSelectedColor];
    }
    
    [UIView animateWithDuration:0.1 animations:^{
        currentBtn.transform = CGAffineTransformMakeScale(scaleBigValue-scaleValue, scaleBigValue-scaleValue);
        currentBtn.textColor = [UIColor colorWithRed:(self.selectedRgb.R-(self.selectedRgb.R-self.commonRgb.R)*scaleValue*colorScaleValue)/255.0 green:(self.selectedRgb.G-(self.selectedRgb.G-self.commonRgb.G)*scaleValue*colorScaleValue)/255.0 blue:(self.selectedRgb.B-(self.selectedRgb.B-self.commonRgb.B)*scaleValue*colorScaleValue)/255.0 alpha:1.0];
        nextBtn.transform = CGAffineTransformMakeScale(1.0+scaleValue, 1.0+scaleValue);
        nextBtn.textColor = [UIColor colorWithRed:(self.commonRgb.R-(self.commonRgb.R-self.selectedRgb.R)*scaleValue*colorScaleValue)/255.0 green:(self.commonRgb.G-(self.commonRgb.G-self.selectedRgb.G)*scaleValue*colorScaleValue)/255.0 blue:(self.commonRgb.B-(self.commonRgb.B-self.selectedRgb.B)*scaleValue*colorScaleValue)/255.0 alpha:1.0];
    } completion:^(BOOL finished) {
        
    }];
}

-(void)btnClick:(UITapGestureRecognizer *)gesture
{
    if ((int)self.pageContentScrollView.contentOffset.x%(int)self.pageContentScrollView.frame.size.width!=0) {
        return;
    }
    float index= self.pageContentScrollView.contentOffset.x/self.pageContentScrollView.frame.size.width;
    UILabel *currenBtn = self.pageMenueBtns[(int)index];
    [self.pageContentScrollView setContentOffset:CGPointMake(self.pageContentScrollView.frame.size.width*gesture.view.tag, 0)];
    [self btnChangeAnimation:currenBtn next:(UILabel *)gesture.view andScale:scaleBigValue-1.0];
    
    [self changePageMenueViewContentOffset];
    
    if ([self.pageViewDelegate respondsToSelector:@selector(pageViewLoadContentView)]) {
        [self.pageViewDelegate pageViewLoadContentView];
    }
    
}

-(void)changePageMenueViewContentOffset
{
    if(pageViewState==autonamic){
        float index = self.pageContentScrollView.contentOffset.x/self.pageContentScrollView.frame.size.width;
        UILabel *titleLabel = self.pageMenueBtns[(int)index];
        float X = titleLabel.frame.origin.x+titleLabel.frame.size.width/2;
        if (X>self.pageMenueView.frame.size.width/2 && self.pageMenueView.contentOffset.x+self.pageMenueView.frame.size.width<self.pageMenueView.contentSize.width) {
            float newX ;
            if (X-self.pageMenueView.frame.size.width/2>self.pageMenueView.contentSize.width-self.pageMenueView.contentOffset.x-self.pageMenueView.frame.size.width) {
                newX = self.pageMenueView.contentSize.width-self.pageMenueView.frame.size.width;
            }else{
                newX = X-self.pageMenueView.frame.size.width/2;
            }
            [self.pageMenueView setContentOffset:CGPointMake(newX, 0) animated:YES];
        }
        X = [self getOriginInRootView:titleLabel].x+titleLabel.frame.size.width/2;
        if (X<self.pageMenueView.frame.size.width/2 && self.pageMenueView.contentOffset.x>0) {
            float newX;
            if (self.pageMenueView.frame.size.width/2-X>self.pageMenueView.contentOffset.x) {
                newX = 0;
            }else{
                newX = self.pageMenueView.contentOffset.x - (self.pageMenueView.frame.size.width/2-X);
            }
            [self.pageMenueView setContentOffset:CGPointMake(newX, 0) animated:YES];
        }
    }
}

- (CGPoint)getOriginInRootView:(UIView *)view
{
    float x = 0;
    float y = 0;
    
    for (UIResponder *responder = view ; responder; responder = [responder nextResponder]) {
        if (![[responder nextResponder] isKindOfClass:[UIViewController class]]) {
            x = x + ((UIView *)responder).frame.origin.x;
            y = y + ((UIView *)responder).frame.origin.y;
            if ([[responder nextResponder] isKindOfClass:[UIScrollView class]]) {
                UIScrollView *scrollView = (UIScrollView *)[responder nextResponder];
                y = y-scrollView.contentOffset.y;
                x = x-scrollView.contentOffset.x;
            }
        }else{
            break;
        }
    }
    return  CGPointMake(x, y);
}

-(void)setLeftViewState:(LeftViewState)leftViewState
{
    if (leftViewState==hidden) {
        _leftViewState = leftViewState;
        self.pageContentScrollView.scrollEnabled = YES;
        [self.coverView removeFromSuperview];
    }
    if (leftViewState == h_middle || leftViewState == s_middle) {
        _leftViewState = leftViewState;
        self.pageContentScrollView.scrollEnabled = NO;
    }
    if (leftViewState == show) {
        _leftViewState = leftViewState;
        self.pageContentScrollView.scrollEnabled = NO;
    }
    NSLog(@"scrollview status:%d",self.pageContentScrollView.scrollEnabled);
}


#pragma marks appearance setting

-(void)setLineColor:(UIColor *)lineColor
{
    _lineColor = lineColor;
    self.lineView.backgroundColor = _lineColor;
}



#pragma marks UIScrollViewDelegate

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    if ([scrollView isEqual:self.pageContentScrollView]) {
        float scrollViewWidth = scrollView.frame.size.width;
        if (scrollView.contentOffset.x<0) {
            return;
        }
        if (scrollView.contentOffset.x>(self.pageMenueBtns.count-1)*scrollViewWidth) {
            return;
        }
        float offsetX = scrollView.contentOffset.x;
        if ((int)offsetX % (int)scrollViewWidth == 0) {
            return;
        }
        NSInteger index = floorf(offsetX/scrollViewWidth);
        float scaleValue = fabsf((offsetX-index*self.frame.size.width)/self.frame.size.width*(scaleBigValue-1.0));
        UILabel *currentBtn;
        UILabel *nextBtn;
        if (offsetX>preContentOffsetX) {//向右滑动
            currentBtn = self.pageMenueBtns[index];
            nextBtn = self.pageMenueBtns[index+1];
            [self btnChangeAnimation:currentBtn next:nextBtn andScale:scaleValue];
        }
        if (offsetX<preContentOffsetX){//向左滑动
            currentBtn = self.pageMenueBtns[index+1];
            nextBtn = self.pageMenueBtns[index];
            [self btnChangeAnimation:currentBtn next:nextBtn andScale:(scaleBigValue-1.0)-scaleValue];
        }
        
        preContentOffsetX = scrollView.contentOffset.x;
        
    }
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if ([scrollView isEqual:self.pageContentScrollView]) {
        [self changePageMenueViewContentOffset];
    }
    if ([scrollView isEqual:self.pageContentScrollView]) {
        if([self.pageViewDelegate respondsToSelector:@selector(pageViewLoadContentView)]) {
            [self.pageViewDelegate pageViewLoadContentView];
        }
    }
}

-(void)setSrollViewPageLocation:(int)index
{
    if (index==0) {
        [self.pageContentScrollView setPageLocation:firstLocation];
    }else if(index == self.pageContents.count-1){
        [self.pageContentScrollView setPageLocation:lastLocation];
    }else{
        [self.pageContentScrollView setPageLocation:noneLocation];
    }
}



-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"interceptNotice" object:nil];
}

@end

@implementation ColorRgb

//此方法在获取[UIColor blackColor]的rgb的时候有问题，获取其他的都ok。所以在使用黑色的时候rgb的方式构造UIColor
-(void)getRgb:(UIColor *)color
{
    
    const CGFloat *components = CGColorGetComponents(color.CGColor);
    
    // 获取RGB颜色
    self.R = components[0]*255.0;
    self.G = components[1]*255.0;
    self.B =components[2]*255.0;
    self.A = components[3];
    NSLog(@"R:%f",self.R);
    NSLog(@"G:%f",self.G);
    NSLog(@"B:%f",self.B);
    NSLog(@"A:%f",self.A);
}

@end

