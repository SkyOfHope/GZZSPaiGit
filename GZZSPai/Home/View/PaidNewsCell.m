

//
//  PaidNewsCell.m
//  GZZSPai
//
//  Created by jiangkuiquan on 2018/3/26.
//  Copyright © 2018年 skye. All rights reserved.
//

#import "PaidNewsCell.h"

@implementation PaidNewsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+(instancetype)CellWithTableView:(UITableView *)tableView{
    static NSString *identifier = @"paidCellIdentifier";
    PaidNewsCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[PaidNewsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        [cell setupUI];
    }
    
    return cell;
}

-(void)setupUI{
    float cellWidth = GZZScreenWidth * 0.55;
    float cellHeight = GZZScreenWidth * 0.7;
    UILabel *cellTitle = [[UILabel alloc] init];
    [self.contentView addSubview:cellTitle];
    cellTitle.frame = CGRectMake(25, 10, 100, 18);
    cellTitle.backgroundColor = [UIColor blueColor];
    cellTitle.font = [UIFont boldSystemFontOfSize:16.0];
    cellTitle.textAlignment = NSTextAlignmentLeft;
    cellTitle.text = @"付费栏目";
    
    UIButton *moreBtn = [[UIButton alloc] init];
    [self.contentView addSubview:moreBtn];
    moreBtn.frame = CGRectMake(349, 11, 40, 16);
    [moreBtn setTitle:@"更多" forState:UIControlStateNormal];
    [moreBtn setTitleColor:UIColor(170, 170, 170) forState:UIControlStateNormal];
    moreBtn.titleLabel.font = [UIFont systemFontOfSize:14.0];
    [moreBtn addTarget:self action:@selector(moreBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    
    UIScrollView *backScrollView = [[UIScrollView alloc] init];
    [self.contentView addSubview:backScrollView];
    backScrollView.frame = CGRectMake(0, 43, 414, 290);
    backScrollView.backgroundColor = [UIColor purpleColor];
    backScrollView.showsHorizontalScrollIndicator = NO;
    backScrollView.contentSize = CGSizeMake(35 + 3 * (cellWidth + 15), cellHeight);
    
     
     
}


-(void)moreBtnClicked{
    NSLog(@"点击更多按钮");
    
    
}


@end




