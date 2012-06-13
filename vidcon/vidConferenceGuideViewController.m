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
#import "vidConferenceEventViewController.h"
@interface vidConferenceGuideViewController () <UIScrollViewDelegate, vidEventTimeSlotHeaderDelegate, vidConferenceEventCellDelegate>
@property (strong, nonatomic) NSMutableDictionary * eventCells;
@property (strong, nonatomic) NSArray * visibleEvents;
@property (strong, nonatomic) NSMutableArray * unusedCells;
@end

@implementation vidConferenceGuideViewController
@synthesize eventScrollView = _eventScrollView;
@synthesize eventHeader = _eventHeader;
@synthesize eventCells = _eventCells;
@synthesize visibleEvents = _visibleEvents;
@synthesize model = _model;
@synthesize unusedCells = _unusedCells;
@synthesize startTimeSinceMinimum = _startTimeSinceMinimum;

#pragma Lazy instantiation
-(NSMutableDictionary *)eventCells
{
    if (!_eventCells) {
        _eventCells = [[NSMutableDictionary alloc] init];
    }
    return _eventCells;
}

-(NSArray *)visibleEvents
{
    if (!_visibleEvents) {
        _visibleEvents = [[NSArray alloc] init];
    }
    return _visibleEvents;
}

-(NSMutableArray *)unusedCells
{
    if (!_unusedCells) {
        _unusedCells = [[NSMutableArray alloc] init];
    }
    return _unusedCells;
}

-(vidConferenceGuide *)model
{
    if (!_model) {
        _model = [[vidConferenceGuide alloc] init]; 
    }
    return _model;
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
    return YES;
}
-(void)setEventHeader:(vidEventTimeSlotHeader *)eventHeader
{
    
    _eventHeader = eventHeader;
    [_eventHeader initWithInterval:DEFAULT_TIME_WIDTH * 60 WithWidthPerInterval:WIDTH_PER_MINUTE * DEFAULT_TIME_WIDTH startInterval:[NSDate dateWithTimeIntervalSince1970:VIDCON_START_DATE]];
}
-(void)setEventScrollView:(UIScrollView *)eventScrollView
{
    _eventScrollView = eventScrollView;
    _eventScrollView.delegate = self;
    self.eventHeader.delegate = self;
    NSArray * jsonData = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"guide" ofType:@"json"] ] options:0 error:nil];
    for (NSDictionary * json in jsonData) {
        [self.model addEvent:[[vidConferenceEvent alloc] initWithDictionary:json]];
    }
    self.eventScrollView.contentSize=CGSizeMake([vidConferenceEventCell
                                                 widthFromStart:self.model.firstDate toEnd:self.model.lastDate],
                                                (self.model.maxVerticalIndex + 1) * EVENT_HEIGHT);
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    self.eventHeader.position = scrollView.contentOffset.x;
}
-(void)vidEventTimeSlotHeader:(vidEventTimeSlotHeader *)sender
          updatedWithNewStart:(NSDate *)start
                   withNewEnd:(NSDate *)end
{
    NSArray * newEvents = [self.model eventsInTimeRangeStartingAt:start EndingAt:end];
    for (vidConferenceEvent * event in self.visibleEvents) {
        if (![newEvents containsObject:event]) {
            vidConferenceEventCell * cell = [self.eventCells valueForKey:event.name];
            [self.eventCells removeObjectForKey:event.name];
            [self.unusedCells addObject:cell];
        }
    }
    for (vidConferenceEvent * event in newEvents) {
        if ([self.eventCells valueForKey:event.name] == nil) {
            vidConferenceEventCell * cell = nil;
            if (self.unusedCells.count > 0) {
                cell = [self.unusedCells lastObject];
                [self.unusedCells removeLastObject];
                cell.event = event;
            } else {
                cell = [[vidConferenceEventCell alloc] initWithEvent:event minimumDate:[NSDate dateWithTimeIntervalSince1970:VIDCON_START_DATE]];
                cell.delegate = self;
                [self.eventScrollView addSubview:cell];
            }
            [self.eventCells setValue:cell forKey:event.name];
        }
    }
    self.visibleEvents = newEvents;
}
-(void)viewDidLoad
{
    [self.eventHeader setStartDate:self.startTimeSinceMinimum];
    self.eventScrollView.contentOffset = CGPointMake(self.eventHeader.position,self.eventScrollView.contentOffset.y);
}
-(void)didTapEventCell:(vidConferenceEventCell *)eventCell withEvent:(vidConferenceEvent *)event
{
    [self performSegueWithIdentifier:@"showEvent" sender:event];
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([sender isKindOfClass:[vidConferenceEvent class]] &&
        [segue.destinationViewController isKindOfClass:[vidConferenceEventViewController class]] ) {
        vidConferenceEventViewController * eventView = (vidConferenceEventViewController *)segue.destinationViewController;
        eventView.event = sender;
    }
}
@end
