//
//  HeaderView.h
//  GZZSPai
//
//  Created by jiangkuiquan on 2018/3/19.
//  Copyright © 2018年 skye. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HeaderViewDelegate<NSObject>
//导航右侧按钮的时间
-(void)BtnClicked;

@end

@interface HeaderView : UIView

@property (nonatomic, weak) id <HeaderViewDelegate> delegate;
//button参数可为空的初始化方法
-(instancetype)initWithTitle:(NSString *)title Button:(NSString *)button;

//scrollView的offset y值变化时，视图做相应的变化
-(void)viewScrolledByY:(float)Y;

//为messagView做特殊处理时调用
-(void)messageViewScrolledBySmallY:(float)Y;

@end
