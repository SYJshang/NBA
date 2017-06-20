//
//  SYJMainNBAController.m
//  MoxiNBA
//
//  Created by 尚勇杰 on 2017/6/14.
//  Copyright © 2017年 尚勇杰. All rights reserved.
//

#import "SYJMainNBAController.h"
#import "SYJTableCollectionCell.h"
#import "SYJNBATitleCell.h"
#import "SYJNBAGameCell.h"
#import "SYJGameModel.h"
#import "SYJNBAGameDetailVC.h"
#import "SYJDateNBAGameVC.h"

@interface SYJMainNBAController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *postArr;
@property (nonatomic, strong) NSMutableArray *finalArr;
@property (nonatomic, strong) NSMutableArray *allArr;

@property (nonatomic, strong) MBProgressHUD *hud;


@end

@implementation SYJMainNBAController

- (NSMutableArray *)postArr{
    
    if (_postArr == nil) {
        _postArr = [NSMutableArray array];
    }
    
    return _postArr;
    
}

- (NSMutableArray *)finalArr{
    
    if (_finalArr == nil) {
        _finalArr = [NSMutableArray array];
    }
    
    return _finalArr;
    
}

- (NSMutableArray *)allArr{
    
    if (_allArr == nil) {
        _allArr = [NSMutableArray array];
    }
    
    return _allArr;
    
}

- (void)back{
    
    [self.navigationController pushViewController:[SYJDateNBAGameVC new] animated:YES];
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    

    
    self.navigationController.navigationBar.hidden = NO;
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(20, 20, 20, 20);
    //    [self.chageButton setBackgroundColor:[UIColor redColor]];
    [btn setImage:[UIImage imageNamed:@"日期"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:btn];

    
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        // 处理耗时操作的代码块...
      //        [self getAllData];
        //通知主线程刷新
//        dispatch_async(dispatch_get_main_queue(), ^{
//            //回调或者说是通知主线程刷新， 
//        }); 
        
//    });
    
    
    NSDictionary *dict = @{@"老鹰": @"ATL",
                           @"凯尔特人"  :@"BOS",
                           @"篮网"  : @"BKN",
                           @"公牛"  : @"CHI",
                           @"骑士"  : @"CLE",
                           @"小牛"  : @"DAL",
                           @"掘金"  : @"DEN",
                           @"活塞"  : @"DET",
                           @"勇士"  : @"GSW",
                           @"火箭" : @"HOU",
                           @"步行者" : @"IND",
                           @"快船" : @"LAC",
                           @"湖人" : @"LAL",
                           @"热火" : @"MIA",
                           @"雄鹿" : @"MIL",
                           @"森林狼" : @"MIN",
                           @"尼克斯" : @"NYK",
                           @"76人" : @"PHI",
                           @"太阳" : @"PHX",
                           @"猛龙" : @"TOR",
                           @"爵士" : @"UTA",
                           @"国王" : @"SAC",
                           @"马刺" : @"SAS",
                           @"奇才" : @"WAS",
                           @"开拓者" : @"POR",
                           @"雷霆" : @"OKC",
                           @"鹈鹕" : @"NOP",
                           @"魔术" : @"ORL",
                           @"黄蜂" : @"CHA",
                           @"灰熊" : @"MEM"};
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:dict forKey:@"NBALogo"];
    
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.titleView = [UILabel titleWithColor:TextColor title:@"NBA Season 2016-2107" font:18.0];
    
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, KSceenW, KSceenH - 64) style:UITableViewStylePlain];
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.tableView registerClass:[SYJTableCollectionCell class] forCellReuseIdentifier:@"cell"];
    [self.tableView registerClass:[SYJNBATitleCell class] forCellReuseIdentifier:@"cell1"];
    [self.tableView registerClass:[SYJNBAGameCell class] forCellReuseIdentifier:@"cell2"];
    
    self.hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    self.hud.mode = MBProgressHUDModeIndeterminate;
    self.hud.labelColor = [UIColor whiteColor];
    self.hud.color = [UIColor blackColor];
    self.hud.labelText = NSLocalizedString(@"loading", @"HUD message title");
    
    [self getHttpData];
    [self getPosData];

    
    // Do any additional setup after loading the view.
}

