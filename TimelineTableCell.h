//
//  TimelineTableCell.h
//  Twitterish
//
//  Created by Fred Sharples on 6/4/13.
//  Copyright (c) 2013 Fred Sharples. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MCSwipeTableViewCell.h"

@interface TimelineTableCell : MCSwipeTableViewCell
@property (nonatomic, weak) IBOutlet UILabel *nameLabel;
@property (nonatomic, weak) IBOutlet UILabel *tweetLabel;
@property (nonatomic, weak) IBOutlet UIImageView *thumbnailImageView;

@end
