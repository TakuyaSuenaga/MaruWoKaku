//
//  Rounded&BorderView.m
//  MaruWoKaku
//
//  Created by Takuya Suenaga on 2014/06/11.
//  Copyright (c) 2014年 Takuya Suenaga. All rights reserved.
//

#import "Rounded&BorderView.h"
#import "MyColor.h"

@implementation Rounded_BorderView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    [[self layer] setBorderColor:[[MyColor darkGrayishYellowColor] CGColor]];
    [[self layer] setBorderWidth:10.0];
    [self setClipsToBounds:YES];
    [[self layer] setCornerRadius:10.0];
}

@end
