//
//  GZZLoadingView.h
//  GZZSPai
//
//  Created by jiangkuiquan on 2018/3/19.
//  Copyright © 2018年 skye. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GZZLoadingView : UIView

//隐藏传入view中的loadingview
+(BOOL)hideLoadingViewFromView:(UIView *)view;
//为传入view显示一个loadingview
+(BOOL)showLoadingViewToView:(UIView *)view WithFrame:(CGRect)frame;

@end

NS_ASSUME_NONNULL_END
