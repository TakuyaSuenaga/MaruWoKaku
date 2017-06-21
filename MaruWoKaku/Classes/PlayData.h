//
//  PlayData.h
//  MaruWoKaku
//
//  Created by Takuya Suenaga on 2014/06/12.
//  Copyright (c) 2014年 Takuya Suenaga. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PlayData : NSObject

@property (nonatomic) float bestScore;
@property (nonatomic) float averageScore;
@property (nonatomic) int playCount;
@property (nonatomic) UIImage *bestImage;
@property (nonatomic) UIImage *perfectShape;

@end
