//
//  GalleryView.h
//  Gallery
//
//  Created by Takuya Suenaga on 2014/06/19.
//  Copyright (c) 2014年 Takuya Suenaga. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FlatUIKit.h"

@interface GalleryView : UIView

@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIImageView *perfectView;

@end
