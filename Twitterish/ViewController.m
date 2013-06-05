//
//  ViewController.m
//  Twitterish
//
//  Created by Fred Sharples on 6/3/13.
//  Copyright (c) 2013 Fred Sharples. All rights reserved.
//

#import "ViewController.h"
#import "TimelineTableCell.h"


@interface ViewController ()
{
  NSMutableArray *_objects;  
}
@end

@implementation ViewController



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return tweets.count;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"TimelineTableCell";
    
    TimelineTableCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"TimelineTableCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
        
    }
    
    NSDictionary *tweet = [tweets objectAtIndex:indexPath.row];
    NSString *text = [tweet objectForKey:@"text"];
    NSString *name = [[tweet objectForKey:@"user"] objectForKey:@"name"];
    NSString *imageUrl = [[tweet objectForKey:@"user"] objectForKey:@"profile_image_url"];
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageUrl]];
    
    cell.nameLabel.text = name;
    cell.tweetLabel.text = text;
    cell.imageView.image = [UIImage imageWithData:data];
    

    return cell;
    
}

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
    NSLog(@"Tweets have been loaded");
    
}


- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    //self.navigationItem.leftBarButtonItem = self.editButtonItem;
    
    //UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
    //self.navigationItem.rightBarButtonItem = addButton;
    
    [self fetchtweets];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)insertNewObject:(id)sender
{
    if (!_objects) {
        _objects = [[NSMutableArray alloc] init];
    }
    [_objects insertObject:[NSDate date] atIndex:0];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

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

@end
