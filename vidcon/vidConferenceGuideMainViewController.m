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
#import "vidMapViewController.h"
#define CONFERENCE_PAGE_SIZE 320
#define PAGE_COUNT 3
#define START_PAGE 1
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
@synthesize firstFloorButton = _firstFloorButton;
@synthesize secondFloorButton = _secondFloorButton;
@synthesize parkingGuide = _parkingGuide;
@synthesize hotels = _hotels;
@synthesize booths = _booths;
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
    self.scrollView.contentSize = CGSizeMake(CONFERENCE_PAGE_SIZE * PAGE_COUNT, self.scrollView.contentSize.height);
    self.scrollView.contentOffset = CGPointMake(START_PAGE * CONFERENCE_PAGE_SIZE, 0);
    self.pageControl.numberOfPages = PAGE_COUNT;
    self.pageControl.currentPage = START_PAGE;
    self.pageControl.pageIndicatorTintColor = [UIColor blackColor];
}

- (void)viewDidUnload
{
    [self setScrollView:nil];
    [self setPageControl:nil];
    [self setFirstFloorButton:nil];
    [self setSecondFloorButton:nil];
    [self setParkingGuide:nil];
    [self setHotels:nil];
    [self setBooths:nil];
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
    NSTimeInterval startDate = -1;
    if ([segue.identifier isEqualToString:TODAY]) {
        startDate = 0;
    } else if ([segue.identifier isEqualToString:THURSDAY]) {
        startDate = THURSDAY_DATE;
    } else if ([segue.identifier isEqualToString:FRIDAY]) {
        startDate = FRIDAY_DATE;
    } else if ([segue.identifier isEqualToString:SATURDAY]) {
        startDate = SATURDAY_DATE;
    }
    if (startDate != -1) {
        vidConferenceGuideViewController * conferenceGuide = segue.destinationViewController;
        conferenceGuide.startTimeSinceMinimum = startDate;
    }
    if ([segue.destinationViewController isKindOfClass:[vidMapViewController class]]) {
        UIButton * senderButton = (UIButton *)sender;
        NSString * mapPath = @"";
        NSString * mapName = @"";
        if (senderButton == self.firstFloorButton) {
            mapPath = [[NSBundle mainBundle] pathForResource:@"ExpoHallFirstFloor" ofType:@"png"];
            mapName = @"Expo Hall First Floor";
        } else if (senderButton == self.secondFloorButton) {
            mapPath = [[NSBundle mainBundle] pathForResource:@"ExpoHallSecondFloor" ofType:@"png"];
            mapName = @"Expo Hall Second Floor";
        }
        vidMapViewController * mapView = (vidMapViewController *)segue.destinationViewController;
        mapView.image = [[UIImage alloc] initWithContentsOfFile:mapPath];
        mapView.mapName = mapName;
    }
}
@end
