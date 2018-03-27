//
//  FoundViewController.m
//  GZZSPai
//
//  Created by jiangkuiquan on 2018/3/13.
//  Copyright © 2018年 skye. All rights reserved.
//

#import "FoundViewController.h"

#import "HeaderView.h"
#import "GZZLoadingView.h"

@interface FoundViewController ()<UIScrollViewDelegate,HeaderViewDelegate>

@property (strong, nonatomic) HeaderView *headerView;
//页面容器
@property (strong, nonatomic) UIScrollView *backgroundScrollView;


@end

@implementation FoundViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor yellowColor];
    self.title = @"发现";
    [self setupView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setupView{
   //初始化loadingView
    CGRect loadingViewFrame = CGRectMake(0, 130, GZZScreenWidth, GZZScreenHeight - 130);
    [GZZLoadingView showLoadingViewToView:self.view WithFrame:loadingViewFrame];
    
    dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t) (0.8/*延迟执行时间*/* NSEC_PER_SEC));
    dispatch_after(delayTime, dispatch_get_main_queue(), ^{
        [GZZLoadingView hideLoadingViewFromView:self.view];
    });
    
    //初始化背景scrollview
    UIScrollView *backScrollView = [[UIScrollView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.view insertSubview:backScrollView atIndex:0];
    self.backgroundScrollView = backScrollView;
    
    HeaderView *header = [[HeaderView alloc] initWithTitle:@"发现" Button:@"nav_but_search_20x20_"];
    [self.backgroundScrollView addSubview:header];
    header.delegate = self;
    self.headerView = header ;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
