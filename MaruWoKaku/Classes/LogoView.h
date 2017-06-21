//
//  LogoView.h
//  MaruWoKaku
//
//  Created by Takuya Suenaga on 2014/06/10.
//  Copyright (c) 2014年 Takuya Suenaga. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LogoView;

@protocol LogoViewDelegate

- (void)clickedLogoView;

@end


@interface LogoView : UIView

@property (weak, nonatomic) id <LogoViewDelegate> delegate;
@property (nonatomic) int shape;

- (id)initWithFrame:(CGRect)frame shape:(int)shape;

@end
