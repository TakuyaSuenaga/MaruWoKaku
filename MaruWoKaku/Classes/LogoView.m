//
//  LogoView.m
//  MaruWoKaku
//
//  Created by Takuya Suenaga on 2014/06/10.
//  Copyright (c) 2014年 Takuya Suenaga. All rights reserved.
//

#import "LogoView.h"
#import "MyColor.h"

@implementation LogoView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [MyColor darkCyanColor];
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    [self setClipsToBounds:YES];
    [[self layer] setCornerRadius:10.0];

    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 6.0);
    int r = ((LightGrayishOrangeColor >> 16) & 0xFF);
    int g = ((LightGrayishOrangeColor >>  8) & 0xFF);
    int b = ((LightGrayishOrangeColor >>  0) & 0xFF);
    CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), r/255.0f, g/255.0f, b/255.0f, 1.0);
    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
    switch (self.shape) {
        case SHAPE_CIRCLE:
            CGContextAddEllipseInRect(context, CGRectMake(15, 15, 70, 70));
            break;
        case SHAPE_SQUARE:
            CGContextStrokeRect(context, CGRectMake(20, 20, 60, 60));
            break;
        case SHAPE_TRIANGLE:
            CGContextMoveToPoint(context, self.frame.size.width / 2, 20);
            CGContextAddLineToPoint(context, self.frame.size.width-20, self.frame.size.height-20);
            CGContextAddLineToPoint(context, 20, self.frame.size.height-20);
            CGContextAddLineToPoint(context, self.frame.size.width / 2, 20);
            break;
        case SHAPE_LINE:
            CGContextMoveToPoint(context, self.frame.size.width / 2, 15);
            CGContextAddLineToPoint(context, self.frame.size.width / 2, self.frame.size.height-15);
            break;
//        case SHAPE_HEART:
//        {
//            CGPoint origin = self.frame.origin;
//            origin.x += 10;
//            origin.y += 10;
//            CGSize size = self.frame.size;
//            size.width -= 20;
//            size.height -= 30;
//            CGPoint lCircle = CGPointMake(origin.x + size.width * 0.75, origin.y + size.width * 0.25);
//            CGContextAddArc(context, lCircle.x, lCircle.y, size.width * 0.25, 0, M_PI, YES);
//            
//            CGPoint rCircle = CGPointMake(origin.x + size.width * 0.25, origin.y + size.width * 0.25);
//            CGContextAddArc(context, rCircle.x, rCircle.y, size.width * 0.25, 0, M_PI, YES);
//            
//            CGPoint lcp1 = CGPointMake(origin.x, size.height * 0.75);
//            CGPoint lcp2 = CGPointMake(origin.x + size.width * 0.5, origin.y + size.height * 0.95);
//            CGContextAddCurveToPoint(context, lcp1.x, lcp1.y, lcp2.x, lcp2.y, origin.x + size.width * 0.5, origin.y * 2 + size.height);
//            
//            CGPoint rcp1 = CGPointMake(origin.x + size.width, size.height * 0.75);
//            CGPoint rcp2 = CGPointMake(origin.x + size.width * 0.5, origin.y + size.height * 0.95);
//            CGContextAddCurveToPoint(context, rcp2.x, rcp2.y, rcp1.x, rcp1.y, origin.x + size.width, origin.y + size.width * 0.25);
//            break;
//        }
            
        default:
            break;
    }
    CGContextStrokePath(context);
}

- (id)initWithFrame:(CGRect)frame shape:(int)shape
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [MyColor darkCyanColor];
        self.shape = shape;
    }
    return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.delegate clickedLogoView];
}

@end
