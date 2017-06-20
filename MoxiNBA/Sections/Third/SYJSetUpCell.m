//
//  SYJSetUpCell.m
//  MoxiNBA
//
//  Created by 尚勇杰 on 2017/6/16.
//  Copyright © 2017年 尚勇杰. All rights reserved.
//

#import "SYJSetUpCell.h"

@implementation SYJSetUpCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.img = [[UIImageView alloc]init];
        [self.contentView addSubview:self.img];
        self.img.sd_layout.leftSpaceToView(self.contentView, 10).centerYEqualToView(self.contentView).heightIs(24).widthIs(24);
        
        self.nameLab = [[UILabel alloc]init];
        [self.contentView addSubview:self.nameLab];
        self.nameLab.textColor = [UIColor blackColor];
        self.nameLab.font = [UIFont systemFontOfSize:16];
        self.nameLab.sd_layout.leftSpaceToView(self.img, 15).centerYEqualToView(self.contentView).heightIs(20).widthIs(180);
        
        self.accow = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"箭头"]];
        [self.contentView addSubview:self.accow];
        self.accow.sd_layout.rightSpaceToView(self.contentView, 10).centerYEqualToView(self.contentView).heightIs(16).widthIs(16);
        
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
