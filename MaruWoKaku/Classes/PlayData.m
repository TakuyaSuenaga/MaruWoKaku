//
//  PlayData.m
//  MaruWoKaku
//
//  Created by Takuya Suenaga on 2014/06/12.
//  Copyright (c) 2014年 Takuya Suenaga. All rights reserved.
//

#import "PlayData.h"

@implementation PlayData

- (void)encodeWithCoder:(NSCoder *)encoder
{
    //Encode properties, other class variables, etc
    [encoder encodeObject:[NSNumber numberWithFloat:self.bestScore]    forKey:@"PlayData_bestScore"];
    [encoder encodeObject:[NSNumber numberWithFloat:self.averageScore] forKey:@"PlayData_averageScore"];
    [encoder encodeObject:[NSNumber numberWithInt:self.playCount]      forKey:@"PlayData_playCount"];
    [encoder encodeObject:self.bestImage                               forKey:@"PlayData_bestImage"];
    [encoder encodeObject:self.perfectShape                            forKey:@"PlayData_perfectShape"];
}

- (id)initWithCoder:(NSCoder *)decoder
{
    self = [super init];
    if( self != nil )
    {
        self.bestScore    = [[decoder decodeObjectForKey:@"PlayData_bestScore"]    floatValue];
        self.averageScore = [[decoder decodeObjectForKey:@"PlayData_averageScore"] floatValue];
        self.playCount    = [[decoder decodeObjectForKey:@"PlayData_playCount"]    intValue];
        self.bestImage    = [decoder decodeObjectForKey:@"PlayData_bestImage"];
        self.perfectShape = [decoder decodeObjectForKey:@"PlayData_perfectShape"];
    }
    return self;
}

@end
