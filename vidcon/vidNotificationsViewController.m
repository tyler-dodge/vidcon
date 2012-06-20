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
#import "Reachability.h"
#define TWITTER_CELL_IDENTIFIER @"twitterCell"
#define NOTIFICATION_CELL_IDENTIFIER @"notificationCell"
#define TEXT_PADDING 45
@interface vidNotificationsViewController () <vidNewsDelegate>
@property (strong, nonatomic) NSArray * data;
@property (strong, nonatomic) Reachability * reachability;
@property (strong, nonatomic) UITextView * heightSizingCell;
@property (strong, nonatomic) UIBarButtonItem * refreshButton;
@property (atomic) BOOL isRefreshing;
@property (atomic) BOOL hasInternetConnection;
@property (strong, nonatomic) NSLock * refreshLock;
@end

@implementation vidNotificationsViewController
@synthesize hasInternetConnection = _hasInternetConnection;
@synthesize isRefreshing = _isRefreshing;
@synthesize data = _data;
@synthesize heightSizingCell = _heightSizingCell;
@synthesize refreshButton = _refreshButton;
@synthesize refreshLock = _refreshLock;
@synthesize reachability = _reachability;
-(UITextView *)heightSizingCell
{
    if (!_heightSizingCell)
        _heightSizingCell = [(vidNotificationCell *)[self.tableView dequeueReusableCellWithIdentifier:NOTIFICATION_CELL_IDENTIFIER] detailsView];
    return _heightSizingCell;
}

-(NSLock *)refreshLock
{
    if (!_refreshLock)
        _refreshLock = [[NSLock alloc] init];
    return _refreshLock;
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
    bool refresh = NO;
    [self.refreshLock lock];
    refresh = self.isRefreshing;
    self.isRefreshing = YES;
    [self.refreshLock unlock];
    if (!refresh) {
        if (self.hasInternetConnection) {
            self.refreshButton = sender;
            UIActivityIndicatorView * view = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
            [view startAnimating];
            self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:view];
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
                    [self.refreshLock lock];
                    self.isRefreshing = NO;
                    ((vidAppDelegate *)[UIApplication sharedApplication].delegate).shouldReloadNews = NO;
                    [self.refreshLock unlock];
                });
            });
        } else {
            [self.refreshLock lock];
            self.isRefreshing = NO;
            [self.refreshLock unlock];
            
        }
    }
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.hasInternetConnection = YES;
    [self clickedRefresh:self.navigationItem.rightBarButtonItem];
}

-(Reachability *)reachability
{
    if (!_reachability)
        _reachability = [Reachability reachabilityWithHostname:@"www.google.com"];
    return _reachability;
}
-(void)viewDidAppear:(BOOL)animated
{
    [self.reachability startNotifier];
    vidAppDelegate * appDelegate = ((vidAppDelegate *)[UIApplication sharedApplication].delegate);
    appDelegate.newsDelegate = self;
    __weak vidNotificationsViewController * controller = self;
    self.reachability.reachableBlock = ^(Reachability*reach)
    {
        dispatch_async(dispatch_get_main_queue(), ^ {
            vidNotificationsViewController *controllerRef = controller;
            [controllerRef setHasInternetConnection:YES];
            [controllerRef.tableView reloadData];
            controllerRef.navigationItem.rightBarButtonItem.enabled = YES;
            [controllerRef clickedRefresh:self.navigationItem.rightBarButtonItem];
        });
    };
    self.reachability.unreachableBlock = ^(Reachability * reach) {
        dispatch_async(dispatch_get_main_queue(), ^ {
            vidNotificationsViewController * controllerRef = controller;
            [controllerRef setHasInternetConnection:NO];
            controllerRef.navigationItem.rightBarButtonItem.enabled = NO;
            [controllerRef.tableView reloadData];
        });
    };
    if (appDelegate.shouldReloadNews) {
        [self clickedRefresh:self.navigationItem.rightBarButtonItem];
    }
}
-(void)viewDidDisappear:(BOOL)animated
{
    [self.reachability stopNotifier];
}
-(void)vidAppDelegate:(vidAppDelegate *)didChangeReloadNews
{
    [self clickedRefresh:self.navigationItem.rightBarButtonItem];
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
    return 2;
}

- (NSUInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return self.hasInternetConnection ? 0 : 1;
    } else {
        return self.data.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = nil;
    if ([indexPath indexAtPosition:0] == 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"unavailableCell"];
    }
    else if ([indexPath indexAtPosition:0] == 1) {
        vidNotification * notification = [self.data objectAtIndex:[indexPath indexAtPosition:1]];
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
    }
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([indexPath indexAtPosition:0] == 0) {
        return 43;
    }
    vidNotification * notification = [self.data objectAtIndex:[indexPath indexAtPosition:1]];
    CGSize dimensions = [notification.details sizeWithFont:self.heightSizingCell.font constrainedToSize:CGSizeMake(self.heightSizingCell.frame.size.width, MAXFLOAT) lineBreakMode:UILineBreakModeWordWrap];
    return self.heightSizingCell.frame.origin.y + dimensions.height + TEXT_PADDING;
}


@end
