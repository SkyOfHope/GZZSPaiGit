//
//  AdsCell.m
//  GZZSPai
//
//  Created by jiangkuiquan on 2018/3/22.
//  Copyright © 2018年 skye. All rights reserved.
//

#import "AdsCell.h"

@interface AdsCell()

@property (nonatomic, weak) UIScrollView *backScrollView;

@end

@implementation AdsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+(instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *identifier = @"AdsCellIdentifier";
    AdsCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[AdsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        [cell setupUI];
    }
    
    return cell;
}

-(void)setupUI{
    UIScrollView *backScroll = [[UIScrollView alloc]
                                initWithFrame:CGRectMake(0, 0, GZZScreenWidth, (GZZScreenWidth - 50) * 0.53125 + 40)];
    backScroll.scrollEnabled = YES;
    backScroll.backgroundColor = [UIColor yellowColor];
    backScroll.contentSize = CGSizeMake(3 * (GZZScreenWidth - 40) + 40, 170);
    backScroll.showsHorizontalScrollIndicator = NO;
    
    [self.contentView addSubview:backScroll];
    self.backScrollView = backScroll;
    
    for (int i = 0; i < 3; i++) {
        UIView *shadowView = [[UIView alloc] init];
        shadowView.frame = CGRectMake(25 + (GZZScreenWidth - 40) * i, 15, GZZScreenWidth - 50, (GZZScreenWidth - 50) * 0.53125);
        shadowView.backgroundColor = [UIColor greenColor];
        shadowView.layer.shadowColor = [UIColor blackColor].CGColor;
        shadowView.layer.shadowRadius = 5.0;
        shadowView.layer.shadowOpacity = 0.3;
        shadowView.layer.shadowOffset = CGSizeMake(-4, 4);
        shadowView.userInteractionEnabled = YES;
        shadowView.tag = i;
        
        CALayer *AdsView = [[CALayer alloc] init];
        AdsView.frame = CGRectMake(0, 0, LYScreenWidth - 50, (LYScreenWidth - 50) * 0.53125);
        
        [AdsView yy_setImageWithURL:[NSURL URLWithString:@"https://cdn.sspai.com/article/404e3eb5-a091-7f48-b4cf-b710dad94e63.jpg"] placeholder:nil options:kNilOptions progress:nil transform:^UIImage * _Nullable(UIImage * _Nonnull image, NSURL * _Nonnull url) {
            image = [image yy_imageByRoundCornerRadius:5.0];
            return image;
        } completion:nil];
        
        [shadowView.layer addSublayer:AdsView];

        [self.backScrollView addSubview:shadowView];
    }
    
}



@end
