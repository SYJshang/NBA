//
//  ChangeHomeTeamViewController.m
//  Schedule
//
//  Created by yuedong_chen on 16/8/22.
//  Copyright © 2016年 yuedong_chen. All rights reserved.
//

#import "ChangeHomeTeamViewController.h"
#import "DateCell.h"

@interface ChangeHomeTeamViewController ()

@property (nonatomic, strong) void (^dissmissBlock)();

@end

@implementation ChangeHomeTeamViewController

static NSString * const reuseIdentifier = @"DateCell";

- (id)initWithDataDissmissBlock:(void (^)(NSString *))blcok
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    
    layout.itemSize = CGSizeMake(100, 30);
    layout.minimumLineSpacing  = 0.5;
    layout.minimumInteritemSpacing = 0;
    layout.sectionInset = UIEdgeInsetsZero;
    
    self = [super initWithCollectionViewLayout:layout];
    if (self) {
        self.dissmissBlock = blcok;
        self.collectionView.backgroundColor = [UIColor colorWithRed:250.f / 255.f green:250.f / 255.f blue:250.f / 255.f alpha:1];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.collectionView registerNib:[UINib nibWithNibName:reuseIdentifier bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 30;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    DateCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    cell.vsTeamName = [[DataManager teamDic] objectForKey:[[[DataManager teamDic] allKeys] objectAtIndex:indexPath.item]];
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"Are you sure the home team“%@”", [[DataManager teamDic] objectForKey:[[[DataManager teamDic] allKeys] objectAtIndex:indexPath.item]]] message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"cancle" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (self.dissmissBlock) {
            self.dissmissBlock([[[DataManager teamDic] allKeys] objectAtIndex:indexPath.item]);
        }
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    
    [alertController addAction:cancelAction];
    
    [alertController addAction:okAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

@end
