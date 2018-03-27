//
//  NewsCell.m
//  GZZSPai
//
//  Created by jiangkuiquan on 2018/3/23.
//  Copyright © 2018年 skye. All rights reserved.
//

#import "NewsCell.h"

@interface NewsCell()

@property (nonatomic, weak) UIImageView *likeIcon; //喜欢按钮图标
@property (nonatomic, weak) CALayer *avator;   //头像
@property (nonatomic, weak) UILabel *nickName; //昵称
@property (nonatomic, weak) UIButton *menu;    //更多按钮
@property (nonatomic, weak) CALayer *banner;   //图片展示
@property (nonatomic, weak) UILabel *articleTitle; //标题
@property (nonatomic, weak) UILabel *rmdDescription;//信息描述
@property (nonatomic, weak) UILabel *likeAndComment;//评论数目
@property (nonatomic, weak) UILabel *postTime;  //时间

@end

@implementation NewsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+(instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *identifier = @"NewsCellIdentifier";
    NewsCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil) {
        cell = [[NewsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        [cell setupUI];
        [cell setModel];
    }
    
    
    return cell;
}

-(void)setupUI{
    
    //头像约束
    CALayer *avator = [[CALayer alloc] init];
    [self.contentView.layer addSublayer:avator];
    avator.frame = CGRectMake(25, 15, 30, 30);
    self.avator = avator;
    
    //昵称约束
    UILabel *nickNameLab = [[UILabel alloc] init];
    [self.contentView addSubview:nickNameLab];
    nickNameLab.frame = CGRectMake(65, 22.5, 150, 15);
    nickNameLab.textAlignment = NSTextAlignmentLeft;
    nickNameLab.font = [UIFont systemFontOfSize:14.0];
    nickNameLab.textColor = UIColor(102, 102, 102);
    self.nickName = nickNameLab;
    
    //更多按钮约束
    UIButton *menu = [[UIButton alloc] init];
    [self.contentView addSubview:menu];
    [menu setImage:[UIImage imageNamed:@"more_18x4_"] forState:UIControlStateNormal];
    [menu mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView.mas_top).with.offset(17.5);
        make.right.mas_equalTo(self.contentView.mas_right).with.offset(-25.0);
        make.width.mas_equalTo(25.0);
        make.height.mas_equalTo(25.0);
    }];
    [menu addTarget:self action:@selector(menuClicked) forControlEvents:UIControlEventTouchUpInside];
    self.menu = menu;
    
    //图片展示约束
    CALayer *banner = [[CALayer alloc] init];
    [self.contentView.layer addSublayer:banner];
    banner.frame = CGRectMake(25, 55, GZZScreenWidth - 50, (GZZScreenWidth - 50) * 0.3331);
    self.banner = banner;
    
    //设置标题约束
    UILabel *titleLab = [[UILabel alloc] init];
    [self.contentView addSubview:titleLab];
    titleLab.textAlignment = NSTextAlignmentLeft;
    titleLab.font = [UIFont boldSystemFontOfSize:20.0];
    titleLab.textColor = [UIColor blackColor];
    //设置行数自适应，无需写masonry中的高度
    titleLab.preferredMaxLayoutWidth = (GZZScreenWidth - 50.0);
    [titleLab setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    titleLab.numberOfLines = 0;
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).with.mas_offset(25.0);
        make.top.mas_equalTo(self.contentView.mas_top).with.mas_offset(70 + (GZZScreenWidth - 50) * 0.3331);
        make.right.mas_equalTo(self.contentView.mas_right).with.offset(-25.0);
    }];
    self.articleTitle = titleLab;
    
    //信息展示lab约束
    UILabel *articleDesLab = [[UILabel alloc] init];
    [self.contentView addSubview:articleDesLab];
    articleDesLab.preferredMaxLayoutWidth = GZZScreenWidth - 50.0;
    [articleDesLab setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    articleDesLab.numberOfLines = 0;
    [articleDesLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).with.offset(25.0);
        make.top.mas_equalTo(self.contentView.mas_top).with.offset(10.0);
        make.right.mas_equalTo(self.contentView.mas_right).with.offset(-25.0);
    }];
    articleDesLab.textAlignment = NSTextAlignmentLeft;
    articleDesLab.font = [UIFont systemFontOfSize:14.0];
    articleDesLab.textColor =UIColor(170, 170, 170);
    self.rmdDescription = articleDesLab;
    
    //喜欢图片约束
    UIImageView *likeImgView = [[UIImageView alloc] init];
    [self.contentView addSubview:likeImgView];
    [likeImgView setImage:[UIImage imageNamed:@""]];
    [likeImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).with.offset(25.0);
        make.top.mas_equalTo(self.rmdDescription.mas_bottom).with.offset(12.0);
        make.width.mas_equalTo(14.0);
        make.height.mas_equalTo(11.9);
    }];
    self.likeIcon = likeImgView;
    
    //评论数lab约束
    UILabel *comments = [[UILabel alloc] init];
    [self.contentView addSubview:comments];
    [comments mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.likeIcon.mas_right).with.offset(8.0);
    make.top.mas_equalTo(self.rmdDescription.mas_bottom).with.mas_offset(10.0);
        make.width.mas_offset(150);
        make.height.mas_offset(14.0);
    }];
    comments.textAlignment = NSTextAlignmentLeft;
    comments.font = [UIFont systemFontOfSize:12.0];
    comments.textColor = UIColor(107, 107, 107);
     self.likeAndComment = comments;
    
     //时间lab约束
     UILabel *timeLable = [[UILabel alloc] init];
     [self.contentView addSubview:timeLable];
     [timeLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.rmdDescription.mas_bottom).with.offset(10.0);
        make.right.mas_equalTo(self.contentView.mas_right).with.offset(-25.0);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(14.0);
     }];
    timeLable.textAlignment = NSTextAlignmentRight;
    timeLable.font = [UIFont systemFontOfSize:12.0];
    timeLable.textColor =UIColor(208, 208, 208);
    self.postTime = timeLable;
    
    UIView *lineView = [[UIView alloc] init];
    [self.contentView addSubview:lineView];
    lineView.backgroundColor = [UIColor grayColor];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).with.offset(0.0);
        make.bottom.mas_equalTo(self.contentView.mas_bottom).with.offset(0.0);
        make.left.mas_equalTo(self.contentView.mas_right).with.offset(0.0);
        make.top.mas_equalTo(self.postTime.mas_bottom).with.offset(5.0);
        make.height.mas_equalTo(1);
    }];
}

