//
//  MKMenuViewController.h
//  MaruWoKaku
//
//  Created by Takuya Suenaga on 2014/07/23.
//  Copyright (c) 2014年 Takuya Suenaga. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MKMenuViewController : UIViewController <UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIPageControl *page;

- (IBAction)back:(id)sender;

@end
