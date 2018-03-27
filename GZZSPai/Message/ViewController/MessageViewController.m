//
//  MessageViewController.m
//  GZZSPai
//
//  Created by jiangkuiquan on 2018/3/13.
//  Copyright © 2018年 skye. All rights reserved.
//

#import "MessageViewController.h"

#import "HeaderView.h"
#import "GZZLoadingView.h"

@interface MessageViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong) HeaderView *headerView;
@property (nonatomic, strong) UIScrollView *contentView;
@property (nonatomic, strong) UIScrollView *backView;

@end

@implementation MessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor orangeColor];
    self.title = @"信息";
    
//    [self setupView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setupView{
    //底部scrollview用于竖向滑动
    UIScrollView *backScrollView = [[UIScrollView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    backScrollView.showsVerticalScrollIndicator = NO;
//    backScrollView.backgroundColor = [UIColor whiteColor];
    backScrollView.backgroundColor = [UIColor redColor];
    [self.view addSubview:backScrollView];
    
    backScrollView.delegate = self;
    self.backView = backScrollView;
    
    //初始化头部导航栏
    HeaderView *header = [[HeaderView alloc] initWithTitle:@"消息" Button:NULL];
    [self.backView addSubview:header];
    self.headerView = header;
   

//    //    初始化内容scrollview，用于横向滑动
//    UIScrollView *content = [[UIScrollView alloc] initWithFrame:[UIScreen mainScreen].bounds];
//    content.contentInset = UIEdgeInsetsMake(194, 0, 0, 0);
//    content.contentSize = CGSizeMake(LYScreenWidth * 2,0);
//    content.backgroundColor = [UIColor whiteColor];
//    content.showsHorizontalScrollIndicator = NO;
//    content.bounces = NO;
//    content.delegate = self;
//    self.contentView = content;
//    [self.backView addSubview:content];
//
    
    
}

#pragma mark - scrollView delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //    如果是底部scrollview，则作竖向滑动的效果处理
    if (scrollView == self.backView)
    {
        CGFloat Y = scrollView.contentOffset.y;
        NSLog(@"scroll %f",Y);
        if (Y < 0)
        {
            [self.headerView messageViewScrolledBySmallY:Y - 130];
        }
        else
        {
            [self.headerView viewScrolledByY:Y - 130];
        }
        return;
    }
    if (scrollView == self.contentView)
    {
        NSLog(@"scroll %f",scrollView.contentOffset.x);
    }
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
