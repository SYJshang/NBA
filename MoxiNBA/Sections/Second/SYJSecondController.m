//
//  SYJSecondController.m
//  MoxiNBA
//
//  Created by 尚勇杰 on 2017/6/14.
//  Copyright © 2017年 尚勇杰. All rights reserved.
//

#import "SYJSecondController.h"
#import "SYJCollectionFlowLayout.h"
#import "SYJLotteryCollectionCell.h"
#import "SYJNBAPlayDetailVC.h"
#import "SYJDateNBAGameVC.h"


#define Kwidths  ([UIScreen mainScreen].bounds.size.width / 3)

@interface SYJSecondController ()<UICollectionViewDataSource, SYJCollectionFlowLayoutDelegate,UICollectionViewDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) NSMutableArray *listArr;

@property (nonatomic, strong) NSMutableArray *listImgArr;




@end

@implementation SYJSecondController

- (NSMutableArray *)listArr{
    
    if (_listArr == nil) {
        _listArr = [NSMutableArray array];
    }
    
    return _listArr;
    
}

- (NSMutableArray *)listImgArr{
    
    if (_listImgArr == nil) {
        
        //        NSDictionary *dict = [@"":@""];
        
        _listImgArr = [NSMutableArray array];
    }
    
    return _listImgArr;
    
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    self.navigationItem.titleView = [UILabel titleWithColor:TextColor title:@"Team Information" font:18.0];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(20, 20, 20, 20);
    //    [self.chageButton setBackgroundColor:[UIColor redColor]];
    [btn setImage:[UIImage imageNamed:@"日期"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
    
}

- (void)back{
    
    [self.navigationController pushViewController:[SYJDateNBAGameVC new] animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSDictionary *dict = [[NSUserDefaults standardUserDefaults] objectForKey:@"NBALogo"];
    self.listArr = (NSMutableArray *)[dict allValues];
    self.listImgArr = (NSMutableArray *)[dict allKeys];
    
    //创建瀑布流布局
    SYJCollectionFlowLayout *layout = [[SYJCollectionFlowLayout alloc]init];
    layout.delegate = self;
    
    //创建CollectionView
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, KSceenW, KSceenH - 64) collectionViewLayout:layout];
    collectionView.backgroundColor = [UIColor whiteColor];
    collectionView.dataSource = self;
    collectionView.delegate = self;
    
    self.collectionView = collectionView;
    
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.collectionView];
    
    [self.collectionView registerClass:[SYJLotteryCollectionCell class] forCellWithReuseIdentifier:@"cell"];
    

    
    // Do any additional setup after loading the view.
}

#pragma mark - <UICollectionViewDataSource>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.listArr.count;
    SYJLog(@"%ld",self.listArr.count);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    SYJLotteryCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.img.image = [UIImage imageNamed:self.listImgArr[indexPath.row]];
    cell.lotteryName.text = self.listArr[indexPath.row];
    
    return cell;
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
    

//    SYJLotteryCollectionCell *cell = (SYJLotteryCollectionCell *)[self coll];
    SYJLotteryCollectionCell *cell = (SYJLotteryCollectionCell *)[self collectionView:self.collectionView cellForItemAtIndexPath:indexPath];

    if (cell.lotteryName.text) {
        SYJNBAPlayDetailVC *vc = [[SYJNBAPlayDetailVC alloc]init];
        vc.teamID = cell.lotteryName.text;
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(Kwidths, Kwidths);
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
