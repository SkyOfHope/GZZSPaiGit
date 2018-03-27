//
//  GZZLoadingView.m
//  GZZSPai
//
//  Created by jiangkuiquan on 2018/3/19.
//  Copyright © 2018年 skye. All rights reserved.
//

#import "GZZLoadingView.h"

@implementation GZZLoadingView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
+(BOOL)hideLoadingViewFromView:(UIView *)view{
    NSEnumerator *subviewsEnum = [view.subviews reverseObjectEnumerator];
    for (UIView *subview in subviewsEnum) {
        if ([subview isKindOfClass:self]) {
            [subview removeFromSuperview];
            return YES;
        }
    }
    
    return NO;
}

+(BOOL)showLoadingViewToView:(UIView *)view WithFrame:(CGRect)frame{
    GZZLoadingView *loadingView = [[GZZLoadingView alloc] initWithFrame:frame];
    loadingView.backgroundColor = [UIColor whiteColor];
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    indicator.center = CGPointMake(frame.size.width / 2, frame.size.height / 2 - 100);
    [indicator startAnimating];
    [loadingView addSubview:indicator];
    [view addSubview:loadingView];
    
    return YES;
}

@end
