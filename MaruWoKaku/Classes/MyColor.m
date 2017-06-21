//
//  MyColor.m
//  MaruWoKaku
//
//  Created by Takuya Suenaga on 2014/06/11.
//  Copyright (c) 2014年 Takuya Suenaga. All rights reserved.
//

#import "MyColor.h"

@implementation MyColor

// Thanks to http://stackoverflow.com/questions/3805177/how-to-convert-hex-rgb-color-codes-to-uicolor
+ (UIColor *) colorFromHexCode:(NSString *)hexString {
    NSString *cleanString = [hexString stringByReplacingOccurrencesOfString:@"#" withString:@""];
    if ([cleanString length] == 3) {
        cleanString = [NSString stringWithFormat:@"%@%@%@%@%@%@",
                       [cleanString substringWithRange:NSMakeRange(0, 1)],[cleanString substringWithRange:NSMakeRange(0, 1)],
                       [cleanString substringWithRange:NSMakeRange(1, 1)],[cleanString substringWithRange:NSMakeRange(1, 1)],
                       [cleanString substringWithRange:NSMakeRange(2, 1)],[cleanString substringWithRange:NSMakeRange(2, 1)]];
    }
    if([cleanString length] == 6) {
        cleanString = [cleanString stringByAppendingString:@"ff"];
    }
    
    unsigned int baseValue;
    [[NSScanner scannerWithString:cleanString] scanHexInt:&baseValue];
    
    float red = ((baseValue >> 24) & 0xFF)/255.0f;
    float green = ((baseValue >> 16) & 0xFF)/255.0f;
    float blue = ((baseValue >> 8) & 0xFF)/255.0f;
    float alpha = ((baseValue >> 0) & 0xFF)/255.0f;
    
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}

+ (UIColor *) darkCyanColor {
    static UIColor *darkCyan = nil;
    static dispatch_once_t dispatchToken;
    
    dispatch_once(&dispatchToken, ^{
        darkCyan = [MyColor colorFromHexCode:@"0E3035"];
    });
    
    return darkCyan;
}

+ (UIColor *) darkGrayishYellowColor {
    static UIColor *darkGrayishYellow = nil;
    static dispatch_once_t dispatchToken;
    
    dispatch_once(&dispatchToken, ^{
        darkGrayishYellow = [MyColor colorFromHexCode:@"46433A"];
    });
    
    return darkGrayishYellow;
}

+ (UIColor *) lightGrayishOrangeColor {
    static UIColor *lightGrayishOrange = nil;
    static dispatch_once_t dispatchToken;
    
    dispatch_once(&dispatchToken, ^{
        lightGrayishOrange = [MyColor colorFromHexCode:@"DED4B9"];
    });
    
    return lightGrayishOrange;
}

+ (UIColor *) slightlyDesaturatedCyanColor {
    static UIColor *slightlyDesaturatedCyan = nil;
    static dispatch_once_t dispatchToken;
    
    dispatch_once(&dispatchToken, ^{
        slightlyDesaturatedCyan = [MyColor colorFromHexCode:@"64B6B1"];
    });
    
    return slightlyDesaturatedCyan;
}

+ (UIColor *) moderateRedColor {
    static UIColor *moderateRed = nil;
    static dispatch_once_t dispatchToken;
    
    dispatch_once(&dispatchToken, ^{
        moderateRed = [MyColor colorFromHexCode:@"CE534D"];
    });
    
    return moderateRed;
}

+ (UIColor *) darkModerateCyanColor {
    static UIColor *moderateRed = nil;
    static dispatch_once_t dispatchToken;
    
    dispatch_once(&dispatchToken, ^{
        moderateRed = [MyColor colorFromHexCode:@"4A9D98"];
    });
    
    return moderateRed;
}

@end
