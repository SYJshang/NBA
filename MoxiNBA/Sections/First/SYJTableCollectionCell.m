//
//  SYJTableCollectionCell.m
//  LotterySecond
//
//  Created by 尚勇杰 on 2017/6/6.
//  Copyright © 2017年 尚勇杰. All rights reserved.
//

#import "SYJTableCollectionCell.h"
#import "SYJCollectionFlowLayout.h"
#import "SYJLotteryCollectionCell.h"

#define Kwidths  ([UIScreen mainScreen].bounds.size.width / 3)

@interface SYJTableCollectionCell ()<UICollectionViewDataSource, SYJCollectionFlowLayoutDelegate,UICollectionViewDelegate>

@property (nonatomic, strong) NSMutableArray *listImgArr;


@end



@implementation SYJTableCollectionCell

- (NSMutableArray *)listImgArr{
    
    if (_listImgArr == nil) {
        
//        NSDictionary *dict = [@"":@""];
        
        _listImgArr = [NSMutableArray arrayWithObjects:@"骑士",@"勇士",@"马刺",@"火箭",@"小牛",@"猛龙",@"雷霆",@"爵士",@"凯尔特人",@"步行者",@"老鹰",@"奇才",@"公牛",@"热火",@"活塞",@"篮网",nil];
    }
    
    return _listImgArr;
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        //创建瀑布流布局
        SYJCollectionFlowLayout *layout = [[SYJCollectionFlowLayout alloc]init];
        layout.delegate = self;
        
        //创建CollectionView
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, KSceenW, KSceenH - 108) collectionViewLayout:layout];
        collectionView.backgroundColor = [UIColor whiteColor];
        collectionView.dataSource = self;
        collectionView.delegate = self;
        
        [self.contentView addSubview:collectionView];
        self.collectionView = collectionView;
        
        self.collectionView.dataSource = self;
        self.collectionView.delegate = self;
        
        self.collectionView.backgroundColor = [UIColor whiteColor];
        
        [self.contentView addSubview:self.collectionView];
        
        [self.collectionView registerClass:[SYJLotteryCollectionCell class] forCellWithReuseIdentifier:@"cell"];
        
    }
    
    return self;
}


#pragma mark - <UICollectionViewDataSource>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 16;
    SYJLog(@"%ld",self.listArr.count);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    SYJLotteryCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.img.image = [UIImage imageNamed:self.listImgArr[indexPath.row]];
    NSMutableArray *title = [NSMutableArray arrayWithObjects:@"骑士",@"勇士",@"马刺",@"火箭",@"小牛",@"猛龙",@"雷霆",@"爵士",@"凯尔特人",@"步行者",@"老鹰",@"奇才",@"公牛",@"热火",@"活塞",@"篮网",nil];
    cell.lotteryName.text = title[indexPath.row];
    
    return cell;
}

- (void)setListArr:(NSMutableArray *)listArr{
    
    _listArr = listArr;
    
    [self.collectionView reloadData];
}


#pragma mark - <CYXWaterFlowLayoutDelegate>
- (CGFloat)waterflowLayout:(SYJCollectionFlowLayout *)waterflowLayout heightForItemAtIndex:(NSUInteger)index itemWidth:(CGFloat)itemWidth
{
    return KSceenW / 3;
}

- (CGFloat)rowMarginInWaterflowLayout:(SYJCollectionFlowLayout *)waterflowLayout
{
    return 0;
}

- (CGFloat)columnCountInWaterflowLayout:(SYJCollectionFlowLayout *)waterflowLayout
{
    return 3;
}

- (UIEdgeInsets)edgeInsetsInWaterflowLayout:(SYJCollectionFlowLayout *)waterflowLayout
{
    return UIEdgeInsetsMake(5,5,5,5);
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    //通知代理
    if ([self.delegate respondsToSelector:@selector(index:)]) {
        [self.delegate index:indexPath.row];
    }

    
    
    
    
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(Kwidths, Kwidths);
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
