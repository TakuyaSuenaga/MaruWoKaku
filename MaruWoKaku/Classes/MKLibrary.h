//
//  MKLibrary.h
//  MaruWoKaku
//
//  Created by Takuya Suenaga on 2014/07/23.
//  Copyright (c) 2014年 Takuya Suenaga. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PlayData.h"

@interface MKLibrary : NSObject

+ (BOOL)is3_5inch;
+ (void)readySound;
+ (void)bestscoreSound;
+ (void)scoreSound;
+ (void)savePlayData:(PlayData*)data Shape:(int)shape;
+ (PlayData*)getPlayDataWithShape:(int)shape;

@end
