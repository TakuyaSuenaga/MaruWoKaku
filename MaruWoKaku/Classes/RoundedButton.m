//
//  RoundedButton.m
//  MaruWoKaku
//
//  Created by Takuya Suenaga on 2014/06/11.
//  Copyright (c) 2014年 Takuya Suenaga. All rights reserved.
//

#import "RoundedButton.h"
#import "MKFlatUI.h"

@implementation RoundedButton

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
    [self setClipsToBounds:YES];
    [[self layer] setCornerRadius:5.0];
    self.titleLabel.font = [UIFont MPlusFontOfSize:self.titleLabel.font.pointSize];
}

@end