-(void)setModel{
    [self.avator yy_setImageWithURL:[NSURL URLWithString:@"https://cdn.sspai.com/attachment/origin/2016/04/20/323468.jpg"] placeholder:nil options:kNilOptions progress:nil transform:^UIImage * _Nullable(UIImage * _Nonnull image, NSURL * _Nonnull url) {
        image = [image yy_imageByRoundCornerRadius:60.0];
        return image;
    } completion:nil];
    self.nickName.text = @"你好你好你好你好你好你好你好你好";
    self.articleTitle.text = @"文章标题文章标题文章标题文章标题";
    [self.banner yy_setImageWithURL:[NSURL URLWithString:@"https://cdn.sspai.com/article/5fee7818-33e8-8ede-4f1e-ab8676fab2da.jpg"] placeholder:nil options:kNilOptions progress:nil transform:^UIImage * _Nullable(UIImage * _Nonnull image, NSURL * _Nonnull url) {
        image = [image yy_imageByRoundCornerRadius:60.0];
        return image;
    } completion:nil];
    
}


/*
- (void)setModel:(NewsModel *)model
{
    //    _avator    https://cdn.sspai.com/attachment/origin/2016/04/20/323468.jpg
    //    _banner    https://cdn.sspai.com/article/5fee7818-33e8-8ede-4f1e-ab8676fab2da.jpg
    _model = model;
    [self.avator yy_setImageWithURL:[NSURL URLWithString:model.avator] placeholder:nil options:kNilOptions progress:nil transform:^UIImage * _Nullable(UIImage * _Nonnull image, NSURL * _Nonnull url) {
        image = [image yy_imageByRoundCornerRadius:60.0];
        return image;
    } completion:nil];
    self.nickname.text = model.nickname;
    self.articleTitle.text = model.title;
    [self.banner yy_setImageWithURL:[NSURL URLWithString:model.banner] placeholder:nil options:kNilOptions progress:nil transform:^UIImage * _Nullable(UIImage * _Nonnull image, NSURL * _Nonnull url) {
        image = [image yy_imageByRoundCornerRadius:5.0];
        return image;
    } completion:nil];
    
    //    NSLog(@"screen width %f", LYScreenWidth);
    //    NSLog(@"length::: %ld", model.summary.length);
    if((float)model.summary.length/LYScreenWidth > 0.11)
    {
        NSString *temStr = [model.summary substringToIndex:(int)(LYScreenWidth * 0.11)];
        model.summary = [temStr stringByAppendingString:@"…"];
    }
    self.rmdDescription.text = model.summary;
    self.likeAndComment.text = [NSString stringWithFormat:@"%@  · %@ 评论", model.like_total, model.comment_total];
    self.postTime.text = @"18 小时前";
}
 */
//- (void)setufpUI
//{
//    UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeLeft)];
//    swipe.delaysTouchesBegan = YES;
//    swipe.direction = UISwipeGestureRecognizerDirectionLeft;
//    [self.contentView addGestureRecognizer:swipe];
//}

-(void)menuClicked{
    NSLog(@"点击更多按钮");
    
    
}



@end
