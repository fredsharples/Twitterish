//
//  ViewController.h
//  Twitterish
//
//  Created by Fred Sharples on 6/3/13.
//  Copyright (c) 2013 Fred Sharples. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UITableViewController {
NSArray *tweets;
    IBOutlet UIImageView *profileImage;
  IBOutlet UILabel *nameLabel;
   IBOutlet UILabel *tweetLabel;
}
- (void)fetchtweets;
- (void)reloadCellWithNewColor:(id)sender;

@end
