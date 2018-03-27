
//
//  GZZTabBarController.m
//  GZZSPai
//
//  Created by jiangkuiquan on 2018/3/13.
//  Copyright © 2018年 skye. All rights reserved.
//

#import "GZZTabBarController.h"

#import "HomePageViewController.h"
#import "FoundViewController.h"
#import "MessageViewController.h"
#import "LoginPageViewController.h"
#import "GZZNavController.h"

@interface GZZTabBarController ()

@end

@implementation GZZTabBarController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupTabBar];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setupTabBar{
    //设置底部tabbar的是否透明
    self.tabBar.translucent = NO;
    HomePageViewController *homePage = [[HomePageViewController alloc] init];
    [self addChildViewController:homePage withImage:[UIImage imageNamed:@"home_26x23_"] selectedImage:[UIImage imageNamed:@"home_pressed_26x23_"] WithTitle:@"首页"];
    
    FoundViewController *foundPage = [[FoundViewController alloc] init];
    [self addChildViewController:foundPage withImage:[UIImage imageNamed:@"discover_18x24_"] selectedImage:[UIImage imageNamed:@"discover_pressed_18x24_"] WithTitle:@"发现"];

    MessageViewController *messagePage = [[MessageViewController alloc] init];
    [self addChildViewController:messagePage withImage:[UIImage imageNamed:@"notification_20x24_"] selectedImage:[UIImage imageNamed:@"notification_pressed_20x24_"] WithTitle:@"信息"];
    
    LoginPageViewController *loginPage = [[LoginPageViewController alloc] init];
    [self addChildViewController:loginPage withImage:[UIImage imageNamed:@"user_20x24_"] selectedImage:[UIImage imageNamed:@"user_pressed_20x24_"] WithTitle:@"登陆"];
    
}

-(void)addChildViewController:(UIViewController *)controller withImage:(UIImage *)image selectedImage:(UIImage *)selectImage WithTitle:(NSString *)title{
    GZZNavController *nav = [[GZZNavController alloc] initWithRootViewController:controller];
    [nav.tabBarItem setImage:image];
    [nav.tabBarItem setSelectedImage:selectImage];
    nav.tabBarItem.title = title;
    //设置tabbar底部按钮颜色
    [nav.tabBarItem setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:11], NSForegroundColorAttributeName:[UIColor greenColor]} forState:UIControlStateNormal];
    [nav.tabBarItem setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:11], NSForegroundColorAttributeName:[UIColor redColor]} forState:UIControlStateSelected];
    
    nav.tabBarItem.imageInsets = UIEdgeInsetsMake(5, 0, -5, 0);
    
//    [nav.tabBarItem setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:19], NSForegroundColorAttributeName:[UIColor redColor]}];
    
    [self addChildViewController:nav];
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
