//
//  MKViewController.h
//  MaruWoKaku
//
//  Created by Takuya Suenaga on 2014/07/23.
//  Copyright (c) 2014年 Takuya Suenaga. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CanvasImageView.h"
#import "PlayData.h"

@interface MKViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *bestTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *averageTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *bestScoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *averageScoreLabel;
@property (weak, nonatomic) IBOutlet CanvasImageView *canvas;
@property (weak, nonatomic) IBOutlet UIView *logoView;

@property (nonatomic) PlayData *playData;
@property (nonatomic) int shape;

- (IBAction)ranking:(id)sender;

@end
