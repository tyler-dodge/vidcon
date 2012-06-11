//
//  vidConferenceGuideMainViewController.m
//  vidcon
//
//  Created by Tyler Dodge on 6/8/12.
//
//

#import "vidConferenceGuideMainViewController.h"
#import "vidConferenceGuide.h"
#import "vidConferenceGuideViewController.h"
#define CONFERENCE_PAGE_SIZE 320
#define PAGE_COUNT 2
#define THURSDAY @"thursday"
#define THURSDAY_DATE 0
#define FRIDAY @"friday"
#define FRIDAY_DATE 3600 * 24
#define SATURDAY @"saturday"
#define SATURDAY_DATE 3600 * 24 * 2
#define TODAY @"today"

@interface vidConferenceGuideMainViewController () <UIScrollViewDelegate>
@end

@implementation vidConferenceGuideMainViewController
@synthesize scrollView = _scrollView;
@synthesize pageControl = _pageControl;
- (IBAction)buttonPressed:(UIButton *)sender {
    sender.alpha += 0.1;
}
- (IBAction)buttonUp:(UIButton *)sender {
    sender.alpha -= 0.1;
}

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
    self.scrollView.contentSize = CGSizeMake(CONFERENCE_PAGE_SIZE * 2, self.scrollView.contentSize.height);
    self.pageControl.numberOfPages = PAGE_COUNT;
}

- (void)viewDidUnload
{
    [self setScrollView:nil];
    [self setPageControl:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}
-(void)setPageControl:(UIPageControl *)pageControl
{
    _pageControl = pageControl;
}
-(void)setScrollView:(UIScrollView *)scrollView
{
    _scrollView = scrollView;
    _scrollView.delegate = self;
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    self.pageControl.currentPage = scrollView.contentOffset.x / CONFERENCE_PAGE_SIZE;
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSTimeInterval startDate;
    if ([segue.identifier isEqualToString:TODAY]) {
        startDate = 0;
    } else if ([segue.identifier isEqualToString:THURSDAY]) {
        startDate = THURSDAY_DATE;
    } else if ([segue.identifier isEqualToString:FRIDAY]) {
        startDate = FRIDAY_DATE;
    } else if ([segue.identifier isEqualToString:SATURDAY]) {
        startDate = SATURDAY_DATE;
    }
    if (startDate) {
        vidConferenceGuideViewController * conferenceGuide = segue.destinationViewController;
        conferenceGuide.startTimeSinceMinimum = startDate;
    }
}
@end
