//
//  MyColor.h
//  MaruWoKaku
//
//  Created by Takuya Suenaga on 2014/06/11.
//  Copyright (c) 2014年 Takuya Suenaga. All rights reserved.
//

#import <UIKit/UIKit.h>

#define DarkCyanColor                   0x0E3035
#define DarkGrayishYellowColor          0x46433A
#define LightGrayishOrangeColor         0xDED4B9
#define SlightlyDesaturatedCyanColor    0x64B6B1
#define ModerateRedColor                0xCE534D
#define DarkModerateCyanColor           0x4A9D98

#define UIColorHex(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface MyColor : NSObject

+ (UIColor *) colorFromHexCode:(NSString *)hexString;
+ (UIColor *) darkCyanColor;
+ (UIColor *) darkGrayishYellowColor;
+ (UIColor *) lightGrayishOrangeColor;
+ (UIColor *) slightlyDesaturatedCyanColor;
+ (UIColor *) moderateRedColor;
+ (UIColor *) darkModerateCyanColor;

@end
