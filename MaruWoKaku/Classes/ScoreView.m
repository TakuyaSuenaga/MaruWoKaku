//
//  ScoreView.m
//  MaruWoKaku
//
//  Created by Takuya Suenaga on 2014/06/10.
//  Copyright (c) 2014年 Takuya Suenaga. All rights reserved.
//

#import "ScoreView.h"
#import "MyColor.h"

@implementation ScoreView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"ScoreView" owner:self options:nil];
        [self addSubview:[array objectAtIndex:0]];
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    [[self layer] setBorderColor:[[MyColor darkGrayishYellowColor] CGColor]];
    [[self layer] setBorderWidth:5.0];
    [self setClipsToBounds:YES];
    [[self layer] setCornerRadius:5.0];
}

@end
