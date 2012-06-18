//
//  vidNotificationsViewController.m
//  vidcon
//
//  Created by Tyler Dodge on 6/13/12.
//
//

#import "vidNotificationsViewController.h"
#import <Parse/Parse.h>
#import "vidAppDelegate.h"
#import "vidNotification.h"
#import "vidNotificationCell.h"
#define TWITTER_CELL_IDENTIFIER @"twitterCell"
#define NOTIFICATION_CELL_IDENTIFIER @"notificationCell"
#define TEXT_PADDING 45
@interface vidNotificationsViewController ()
@property (strong, nonatomic) NSArray * data;
@property (strong, nonatomic) UITextView * heightSizingCell;
@property (strong, nonatomic) UIBarButtonItem * refreshButton;
@end

@implementation vidNotificationsViewController
@synthesize data = _data;
@synthesize heightSizingCell = _heightSizingCell;
@synthesize refreshButton = _refreshButton;
-(UITextView *)heightSizingCell
{
    if (!_heightSizingCell)
        _heightSizingCell = [(vidNotificationCell *)[self.tableView dequeueReusableCellWithIdentifier:NOTIFICATION_CELL_IDENTIFIER] detailsView];
    return _heightSizingCell;
}

-(NSArray *)data
{
    if (!_data) {
        _data = [[NSArray alloc] init];
    }
    return _data;
}
-(void)setData:(NSArray *)data
{
    _data = data;
    [self.tableView reloadData];
}
- (IBAction)clickedRefresh:(UIBarButtonItem *)sender {
    self.refreshButton = sender;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite]];
    dispatch_queue_t queue = [(vidAppDelegate *)[[UIApplication sharedApplication] delegate] parseQueue];
    dispatch_async(queue, ^{
        PFQuery * query = [PFQuery queryWithClassName:@"notifications"];
        [query whereKey:@"type" equalTo:@"notification" ];
        PFQuery * twitter = [PFQuery queryWithClassName:@"notifications"];
        [twitter whereKey:@"type" equalTo:@"twitter"];
        PFQuery * queries = [PFQuery orQueryWithSubqueries:[NSArray arrayWithObjects:query,twitter,nil]];
        [queries orderByDescending:@"createdAt"];
        NSArray * notifications = [queries findObjects];
        NSMutableArray * newData = [[NSMutableArray alloc] init];
        for (PFObject * notification in notifications) {
            vidNotification * vidNote =[[vidNotification alloc] initWithDate:notification.createdAt withDetails:[notification objectForKey:@"description"] withType:[[notification objectForKey:@"type"] isEqualToString:@"notification"] ? vidNotificationTypeNotification : vidNotificationTypeTwitter];
            [newData addObject:vidNote];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^ {
            self.data = newData;
            self.navigationItem.rightBarButtonItem = self.refreshButton;
            self.refreshButton =nil;
        });
    });
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    dispatch_queue_t queue = [(vidAppDelegate *)[[UIApplication sharedApplication] delegate] parseQueue];
    dispatch_async(queue, ^{
        PFQuery * query = [PFQuery queryWithClassName:@"notifications"];
        [query whereKey:@"type" equalTo:@"notification" ];
        PFQuery * twitter = [PFQuery queryWithClassName:@"notifications"];
        [twitter whereKey:@"type" equalTo:@"twitter"];
        PFQuery * queries = [PFQuery orQueryWithSubqueries:[NSArray arrayWithObjects:query,twitter,nil]];
        [queries orderByDescending:@"createdAt"];
        NSArray * notifications = [queries findObjects];
        NSMutableArray * newData = [[NSMutableArray alloc] init];
        for (PFObject * notification in notifications) {
            vidNotification * vidNote =[[vidNotification alloc] initWithDate:notification.createdAt withDetails:[notification objectForKey:@"description"] withType:[[notification objectForKey:@"type"] isEqualToString:@"notification"] ? vidNotificationTypeNotification : vidNotificationTypeTwitter];
            [newData addObject:vidNote];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^ {
            self.data = newData;
        });
    });
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    vidNotification * notification = [self.data objectAtIndex:[indexPath indexAtPosition:1]];
    UITableViewCell * cell = nil;
    if (notification.type == vidNotificationTypeNotification) {
        cell = [tableView dequeueReusableCellWithIdentifier:NOTIFICATION_CELL_IDENTIFIER];
    } else if (notification.type == vidNotificationTypeTwitter) {
        cell = [tableView dequeueReusableCellWithIdentifier:TWITTER_CELL_IDENTIFIER];
    }
    vidNotificationCell * notificationCell = (vidNotificationCell *)cell;
    notificationCell.detailsView.text = notification.details;
    NSDateFormatter * dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"h:mm a MMM dd"];
    dateFormat.timeZone = [NSTimeZone timeZoneWithAbbreviation:@"PDT"];
    notificationCell.dateLabel.text = [dateFormat stringFromDate:notification.date];
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    vidNotification * notification = [self.data objectAtIndex:[indexPath indexAtPosition:1]];
    CGSize dimensions = [notification.details sizeWithFont:self.heightSizingCell.font constrainedToSize:CGSizeMake(self.heightSizingCell.frame.size.width, MAXFLOAT) lineBreakMode:UILineBreakModeWordWrap];
    return self.heightSizingCell.frame.origin.y + dimensions.height + TEXT_PADDING;
}


@end
