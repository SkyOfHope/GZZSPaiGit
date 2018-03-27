//
//  HomePageViewController.m
//  GZZSPai
//
//  Created by jiangkuiquan on 2018/3/13.
//  Copyright © 2018年 skye. All rights reserved.
//

#import "HomePageViewController.h"

#import "HeaderView.h"           //导航
#import "GZZLoadingView.h"
#import "AdsCell.h"              //滑动cell
#import "NewsCell.h"             //
#import "PaidNewsCell.h"         //
#import "SimpleTableViewController.h"



#import <objc/runtime.h>  //runtime 运行时

@interface HomePageViewController ()<UIScrollViewDelegate,HeaderViewDelegate,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UIScrollView *backgroundScrollView;
@property (nonatomic, strong) HeaderView *headerView;
@property (nonatomic, strong) UITableView *newsTableView;

@end

@implementation HomePageViewController

-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.hidden = NO;
}

-(void)viewWillDisappear:(BOOL)animated{
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupData];
    [self setupView];
    [self calculator];
//    [self hhhh];
    
}



-(void)setupData{
    //    为模拟网络获取数据时的延迟，这里手动设置延迟0.8s，否则loadingview一闪而过
    dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8/*延迟执行时间*/ * NSEC_PER_SEC));
    dispatch_after(delayTime, dispatch_get_main_queue(), ^{
        //        隐藏loadingview
        [GZZLoadingView hideLoadingViewFromView:self.view];
        
    });
    
}

-(void)setupView{
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    //初始化loadingView
    CGRect loadingViewFrame = CGRectMake(0, 130, GZZScreenWidth, GZZScreenHeight - 130);
    [GZZLoadingView showLoadingViewToView:self.view WithFrame:loadingViewFrame];
    
    //初始化背景scrollView
    UIScrollView *backScrollView = [[UIScrollView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.view insertSubview:backScrollView atIndex:0];
    self.backgroundScrollView = backScrollView;
    
//    HeaderView *header = [[HeaderView alloc] initWithTitle:@"首页" Button:@"catalog_22x21_"];
//    header.delegate = self;
//    self.headerView = header;
//    [self.backgroundScrollView addSubview:header];
    
    //初始化首页内容tableview
//    UITableView *news = [[UITableView alloc] initWithFrame:CGRectMake(0, 150, GZZScreenWidth, GZZScreenHeight-150) style:UITableViewStylePlain];
    UITableView *news = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
    news.delegate = self;
    news.dataSource = self;
    news.backgroundColor = [UIColor redColor];
    news.contentInset = UIEdgeInsetsMake(150, 0, 0, 0);
    [self.backgroundScrollView addSubview:news];
    news.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.newsTableView = news;
    
    /***
    注意：header的加载位置必须在tableview后边，否则会被tableview覆盖
    ***/
    //初始化头部导航栏
    HeaderView *header = [[HeaderView alloc] initWithTitle:@"首页" Button:@"catalog_22x21_"];
    header.delegate = self;
//    header.backgroundColor = [UIColor clearColor];
    self.headerView = header;
    [self.backgroundScrollView addSubview:header];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - scrollView delegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
   //输出scrollView的content offset Y值，调试时取消注释
    NSLog(@"scroll::%f",scrollView.contentOffset.y);
    [self.headerView viewScrolledByY:scrollView.contentOffset.y];
}

#pragma mark - UITableViewDataSource数据源方法
// 返回多少组,没实现该方法,默认为1
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
//返回第section组中有多少行
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
   
    return 5;
}
#pragma mark - UITableViewDelegate代理方法

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return (GZZScreenWidth - 50) * 0.53125 + 40;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //    else if (indexPath.row == 2){
    //        PaidNewsCell *paidNewsCell = [PaidNewsCell CellWithTableView:tableView];
    //        return paidNewsCell;
    //    }

    if (indexPath.row == 0) {
        AdsCell *adsCell = [AdsCell cellWithTableView:tableView];
        return adsCell;
    }else{
         NewsCell *newsCell = [NewsCell cellWithTableView:tableView];
        //添加cell背景色
        if ((indexPath.row % 2) == 0) {
            newsCell.contentView.backgroundColor = [UIColor orangeColor];
        }else{
            newsCell.contentView.backgroundColor = [UIColor greenColor];
        }
        
        return newsCell;
    }
    return nil;
}
// cell选中时调用
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    
    
}

#pragma mark protocal
-(void)BtnClicked{
    SimpleTableViewController *simpleTableViewVC = [[SimpleTableViewController alloc] init];
    [self.navigationController pushViewController:simpleTableViewVC animated:YES];
}


#pragma mark - calculator
-(void)calculator{
    /*
//    百钱买百鸡的问题算是一套非常经典的不定方程的问题，题目很简单：公鸡5文钱一只，母鸡3文钱一只，小鸡3只一文钱，
//    用100文钱买一百只鸡,其中公鸡，母鸡，小鸡都必须要有，问公鸡，母鸡，小鸡要买多少只刚好凑足100文钱。
    
    for (int x = 1; x < 20; x++){
        //母鸡的上线
        for (int y = 1; y < 33; y++){
            //剩余小鸡
            int z = 100 - x - y;
            if ((z % 3 == 0) && (x * 5 + y * 3 + z / 3 == 100)){
                NSLog(@"公鸡:%d只，母鸡:%d只,小鸡:%d只",x,y,z);
            }
        }
    }
    */
    
    
    
    
}

-(void)hhhh{
    unsigned int count;
    //获取属性列表
    objc_property_t *propertyList = class_copyPropertyList([self class], &count);
    for (unsigned int i=0; i<count; i++) {
        const char *propertyName = property_getName(propertyList[i]);
        NSLog(@"property---->%@", [NSString stringWithUTF8String:propertyName]);
    }
    
    //获取方法列表
    Method *methodList = class_copyMethodList([self class], &count);
    for (unsigned int i = 0; i<count; i++) {
        Method method = methodList[i];
        NSLog(@"method---->%@", NSStringFromSelector(method_getName(method)));
    }
    
    //获取成员变量列表
    Ivar *ivarList = class_copyIvarList([self class], &count);
    for (unsigned int i = 0; i<count; i++) {
        Ivar myIvar = ivarList[i];
        const char *ivarName = ivar_getName(myIvar);
        NSLog(@"Ivar---->%@", [NSString stringWithUTF8String:ivarName]);
    }
    
    //获取协议列表
    __unsafe_unretained Protocol **protocolList = class_copyProtocolList([self class], &count);
    for (unsigned int i = 0; i<count; i++) {
        Protocol *myProtocal = protocolList[i];
        const char *protocolName = protocol_getName(myProtocal);
        NSLog(@"protocol---->%@", [NSString stringWithUTF8String:protocolName]);
    }
    
    //作者：兴宇是谁
    //链接：https://www.jianshu.com/p/927c8384855a
    //來源：简书
    //著作权归作者所有。商业转载请联系作者获得授权，非商业转载请注明出处。

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
