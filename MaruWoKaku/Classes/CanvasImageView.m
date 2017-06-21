//
//  CanvasImageView.m
//  MaruWoKaku
//
//  Created by Takuya Suenaga on 2014/06/11.
//  Copyright (c) 2014年 Takuya Suenaga. All rights reserved.
//

#import "CanvasImageView.h"
#import "MyColor.h"

@implementation CanvasImageView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)clearView
{
    self.image = nil;
    [self.perfectShape removeFromSuperview];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"touchesBegan");
    
    [self clearView];

    // Save the coordinates of the touch point
    UITouch *touch = [touches anyObject];
    touchPoint = [touch locationInView:self];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    // Save the coordinates of the touch point
    UITouch *touch = [touches anyObject];
    CGPoint currentPoint = [touch locationInView:self];
    
    // Create drawing field
    UIGraphicsBeginImageContext(self.frame.size);
    
    // Draw current image
    [self.image drawInRect:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    
    // Set line rounded
    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
    
    // Set line width
    CGContextSetLineWidth(UIGraphicsGetCurrentContext(), 6.0);
    
    // Set line color
    int r = ((DarkGrayishYellowColor >> 16) & 0xFF);
    int g = ((DarkGrayishYellowColor >>  8) & 0xFF);
    int b = ((DarkGrayishYellowColor >>  0) & 0xFF);
    CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), r/255.0f, g/255.0f, b/255.0f, 1.0);
    
    // Set the coordinates of the start point
    CGContextMoveToPoint(UIGraphicsGetCurrentContext(), touchPoint.x, touchPoint.y);
    
    // Set the coordinates of the end point
    CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), currentPoint.x, currentPoint.y);
    
    // Draw line from the start point to the end point
    CGContextStrokePath(UIGraphicsGetCurrentContext());
    
    // Set drawing field as a image
    self.image = UIGraphicsGetImageFromCurrentImageContext();
    
    // Clear drawing field
    UIGraphicsEndImageContext();
    
    // Set the current coordinates to the next coordinates of the start point
    touchPoint = currentPoint;
    
    flagMove = TRUE;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"touchesEnded:");
    
    if (flagMove == TRUE) {
        flagMove = FALSE;
        [self.delegate drawEnd:self];
    }
}

@end