//获取赛程信息
- (void)getHttpData{
    
    [SYJHttpHelper GET:[NSString stringWithFormat:@"%@/2017/6",URL] parameters:nil success:^(id responseObject) {
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        SYJLog(@"%@",dict);
        
        self.finalArr = [SYJGameModel mj_objectArrayWithKeyValuesArray:dict];
        
        [self.finalArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            SYJGameModel *model = (SYJGameModel *)obj;
            if (model.homeTeam.finalScore == 0) {
                [self.finalArr removeObject:model];
            }
            
        }];
        
        SYJLog(@"%lu",(unsigned long)self.finalArr.count);
//        [self.hud hideAnimated:YES];
        [self.tableView reloadData];
        
        
    } failure:^(NSError *error) {
        
    }];
    
}

//获取赛程信息
- (void)getPosData{
    
    [SYJHttpHelper GET:[NSString stringWithFormat:@"%@/post/2016",URL] parameters:nil success:^(id responseObject) {
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        SYJLog(@"%@",dict);
        
        self.postArr = [SYJGameModel mj_objectArrayWithKeyValuesArray:dict];
        
        [self.postArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            SYJGameModel *model = (SYJGameModel *)obj;
            if (model.homeTeam.finalScore == 0 && model.awayTeam.finalScore == 0) {
                [self.postArr removeObject:model];
            }
            
        }];
        
        SYJLog(@"%lu",(unsigned long)self.postArr.count);
        
        [self.hud hideAnimated:YES];
        [self.tableView reloadData];
        
        
    } failure:^(NSError *error) {
        
    }];
    
}

//获取赛程信息
- (void)getAllData{
    
    [SYJHttpHelper GET:[NSString stringWithFormat:@"%@/2016",URL] parameters:nil success:^(id responseObject) {
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        SYJLog(@"%@",dict);
        
        self.allArr = [SYJGameModel mj_objectArrayWithKeyValuesArray:dict];
        
        [self.allArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            SYJGameModel *model = (SYJGameModel *)obj;
            
            if (model.homeTeam.finalScore == 0) {
                [self.allArr removeObject:model];
            }
            
        }];
        
        SYJLog(@"%lu",(unsigned long)self.allArr.count);
        
        [self.tableView reloadData];
        
        
    } failure:^(NSError *error) {
        
    }];
    
}



#pragma mark - table view dataSource

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    if (section == 1) {
        return @"Final Game";
    }else if (section == 2){
        
        return @"Postseason Game";
    }else{
        
        return @"All Game";
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        return 0;
    }else{
        return 30.0;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0 && indexPath.section == 0) {
        return 160.0;
 
    }else{
        
        return 70.0;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
        return 1;
    }else if (section == 1){

        if (self.finalArr.count > 0) {
            return self.finalArr.count;
        }else{
            return 0;
        }
    }else if (section == 2){
        
        if (self.finalArr.count > 0) {
            return self.postArr.count;
        }else{
            return 0;
        }
    
    }else{
        return 10;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0 && indexPath.section == 0) {
        SYJNBATitleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1"];
        return cell;
    }else{
        
        SYJNBAGameCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell2"];
        if (indexPath.section == 1) {
          
            if (!NULLArray(self.finalArr)) {
                SYJGameModel *model = self.finalArr[indexPath.row];
                cell.model = model;
            }
            
           
            
        }else if (indexPath.section == 2){
            
            if (!NULLArray(self.postArr)) {
                SYJGameModel *model = self.postArr[indexPath.row];
                cell.model = model;
            }
            
        }else if (indexPath.section == 3){
            
            if (!NULLArray(self.allArr)) {
                SYJGameModel *model = self.allArr[indexPath.row];
                cell.model = model;
            }
            
        }
        
        return cell;
    }
    
}

#pragma mark - table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 1) {
        SYJNBAGameDetailVC *vc = [[SYJNBAGameDetailVC alloc]init];
        SYJGameModel *model = self.finalArr[indexPath.row];
        vc.model = model;
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.section == 2){
        
        SYJNBAGameDetailVC *vc = [[SYJNBAGameDetailVC alloc]init];
        SYJGameModel *model = self.postArr[indexPath.row];
        vc.model = model;
        [self.navigationController pushViewController:vc animated:YES];
    }
    
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
