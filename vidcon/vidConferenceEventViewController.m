//
//  vidConferenceEventViewController.m
//  vidcon
//
//  Created by Tyler Dodge on 6/13/12.
//
//

#import "vidConferenceEventViewController.h"

@interface vidConferenceEventViewController () <UIWebViewDelegate>

@end

@implementation vidConferenceEventViewController
@synthesize event = _event;
@synthesize nameLabel = _nameLabel;
@synthesize descriptionView = _descriptionView;
@synthesize startTimeLabel = _startTimeLabel;
@synthesize endTimeLabel = _endTimeLabel;
-(void)viewDidLoad
{
    [super viewDidLoad];
    self.nameLabel.text = self.event.name;
    NSDateFormatter * dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"EEEE, h:mm aa zzz"];
    dateFormat.timeZone = [NSTimeZone timeZoneWithAbbreviation:@"PDT"];
    self.startTimeLabel.text = [dateFormat stringFromDate:self.event.start];
    self.endTimeLabel.text = [dateFormat stringFromDate:self.event.end];
}
- (void)viewDidUnload {
    [self setNameLabel:nil];
    [self setDescriptionView:nil];
    [self setStartTimeLabel:nil];
    [self setEndTimeLabel:nil];
    [super viewDidUnload];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([indexPath indexAtPosition:0]==2) {
        return self.descriptionView.scrollView.contentSize.height;
    }
    return [super tableView:tableView heightForRowAtIndexPath:indexPath];
}
-(void)setDescriptionView:(UIWebView *)descriptionView
{
    _descriptionView = descriptionView;
    self.descriptionView.delegate = self;
    NSString * html = [NSString stringWithFormat:
                       @"<html><head><style>body { \
                       font-family: Helvetica; \
                       color: #333; \
                       } \
                       b { \
                       font-family: inherit; \
                       font-weight: bold; \
                       text-rendering: optimizelegibility; \
                       } \
                       small { \
                       font-weight: normal; \
                       text-decoration: none; \
                       font-size: 0.9em; \
                       font-style: none; \
                       border-bottom: 1px solid #666; \
                       display: block; \
                       }​</style></head><body>%@</body></html>",self.event.details];
    UIWebView * view = self.descriptionView;
    [view loadHTMLString:html baseURL:[[NSURL alloc] initWithString:@""]];
    [view.scrollView setScrollEnabled:NO];
}
-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self.tableView reloadData];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
@end
