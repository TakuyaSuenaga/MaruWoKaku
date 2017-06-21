//
//  GCManager.m
//  MaruWoKaku
//
//  Created by Takuya Suenaga on 2014/07/23.
//  Copyright (c) 2014年 Takuya Suenaga. All rights reserved.
//

@import GameKit;

#import "GCManager.h"

@interface GCManager () <GKGameCenterControllerDelegate>

@end

@implementation GCManager

+ (GCManager *)sharedManager
{
    static GCManager *singleton;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        singleton = [[self alloc] init];
    });
    
    return singleton;
}

- (void)authenticateLocalPlayer:(UIViewController*)vc
{
    GKLocalPlayer* player = [GKLocalPlayer localPlayer];
    player.authenticateHandler = ^(UIViewController* ui, NSError* error )
    {
        if( nil != ui )
        {
            [vc presentViewController:ui animated:YES completion:nil];
        }
    };
}

- (void)loadPlayerData:(NSArray *) identifiers
{
    [GKPlayer loadPlayersForIdentifiers:identifiers withCompletionHandler:^(NSArray *players, NSError *error) {
        if (error != nil)
        {
            // エラーを処理する。
        }
        if (players != nil)
        {
            // GKPlayerオブジェクトの配列を処理する
            for (GKPlayer *player in players) {
                NSLog(@"playerID = %@", player.playerID);
            }
        }
    }];
}

- (void)showGameCenter:(UIViewController *)vc
{
    GKGameCenterViewController *gameCenterController = [[GKGameCenterViewController alloc] init];
    if (gameCenterController != nil)
    {
        gameCenterController.gameCenterDelegate = self;
        [vc presentViewController: gameCenterController animated: YES completion:nil];
    }
}

- (void) showLeaderboard:(NSString *)leaderboardID viewController:(UIViewController *)vc
{
    GKGameCenterViewController *gameCenterController = [[GKGameCenterViewController alloc] init];
    if (gameCenterController != nil)
    {
        gameCenterController.gameCenterDelegate = self;
        gameCenterController.viewState = GKGameCenterViewControllerStateLeaderboards;
        [vc presentViewController:gameCenterController animated: YES completion:nil];
    }
}

- (void)gameCenterViewControllerDidFinish:(GKGameCenterViewController*)gameCenterViewController
{
    [gameCenterViewController dismissViewControllerAnimated:YES completion:nil];
}

- (void)uploadScore:(float)score Shape:(int)shape
{
    GKScore *scoreReporter = [[GKScore alloc] initWithLeaderboardIdentifier:[self getGKIdentifierFromShape:shape]];
    int64_t myScore = (int64_t)(score * 100.0f);
    scoreReporter.value = myScore;
    NSArray *scorearray = [[NSArray alloc] initWithObjects:scoreReporter, nil];
    [GKScore reportScores:scorearray withCompletionHandler:^(NSError *error) {
        if (error) {
            NSLog(@"ERROR : reportScores");
        }
    }];
}

- (NSString*)getGKIdentifierFromShape:(int)shape
{
    switch (shape) {
        case SHAPE_CIRCLE:      return @"Hiscore_ellipse";
        case SHAPE_SQUARE:      return @"Hiscore_square";
        case SHAPE_TRIANGLE:    return @"Hiscore_triangle";
        case SHAPE_LINE:        return @"hiscore_line";
        default:                return @"";
    }
}

- (void)loadLeaderboardInfo
{
    [GKLeaderboard loadLeaderboardsWithCompletionHandler:^(NSArray *leaderboards, NSError *error) {
        self.leaderboards = leaderboards;
    }];
}

- (void) reportScore: (int64_t) myScore forLeaderboardID: (NSString*) identifier
{
    GKScore *scoreReporter = [[GKScore alloc] initWithLeaderboardIdentifier: identifier];
    scoreReporter.value = myScore;
    scoreReporter.context = 0;
    NSArray *scores = @[scoreReporter];
    [GKScore reportScores:scores withCompletionHandler:nil];
}

@end
