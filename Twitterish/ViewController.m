//
//  ViewController.m
//  Twitterish
//
//  Created by Fred Sharples on 6/3/13.
//  Copyright (c) 2013 Fred Sharples. All rights reserved.
//

#import "ViewController.h"
#import "MCSwipeTableViewCell.h"
#import "TimelineTableCell.h"

@interface ViewController () <MCSwipeTableViewCellDelegate>
{
  NSMutableArray *_objects;  
}
//@property(nonatomic,assign) NSUInteger nbItems;

@end

@implementation ViewController

- (id)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    if (self) {
       // _nbItems = 2;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self fetchtweets];
    
    UIView *backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
    [backgroundView setBackgroundColor:[UIColor colorWithRed:227.0 / 255.0 green:227.0 / 255.0 blue:227.0 / 255.0 alpha:1.0]];
    [self.tableView setBackgroundView:backgroundView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return tweets.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
 


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90.0;
}


- (void)awakeFromNib {
    [super awakeFromNib];
}

#pragma mark - Table view layout

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSDictionary *tweet = [tweets objectAtIndex:indexPath.row];
    NSString *tweetText = [tweet objectForKey:@"text"];
    NSString *name = [[tweet objectForKey:@"user"] objectForKey:@"name"];
    NSString *imageUrl = [[tweet objectForKey:@"user"] objectForKey:@"profile_image_url"];
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageUrl]];
    
    static NSString *CellIdentifier = @"TweetCell";
    
    
    //MCSwipeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    TimelineTableCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    
    if (cell == nil) {
       //cell = [[MCSwipeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        //for use with a nib
        
       // NSArray *nib = [[NSBundle mainBundle] loadNibNamed:CellIdentifier owner:self options:nil];
       // cell = (MCSwipeTableViewCell *)[nib objectAtIndex:0];
        
        cell = [[MCSwipeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }

    
    [cell setDelegate:self];
    ////////////////
    ////////////////
    //Cell customization with external nib
    //cell.imageView.image = [UIImage imageWithData:data];
    //cell.nameLabel.text = name;
    //cell.tweetLabel.text = tweetText;
    //cell.thumbnailImageView.image = [UIImage imageWithData:data];
    
    //using storyboard
    
    UIImageView *tweetImageView = (UIImageView *)[cell viewWithTag:100];
    tweetImageView.image = [UIImage imageWithData:data];

    
    UILabel *tweetNameLabel = (UILabel *)[cell viewWithTag:101];
    tweetNameLabel.text = name;
    
    UILabel *tweetContentLabel = (UILabel *)[cell viewWithTag:102];
    tweetContentLabel.text = tweetText;
    

    
    //Using SubtitleStyle
   // [cell.textLabel setText:name];
   // [cell.detailTextLabel setText:tweetText];
    
    /*
        //Using Subviews
        UILabel *customLabelText = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, 100,20)];
        customLabelText.font = [UIFont fontWithName:@"Avenir" size:11.0];
        customLabelText.textColor = [UIColor grayColor];
        [customLabelText setText:name];
        
        [cell.contentView addSubview:customLabelText];
        
        //Customize the Tweet Text
        UILabel *customTweetText = [[UILabel alloc] initWithFrame:CGRectMake(80, 5, 230, 70)];
        customTweetText.font = [UIFont fontWithName:@"Avenir" size:15.0];
        customTweetText.textColor = [UIColor blackColor];
        customTweetText.numberOfLines = 8;
        [customTweetText setText:tweetText];
        
        [cell.contentView addSubview:customTweetText];
     */

       // cell.imageView.image = [UIImage imageWithData:data];
        
    
    
    [cell setFirstStateIconName:@"check.png"
                     firstColor:[UIColor colorWithRed:85.0 / 255.0 green:213.0 / 255.0 blue:80.0 / 255.0 alpha:1.0]
            secondStateIconName:@"cross.png"
                    secondColor:[UIColor colorWithRed:232.0 / 255.0 green:61.0 / 255.0 blue:14.0 / 255.0 alpha:1.0]
                  thirdIconName:@"clock.png"
                     thirdColor:[UIColor colorWithRed:254.0 / 255.0 green:217.0 / 255.0 blue:56.0 / 255.0 alpha:1.0]
                 fourthIconName:@"list.png"
                    fourthColor:[UIColor colorWithRed:206.0 / 255.0 green:149.0 / 255.0 blue:98.0 / 255.0 alpha:1.0]];
    
    [cell.contentView setBackgroundColor:[UIColor whiteColor]];
    [cell setSelectionStyle:UITableViewCellSelectionStyleGray];

    [cell setMode:MCSwipeTableViewCellModeExit];
    
    return cell;
    
}

#pragma mark - Get data from Twitter

- (void) fetchtweets
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
       // NSData* data = [NSData dataWithContentsOfURL:[NSURL URLWithString: @"https://api.twitter.com/1.1/statuses/user_timeline.json?screen_name=@fredsharples&count=20&include_entities=1&include_rts=1"]];
        
        NSData* data = [NSData dataWithContentsOfURL:[NSURL URLWithString: @"http://api.twitter.com/1/statuses/user_timeline.json?screen_name=@fredsharples&count=20&include_entities=1&include_rts=1"]];
        
        NSError* error;
        
        tweets = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    });    
}





#pragma mark - MCSwipeTableViewCellDelegate

- (void)swipeTableViewCell:(MCSwipeTableViewCell *)cell didTriggerState:(MCSwipeTableViewCellState)state withMode:(MCSwipeTableViewCellMode)mode {
    NSLog(@"IndexPath : %@ - MCSwipeTableViewCellState : %d - MCSwipeTableViewCellMode : %d", [self.tableView indexPathForCell:cell], state, mode);
   
    
    if (mode == MCSwipeTableViewCellModeExit) {
        [UIView animateWithDuration:0.4 animations:^{
            cell.slidingImageView.alpha = 1.0;
            cell.slidingImageView.alpha = 0.0;
            cell.colorIndicatorView.alpha = 1.0;
            cell.colorIndicatorView.alpha = 0.0;
            //[cell.textLabel setTextColor:[UIColor redColor]];
        }
         
            completion:^(BOOL finished) {
               //[ self reload:self];
                [self reloadCellWithNewColor:cell];
                
                
            }];
                 

        }
         
}
- (void)reloadCellWithNewColor:(MCSwipeTableViewCell *)cell{
    //[super reloadCellWithNewColor:newColor];
//    cell.backgroundColor = [UIColor redColor];
    [cell.textLabel setTextColor:[UIColor redColor]];
    //[cell.detailTextLabel setText:tweetText];
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];
}


- (void)reload:(id)sender {

    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationAutomatic];
}

@end
