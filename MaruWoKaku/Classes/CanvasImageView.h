//
//  CanvasImageView.h
//  MaruWoKaku
//
//  Created by Takuya Suenaga on 2014/06/11.
//  Copyright (c) 2014年 Takuya Suenaga. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CanvasImageView;

@protocol CanvasImageViewDelegate

- (void)drawEnd:(CanvasImageView *)imageView;

@end

@interface CanvasImageView : UIImageView

{
    CGPoint touchPoint;
    BOOL flagMove;
}

@property (weak, nonatomic) id <CanvasImageViewDelegate> delegate;
@property (nonatomic) UIView *perfectShape;

- (void)clearView;

@end
