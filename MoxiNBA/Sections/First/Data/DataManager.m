//
//  DataManager.m
//  NBASchedule2016~2017
//
//  Created by yuedong_chen on 16/8/17.
//  Copyright © 2016年 yuedong_chen. All rights reserved.
//

#import "DataManager.h"
#import "AFNetworking.h"
#import "GameInfo.h"

@interface DataManager ()

@property (nonatomic, strong) NSMutableDictionary *gameInfosCache;

@end

@implementation DataManager

- (id)initWithDelegate:(id<DataMangerDelegate>)delegate
{
    self = [super init];
    if (self) {
        self.delegate = delegate;
    }
    return self;
}

- (void)requestWithMonth:(NSInteger)month year:(NSInteger)year andTeamId:(NSString *)tid
{
    NSMutableArray *gameInfoList = [NSMutableArray array];
    NSString *gameInfoListKey = [NSString stringWithFormat:@"%ld_%ld_%@", month, year, tid];
    
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
    
    if ([self.gameInfosCache objectForKey:gameInfoListKey]) {
        gameInfoList = [self.gameInfosCache objectForKey:gameInfoListKey];
        if ([self.delegate respondsToSelector:@selector(loadingDataFinished:)]) {
            [self.delegate loadingDataFinished:gameInfoList];
        }
        return;
    }
    
    NSString *str = [NSString stringWithFormat:@"http://sportsnba.qq.com/match/calendar?month=%ld&teamId=%@&year=%ld", (long)month, tid, (long)year];
//    NSURL *url = [NSURL URLWithString:str];
    
    
    [SYJHttpHelper GET:str parameters:nil success:^(id responseObject) {
        
        NSDictionary *htmlDict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        NSDictionary *data = [htmlDict objectForKey:@"data"];
        
        NSDictionary *matchVs = [data objectForKey:@"matchVs"];
        
        
        NSArray *allKeys = [matchVs allKeys];
        
        for (NSString *key in allKeys) {
            NSDictionary *dayValue = [matchVs objectForKey:key];
            
            GameInfo *info = [[GameInfo alloc] init];
            info.gameDay = [key integerValue];
            info.isWin = [[dayValue objectForKey:@"isWin"] integerValue];
            info.isMaster = [[dayValue objectForKey:@"isMaster"] integerValue];
            info.rivalGoal = [[dayValue objectForKey:@"rivalGoal"] integerValue];
            info.selfGoal = [[dayValue objectForKey:@"selfGoal"] integerValue];
            info.startTime = [[dayValue objectForKey:@"startTime"] integerValue];
            info.vsTeamId = [dayValue objectForKey:@"vsTeamId"];
            info.vsTeamName = dict[[dayValue objectForKey:@"vsTeamName"]];
            
            [gameInfoList addObject:info];
        }
        
        [self.gameInfosCache setObject:gameInfoList forKey:gameInfoListKey];
        if ([self.delegate respondsToSelector:@selector(loadingDataFinished:)]) {
            [self.delegate loadingDataFinished:gameInfoList];
        }

        
    } failure:^(NSError *error) {
        if ([self.delegate respondsToSelector:@selector(loadingDatafailured:error:)]) {
            [self.delegate loadingDatafailured:self error:error];
        }

    }];
    
//    NSURLRequest *request = [NSURLRequest requestWithURL:url];
//    AFHTTPRequestSerializer *operation = [[AFHTTPRequestSerializer alloc] initWithRequest:request];
//    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
//        
//        NSString *htmlString = operation.responseString;
//        
//        NSData *htmlData = [htmlString dataUsingEncoding:NSUTF8StringEncoding];
//        
//        NSDictionary *htmlDict = [NSJSONSerialization JSONObjectWithData:htmlData options:NSJSONReadingMutableLeaves error:nil];
//        
//        
//    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        
//            }];
//    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
//    [queue addOperation:operation];

}

- (NSMutableDictionary *)gameInfosCache
{
    if (!_gameInfosCache) {
        _gameInfosCache = [NSMutableDictionary dictionary];
    }
    return _gameInfosCache;
}

+ (NSDictionary *)teamDic
{
        return     @{@"1"  : @"Atlanta Hawks",
                     @"2"  : @"Boston Celtics",
                     @"3"  : @"New Orleans Pelicans",
                     @"4"  : @"Chicago Bulls",
                     @"5"  : @"Cleveland Cavaliers",
                     @"6"  : @"Dallas Mavericks",
                     @"7"  : @"Denver Broncos",
                     @"8"  : @"Detroit Pistons",
                     @"9"  : @"Golden State Warriors",
                     @"10" : @"Houston Rockets",
                     @"11" : @"Indiana Pacers",
                     @"12" : @"Los Angeles Clippers",
                     @"13" : @"Los Angeles Lakers",
                     @"14" : @"Miami Heat",
                     @"15" : @"Milwaukee Bucks",
                     @"16" : @"Minnesota Timberwolves",
                     @"17" : @"Brooklyn Nets",
                     @"18" : @"New York Knicks",
                     @"19" : @"Orlando Magic",
                     @"20" : @"Philadelphia 76ers",
                     @"21" : @"Phoenix Suns",
                     @"22" : @"Portland Trail Blazers",
                     @"23" : @"Sacramento Kings",
                     @"24" : @"San Antonio Spurs",
                     @"25" : @"Oklahoma City Thunder",
                     @"26" : @"Utah Jazz",
                     @"27" : @"Washington Wizards",
                     @"28" : @"Toronto Raptors",
                     @"29" : @"Memphis Grizzlies",
                     @"30" : @"Charlotte Hornets"};
}


@end
