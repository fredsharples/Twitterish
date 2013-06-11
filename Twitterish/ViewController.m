//
//  ViewController.m
//  Twitterish
//
//  Created by Fred Sharples on 6/3/13.
//  Copyright (c) 2013 Fred Sharples. All rights reserved.
//

#import "ViewController.h"
#import "TimelineTableCell.h"
#import "MCSwipeTableViewCell.h"





@interface ViewController () <MCSwipeTableViewCellDelegate>
{
  NSMutableArray *_objects;  
}
@property(nonatomic,assign) NSUInteger nbItems;

@end

@implementation ViewController

- (id)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    if (self) {
       // _nbItems = 2;
    }
    return self;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return tweets.count;
}


#pragma mark - Table view layout

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    NSDictionary *tweet = [tweets objectAtIndex:indexPath.row];
    NSString *tweetText = [tweet objectForKey:@"text"];
    NSString *name = [[tweet objectForKey:@"user"] objectForKey:@"name"];
    NSString *imageUrl = [[tweet objectForKey:@"user"] objectForKey:@"profile_image_url"];
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageUrl]];
    
    MCSwipeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TimelineTableCell"];
    
    if (cell == nil) {
       cell = [[MCSwipeTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"TimelineTableCell"];
                
        //Customize the Title.
        UILabel *customLabelText = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, 100,20)];
        customLabelText.font = [UIFont fontWithName:@"Avenir" size:10.0];
        //customLabelText.font = [UIFont boldSystemFontOfSize:12.0];
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

        cell.imageView.image = [UIImage imageWithData:data];
        
    }
    
    [cell setDelegate:self];
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
   // NSLog(@"Tweets have been loaded");
    
}


- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self fetchtweets];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*- (void)insertNewObject:(id)sender
{
    if (!_objects) {
        _objects = [[NSMutableArray alloc] init];
    }
    [_objects insertObject:[NSDate date] atIndex:0];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}
 */

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{

}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 96;
}

#pragma mark - MCSwipeTableViewCellDelegate

- (void)swipeTableViewCell:(MCSwipeTableViewCell *)cell didTriggerState:(MCSwipeTableViewCellState)state withMode:(MCSwipeTableViewCellMode)mode {
    NSLog(@"IndexPath : %@ - MCSwipeTableViewCellState : %d - MCSwipeTableViewCellMode : %d", [self.tableView indexPathForCell:cell], state, mode);
    
    if (mode == MCSwipeTableViewCellModeExit) {
        NSLog(@"Right on");
        
        [UIView animateWithDuration:1.0 animations:^{
            cell.alpha = 1.0;
            cell.alpha = 0.0;
        }];
        
        [UIView commitAnimations];
        
        
        //_nbItems--;
       // [self.tableView deleteRowsAtIndexPaths:@[[self.tableView indexPathForCell:cell]] withRowAnimation:UITableViewRowAnimationFade];
    }
}

@end
