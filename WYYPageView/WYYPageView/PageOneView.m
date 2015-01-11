//
//  PageOneView.m
//  WYYPageView
//
//  Created by wangyangyang on 15/1/11.
//  Copyright (c) 2015年 wangyangyang. All rights reserved.
//

#import "PageOneView.h"
#import "AppDelegate.h"
#import "ContentScrollView.h"

@implementation PageOneView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.scrollView = [[MyScrollView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 200)];
        self.scrollView.pagingEnabled = YES;
        self.scrollView.delegate = self;
        [self.scrollView setShowsHorizontalScrollIndicator:NO];
        [self initScrollViewContent];
        
        self.tableView = [[MyTableView alloc] initWithFrame:CGRectMake(0, 2, self.frame.size.width, self.frame.size.height-2)];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        [self.tableView setShowsVerticalScrollIndicator:NO];
        [self addSubview:self.tableView];
        
        self.tableView.tableHeaderView = self.scrollView;
    }
    return self;
}

-(void)initScrollViewContent
{
    for (int i =0; i<3; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"00%d.jpg",i+1]]];
        imageView.frame = CGRectMake(i*self.frame.size.width, 0, self.frame.size.width, 200);
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        imageView.userInteractionEnabled = YES;
        [self.scrollView addSubview:imageView];
    }
    self.scrollView.contentSize = CGSizeMake(self.frame.size.width*3, 200);
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"第%ld行新闻",indexPath.row+1];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (!self.detailViewController) {
        self.detailViewController = [[DetalViewConroller alloc] init];
    }
    AppDelegate *app = [UIApplication sharedApplication].delegate;
    [app.navController pushViewController:self.detailViewController animated:YES];
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [ContentScrollView setIsCanReceiveGesture:YES];
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [ContentScrollView setIsCanReceiveGesture:YES];
}

@end


@implementation MyTableView

-(BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    if ([self.gestureRecognizers containsObject:gestureRecognizer]) {
        [ContentScrollView setIsCanReceiveGesture:NO];
    }
    return YES;
}

-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    if(gestureRecognizer.state == UIGestureRecognizerStateEnded){
        [ContentScrollView setIsCanReceiveGesture:YES];
    }
    NSLog(@"gesture---state:%ld",gestureRecognizer.state);
    return NO;
}

@end

@implementation MyScrollView

-(BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    if ([self.gestureRecognizers containsObject:gestureRecognizer]) {
        [ContentScrollView setIsCanReceiveGesture:NO];
    }
    return YES;
}

-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return NO;
}

@end