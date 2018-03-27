//
//  HeaderView.m
//  GZZSPai
//
//  Created by jiangkuiquan on 2018/3/19.
//  Copyright © 2018年 skye. All rights reserved.
//

#import "HeaderView.h"

@interface HeaderView()

@property (nonatomic, strong)UILabel *titleLabel;
@property (nonatomic, strong)UIButton *navButton;

@end

@implementation HeaderView
-(instancetype)initWithTitle:(NSString *)title Button:(nullable NSString *)button{
    self = [super init];
    self.frame = CGRectMake(0, 0, GZZScreenWidth, 100);
    self.backgroundColor = [UIColor whiteColor];
    self.titleLabel.text = title;
    //若button参数不为空，则为带按钮的类型，进行初始化，否则不初始化按钮
    if(button)
    {
        [self.navButton setImage:[UIImage imageNamed:button] forState:UIControlStateNormal];
    }
    
    return self;
}

//导航标题和按钮动作的方法，需要准确计算
-(void)viewScrolledByY:(float)Y{
   //scrollView刚刚开始滑动，此时导航标题大小和按钮大小进行变化
    if (Y <= -97 && Y > -130) {
    //以字号为36和20计算得出的临界Y值为-97 和 -130，根据此刻Y值计算此时的字号
        CGFloat fontSize = ((16.0 * Y)/33.00) - 892.0/33.0;
        self.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:fontSize];
        //更新titleLabel的高度约束
        [self.titleLabel mas_updateConstraints:^(MASConstraintMaker *make){
            make.height.mas_equalTo(self.titleLabel.font.pointSize + 0.5);
        }];
        //计算此刻button的对应尺寸，若大于最小值(16),则跟新约束
        CGFloat buttonSize = self.titleLabel.font.pointSize * (5.0/9.0);
        if (buttonSize >= 16.0) {
            [self.navButton mas_updateConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo(buttonSize);
                make.height.mas_equalTo(buttonSize);
            }];
        }
        
    }
    
    //此时控件大小不变，headView的frame进行变化，表现为控件上下平行移动。临界条件为高度等于等于系统导航条高度（64）
    if (Y > -97 && Y <= -61) {
        //！！！此处非常诡异，测试时，控件向上平行移动时是正常的。但是在控件向下平行移动时，若不将代码放在主线程中执行，frame的跟新是无效的，控件不会下滑。此处待探究原因。
        dispatch_async(dispatch_get_main_queue(), ^{
            self.frame = CGRectMake(0, 0, GZZScreenWidth, 3 - Y);
        });
    }
    //防止计算无法精确到整数，控件尺寸在临界条件跳变，作此处理
    if (Y < -130) {
        self.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:36.0];
        [self.titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(36.0);
        }];
        [self.navButton mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(20.0);
            make.height.mas_equalTo(20.0);
        }];
        //模拟导航条控件也在scrollView上的效果
        self.frame = CGRectMake(0, 0, GZZScreenWidth, 100 + ((-130)-Y));
    }
    
    //防止滑动过快时，导航栏控件没有正确缩小尺寸，作此处理
    if (Y > -97) {
        self.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:20.0];
        [self.titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(20.0);
        }];
        [self.navButton mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(16.0);
            make.height.mas_equalTo(16.0);
        }];
        self.frame = CGRectMake(0, 0, GZZScreenWidth, 64);
    }
    
}

-(void)messageViewScrolledBySmallY:(float)Y{
    self.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:36.0];
    [self.titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(36.0);
    }];
    [self.navButton mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(20.0);
        make.width.mas_equalTo(20.0);
    }];
}

//导航标题label懒加载
-(UILabel *)titleLabel{
    if (!_titleLabel) {
        UILabel *title = [[UILabel alloc] init];
        title.textColor = [UIColor blackColor];
        title.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:36.0];
        title.textAlignment = NSTextAlignmentLeft;
        [self addSubview:title];
        [title mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_left).with.offset(25);
            make.bottom.mas_equalTo(self.mas_bottom).with.offset(-10);
            make.height.mas_equalTo(36);
            make.width.mas_equalTo(120);
        }];
        _titleLabel = title;
    }
    return _titleLabel;
}
//导航按钮懒加载
-(UIButton *)navButton{
    if (!_navButton) {
        UIButton *navBtn = [[UIButton alloc] init];
        [navBtn addTarget:self action:@selector(buttonClicked) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:navBtn];
        [navBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.mas_right).with.offset(-25);
            make.bottom.mas_equalTo(self.mas_bottom).with.offset(-15);
            make.width.mas_equalTo(20);
            make.height.mas_equalTo(20);
        }];
        _navButton = navBtn;
    }
    
    return _navButton;
}
//右侧按钮点击事件
-(void)buttonClicked{
    NSLog(@"点击右侧提包按钮");
    if ([self.delegate respondsToSelector:@selector(BtnClicked)]) {
        [self.delegate BtnClicked];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
