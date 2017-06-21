//
//  ScoreView.h
//  MaruWoKaku
//
//  Created by Takuya Suenaga on 2014/06/10.
//  Copyright (c) 2014年 Takuya Suenaga. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScoreView : UIView

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;

@property (nonatomic) float score;

@end
