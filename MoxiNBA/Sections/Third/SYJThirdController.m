//
//  SYJThirdController.m
//  MoxiNBA
//
//  Created by 尚勇杰 on 2017/6/14.
//  Copyright © 2017年 尚勇杰. All rights reserved.
//

#import "SYJThirdController.h"
#import "PYSearch.h"
#import "SYJSetUpCell.h"
#import "SYJSearchController.h"
#import "SYJSetHomeController.h"
#import "SYJNBAPlayDetailVC.h"
#import "YJCache.h"
#import "SYJDateNBAGameVC.h"

@interface SYJThirdController ()<UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) PYSearchViewController *searchVC;

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation SYJThirdController

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    [self.view endEditing:YES];

}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    UITextField *textFiled = [[UITextField alloc]initWithFrame:CGRectMake(20, 10, KSceenW - 100, 30)];
    textFiled.placeholder = @"Pease input player name";
    textFiled.delegate = self;
    textFiled.borderStyle = UITextBorderStyleRoundedRect;
    textFiled.backgroundColor = Gray;
    self.navigationItem.titleView = textFiled;
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:btn];
    [btn setImage:[UIImage imageNamed:@"搜索_搜索"] forState:UIControlStateNormal];
    btn.frame = CGRectMake(0, 20, 24, 24);
    [btn addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, KSceenW, KSceenH - 64) style:UITableViewStylePlain];
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.tableView.backgroundColor = Gray;
    
    [self.tableView registerClass:[SYJSetUpCell class] forCellReuseIdentifier:@"cell"];
    
    // Do any additional setup after loading the view.
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    [self.view endEditing:YES];
}

- (void)click{
    
    self.searchVC = [PYSearchViewController searchViewControllerWithHotSearches:@[@"James",@"Curry"] searchBarPlaceholder:@"Pease input player name" didSearchBlock:^(PYSearchViewController *searchViewController, UISearchBar *searchBar, NSString *searchText) {
        
        SYJSearchController *vc = [[SYJSearchController alloc]init];
        vc.name = searchText;
        [self.navigationController pushViewController:vc animated:YES];
        
        
    }];
    
    [self.navigationController pushViewController:self.searchVC animated:YES];
}

//- (void)textFieldDidBeginEditing:(UITextField *)textField{
//    
//    self.searchVC = [PYSearchViewController searchViewControllerWithHotSearches:@[@"James",@"Curry"] searchBarPlaceholder:@"Pease input player name" didSearchBlock:^(PYSearchViewController *searchViewController, UISearchBar *searchBar, NSString *searchText) {
//        
//        
//        
//    }];
//    
//    [self.navigationController pushViewController:self.searchVC animated:YES];
//    
//}


#pragma mark - table view dataSource

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 20;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 40;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 6;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"cell";
    
    SYJSetUpCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (indexPath.section == 0) {
        cell.nameLab.text = @"Setting";
        cell.img.image = [UIImage imageNamed:@"设置"];
    }else if (indexPath.section == 1){
        cell.img.image = [UIImage imageNamed:@"主队"];
        cell.nameLab.text = @"home team";
    }else if (indexPath.section == 2){
        cell.img.image = [UIImage imageNamed:@"赛程"];
        cell.nameLab.text = @"agenda for competition";
    }else if (indexPath.section == 3){
        cell.img.image = [UIImage imageNamed:@"关于"];
        cell.nameLab.text = @"About";

    }else if (indexPath.section == 4){
        cell.img.image = [UIImage imageNamed:@"清除"];
        cell.nameLab.text = @"Clear cache";
        
    }else if (indexPath.section == 5){
        cell.img.image = [UIImage imageNamed:@"版本"];
        cell.nameLab.text = @"version";
        
    }
    
    
    return cell;
}

#pragma mark - table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        [self.navigationController pushViewController:[SYJSetHomeController new] animated:YES];
    }else if (indexPath.section == 1){
        SYJNBAPlayDetailVC *vc = [[SYJNBAPlayDetailVC alloc]init];
        NSString *str = [[NSUserDefaults standardUserDefaults] objectForKey:@"home"];
        vc.teamID = str;
        [self.navigationController pushViewController:vc animated:YES];
        
    }else if(indexPath.section == 2){
        [self.navigationController pushViewController:[SYJNBAPlayDetailVC new] animated:YES];
        
    }else if (indexPath.section == 3){
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"hint" message:@"I am a fan of the NBA, I want to make things to bring with more people help, let us fall in love with the NBA." delegate:nil cancelButtonTitle:@"OKay" otherButtonTitles: nil];
        [alert show];
        
    }else if (indexPath.section == 4){
        
        float cache = [YJCache filePath];
        NSString *str = [NSString stringWithFormat:@"%.2f Mb",cache];
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"hint" message:[NSString stringWithFormat:@"claer %@ Mb cache",str] delegate:nil cancelButtonTitle:@"Thanks" otherButtonTitles:nil];
        [alert show];
        [YJCache clearFile];

    }else if (indexPath.section == 5){
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"hint" message:@"The current version: 2.6.6" delegate:nil cancelButtonTitle:@"OKay" otherButtonTitles: nil];
        [alert show];
        
    }
    
//    kTipAlert(@"<%ld> selected...", indexPath.row);
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
