//
//  vidConferenceGuideViewController.m
//  vidcon
//
//  Created by Tyler Dodge on 4/24/12.
//
//

#import "vidConferenceGuideViewController.h"
#import "vidEventTimeSlotHeader.h"
#import "vidConferenceEventCell.h"

@interface vidConferenceGuideViewController () <UIScrollViewDelegate> 

@end

@implementation vidConferenceGuideViewController
@synthesize eventScrollView = _eventScrollView;
@synthesize eventHeader = _eventHeader;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}
-(void)awakeFromNib
{
}
- (void)viewDidUnload
{
    [self setEventScrollView:nil];
    [self setEventHeader:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(void)setEventScrollView:(UIScrollView *)eventScrollView
{
    _eventScrollView = eventScrollView;
    _eventScrollView.delegate = self;
    [self.eventScrollView addSubview:[[vidConferenceEventCell alloc] initStartingAt:[NSDate dateWithTimeIntervalSinceNow:0] EndingAt:[NSDate dateWithTimeIntervalSinceNow:60*30] minimumDate:[NSDate dateWithTimeIntervalSinceNow:0]]];
    [self.eventScrollView addSubview:[[vidConferenceEventCell alloc] initStartingAt:[NSDate dateWithTimeIntervalSinceNow:60*45] EndingAt:[NSDate dateWithTimeIntervalSinceNow:60*120] minimumDate:[NSDate dateWithTimeIntervalSinceNow:0]]];
    float fullWidth = 0;
    for(UIView * view in self.eventScrollView.subviews) {
        float newWidth = view.frame.origin.x + view.frame.size.width;
        if (newWidth > fullWidth) fullWidth = newWidth;
    }
    self.eventScrollView.contentSize=CGSizeMake(fullWidth, self.eventScrollView.contentSize.height);
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    self.eventHeader.position = scrollView.contentOffset.x;
}
@end
