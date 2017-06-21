//
//  MKLibrary.m
//  MaruWoKaku
//
//  Created by Takuya Suenaga on 2014/07/23.
//  Copyright (c) 2014年 Takuya Suenaga. All rights reserved.
//

@import AVFoundation;

#import "MKLibrary.h"

@implementation MKLibrary

AVAudioPlayer *audioBestScore;
AVAudioPlayer *audioScore;

+ (BOOL)is3_5inch
{
    CGRect screenSize = [UIScreen mainScreen].bounds;
    if (screenSize.size.height <= 480) {
        return TRUE;
    } else {
        return FALSE;
    }
}

+ (void)readySound
{
    audioBestScore = [self initAudio:@"se_bestscore"];
    audioScore     = [self initAudio:@"se_score"];

    [audioBestScore prepareToPlay];
    [audioScore     prepareToPlay];
}

+ (void)bestscoreSound
{
    audioBestScore.currentTime = 0;
    [audioBestScore play];
}

+ (void)scoreSound
{
    audioScore.currentTime = 0;
    [audioScore play];
}

+ (AVAudioPlayer*)initAudio:(NSString*)file
{
    NSBundle *mainBundle = [NSBundle mainBundle];
    NSString *filePath = [mainBundle pathForResource:file ofType:@"mp3"];
    NSURL *fileUrl = [NSURL fileURLWithPath:filePath];
    NSError *error = nil;
    return [[AVAudioPlayer alloc] initWithContentsOfURL:fileUrl error:&error];
}

+ (void)savePlayData:(PlayData*)data Shape:(int)shape
{
    NSUserDefaults *userDefault=[NSUserDefaults standardUserDefaults];
    NSData *myEncodedObject = [NSKeyedArchiver archivedDataWithRootObject:data];
    [userDefault setObject:myEncodedObject forKey:[self getKeyFromShape:shape]];
    [userDefault synchronize];
}

+ (PlayData*)getPlayDataWithShape:(int)shape
{
    NSUserDefaults *userDefault= [NSUserDefaults standardUserDefaults];
    NSData *myDecodedObject = [userDefault objectForKey:[self getKeyFromShape:shape]];
    return [NSKeyedUnarchiver unarchiveObjectWithData: myDecodedObject];
}

+ (NSString*)getKeyFromShape:(int)shape
{
    switch (shape) {
        case SHAPE_CIRCLE:      return @"PlayData_Circle";
        case SHAPE_SQUARE:      return @"PlayData_Square";
        case SHAPE_TRIANGLE:    return @"PlayData_Triangle";
        case SHAPE_LINE:        return @"PlayData_Line";
        default:                return @"";
    }
}

@end
