//
//  GCManager.h
//  MaruWoKaku
//
//  Created by Takuya Suenaga on 2014/07/23.
//  Copyright (c) 2014年 Takuya Suenaga. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GCManager : NSObject

@property (nonatomic) NSArray *leaderboards;

+ (GCManager *)sharedManager;
- (void)authenticateLocalPlayer:(UIViewController*)vc;
- (void)loadPlayerData:(NSArray *) identifiers;
- (void)showGameCenter:(UIViewController *)vc;
- (void) showLeaderboard:(NSString *)leaderboardID viewController:(UIViewController *)vc;
- (void)uploadScore:(float)score Shape:(int)shape;
- (NSString*)getGKIdentifierFromShape:(int)shape;
- (void)loadLeaderboardInfo;
- (void) reportScore: (int64_t) myScore forLeaderboardID: (NSString*) identifier;

@end
