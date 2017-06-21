//
//  PerfectShape.h
//  MaruWoKaku
//
//  Created by Takuya Suenaga on 2014/06/11.
//  Copyright (c) 2014年 Takuya Suenaga. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PerfectShape : UIView

@property (nonatomic) int shape;
@property (nonatomic) CGPoint centerPoint;

// for circle
@property (nonatomic) float radius;
// for square & triangle
@property (nonatomic) CGRect pRect;
// for line
@property (nonatomic) CGPoint startPoint;
@property (nonatomic) CGPoint endPoint;

@end
