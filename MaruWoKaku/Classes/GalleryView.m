//
//  GalleryView.m
//  Gallery
//
//  Created by Takuya Suenaga on 2014/06/19.
//  Copyright (c) 2014年 Takuya Suenaga. All rights reserved.
//

#import "GalleryView.h"

@implementation GalleryView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"GalleryView" owner:self options:nil];
        [self addSubview:[array objectAtIndex:0]];
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    self.perfectView.hidden = !self.perfectView.hidden;
}

@end
