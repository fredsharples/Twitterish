//
//  TimelineTableCell.m
//  Twitterish
//
//  Created by Fred Sharples on 6/4/13.
//  Copyright (c) 2013 Fred Sharples. All rights reserved.
//

#import "TimelineTableCell.h"

@implementation TimelineTableCell



- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
