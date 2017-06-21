//
//  InfoCell.m
//  MaruWoKaku
//
//  Created by Takuya Suenaga on 2014/06/13.
//  Copyright (c) 2014年 Takuya Suenaga. All rights reserved.
//

#import "InfoCell.h"
#import "MyColor.h"

@implementation InfoCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setFrame:(CGRect)frame
{
    self.backgroundColor = [MyColor lightGrayishOrangeColor];
    frame.origin.x += 10;
    frame.size.width -= 2 * 10;
    frame.origin.y += 1;
    frame.size.height -= 2 * 1;
    [self setClipsToBounds:YES];
    [[self layer] setCornerRadius:3.0f];
    [super setFrame:frame];
}

@end
