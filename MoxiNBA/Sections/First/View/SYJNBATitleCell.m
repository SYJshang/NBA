//
//  SYJNBATitleCell.m
//  MoxiNBA
//
//  Created by 尚勇杰 on 2017/6/15.
//  Copyright © 2017年 尚勇杰. All rights reserved.
//

#import "SYJNBATitleCell.h"

@implementation SYJNBATitleCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
       
        self.cycleScoller = [[SDCycleScrollView alloc]init];
        [self.contentView addSubview:self.cycleScoller];
        self.cycleScoller.sd_layout.leftSpaceToView(self.contentView, 5).rightSpaceToView(self.contentView, 5).topSpaceToView(self.contentView, 5).bottomSpaceToView(self.contentView, 5);
        self.cycleScoller.placeholderImage = [UIImage imageNamed:@"图片占位or加载"];
        self.cycleScoller.currentPageDotColor = [UIColor whiteColor];
        self.cycleScoller.layer.masksToBounds = YES;
        self.cycleScoller.layer.borderColor = [UIColor colorWithRed:242.0/255.0 green:242.0/255.0 blue:242.0/255.0 alpha:1.0].CGColor;
        self.cycleScoller.layer.borderWidth = 1.0;
        self.cycleScoller.layer.cornerRadius = 5;
        
        
        self.cycleScoller.localizationImageNamesGroup = @[[UIImage imageNamed:@"nba1"],[UIImage imageNamed:@"nba2"],[UIImage imageNamed:@"nba3"],[UIImage imageNamed:@"nba4"],[UIImage imageNamed:@"nba5"],[UIImage imageNamed:@"nba6"],[UIImage imageNamed:@"nba7"]];
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    
    return self;
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
