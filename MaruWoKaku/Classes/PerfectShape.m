//
//  PerfectShape.m
//  MaruWoKaku
//
//  Created by Takuya Suenaga on 2014/06/11.
//  Copyright (c) 2014年 Takuya Suenaga. All rights reserved.
//

#import "PerfectShape.h"
#import "MyColor.h"

@implementation PerfectShape

@synthesize shape, centerPoint, radius, pRect;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 6.0);
    int r = ((ModerateRedColor >> 16) & 0xFF);
    int g = ((ModerateRedColor >>  8) & 0xFF);
    int b = ((ModerateRedColor >>  0) & 0xFF);
    CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), r/255.0f, g/255.0f, b/255.0f, 1.0);
    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
    switch (shape) {
        case SHAPE_CIRCLE:
            CGContextAddEllipseInRect(context, CGRectMake(centerPoint.x-radius, centerPoint.y-radius, radius*2, radius*2));
            break;
        case SHAPE_SQUARE:
            pRect.origin.x += 3;
            pRect.origin.y += 3;
            pRect.size.width -= 6;
            pRect.size.height -= 6;
            CGContextStrokeRect(context, pRect);
            break;
        case SHAPE_TRIANGLE:
            pRect.origin.x += 3;
            pRect.origin.y += 3;
            pRect.size.width -= 6;
            pRect.size.height -= 6;
            CGContextMoveToPoint(context, pRect.origin.x + pRect.size.width / 2, pRect.origin.y);
            CGContextAddLineToPoint(context, pRect.origin.x + pRect.size.width, pRect.origin.y + pRect.size.height);
            CGContextAddLineToPoint(context, pRect.origin.x, pRect.origin.y + pRect.size.height);
            CGContextAddLineToPoint(context, pRect.origin.x + pRect.size.width / 2, pRect.origin.y);
            break;
        case SHAPE_LINE:
            CGContextMoveToPoint(context, self.startPoint.x, self.startPoint.y);
            CGContextAddLineToPoint(context, self.endPoint.x, self.endPoint.y);
            break;
/*
        case SHAPE_HEART:
        {
            CGPoint origin = pRect.origin;
            origin.x += 3;
            origin.y += 3;
            CGSize size = pRect.size;
            size.width -= 6;
            size.height -= 6;
            CGPoint lCircle = CGPointMake(origin.x + size.width * 0.75, origin.y + size.width * 0.25);
            CGContextAddArc(context, lCircle.x, lCircle.y, size.width * 0.25, 0, M_PI, YES);
            
            CGPoint rCircle = CGPointMake(origin.x + size.width * 0.25, origin.y + size.width * 0.25);
            CGContextAddArc(context, rCircle.x, rCircle.y, size.width * 0.25, 0, M_PI, YES);
            
            CGPoint lcp1 = CGPointMake(origin.x, size.height * 0.75);
            CGPoint lcp2 = CGPointMake(origin.x + size.width * 0.5, origin.y + size.height * 0.95);
            CGContextAddCurveToPoint(context, lcp1.x, lcp1.y, lcp2.x, lcp2.y, origin.x + size.width * 0.5, origin.y + 3 * 2 + size.height);
            
            CGPoint rcp1 = CGPointMake(origin.x + size.width, size.height * 0.75);
            CGPoint rcp2 = CGPointMake(origin.x + size.width * 0.5, origin.y + size.height * 0.95);
            CGContextAddCurveToPoint(context, rcp2.x, rcp2.y, rcp1.x, rcp1.y, origin.x + size.width, origin.y + size.width * 0.25);
            break;
        }
 */
            
        default:
            break;
    }
    CGContextStrokePath(context);
}

@end
