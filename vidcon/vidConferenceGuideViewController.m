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

@interface vidConferenceGuideViewController () <UIScrollViewDelegate, vidEventTimeSlotHeaderDelegate>
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
    [_eventHeader initWithInterval:30*60 WithWidthPerInterval:WIDTH_PER_MINUTE * 30 startInterval:[NSDate dateWithTimeIntervalSince1970:0]];
}
-(void)setEventScrollView:(UIScrollView *)eventScrollView
{
    _eventScrollView = eventScrollView;
    _eventScrollView.delegate = self;
    self.eventHeader.delegate = self;
    for (int i = 0; i < 300; i++) {
        [self.model addEvent:[[vidConferenceEvent alloc] initWithName:[NSString stringWithFormat:@"Name%d", i]
                                                           startingAt:[NSDate dateWithTimeIntervalSince1970:60*30*i]
                                                             endingAt:[NSDate dateWithTimeIntervalSince1970:60*30*(i+1)]]];
    }
    for (int i = 0; i < 20; i++) {
        [self.model addEvent:[[vidConferenceEvent alloc] initWithName:[NSString stringWithFormat:@"aName%d", i]
                                                           startingAt:[NSDate dateWithTimeIntervalSince1970:60*30*(3*i)]
                                                             endingAt:[NSDate dateWithTimeIntervalSince1970:60*30*(3*i+2)]]];
        
    }
    for (int i = 0; i < 20; i++) {
        [self.model addEvent:[[vidConferenceEvent alloc] initWithName:[NSString stringWithFormat:@"bName%d", i]
                                                           startingAt:[NSDate dateWithTimeIntervalSince1970:60*45*(2*i)]
                                                             endingAt:[NSDate dateWithTimeIntervalSince1970:60*45*(2*i+2)]]];
        
    }
    for (int i = 0; i < 20; i++) {
        [self.model addEvent:[[vidConferenceEvent alloc] initWithName:[NSString stringWithFormat:@"cName%d", i]
                                                           startingAt:[NSDate dateWithTimeIntervalSince1970:60*30*(2*i)]
                                                             endingAt:[NSDate dateWithTimeIntervalSince1970:60*30*(2*i+1)]]];
        
    }
    
    self.eventScrollView.contentSize=CGSizeMake([vidConferenceEventCell
                                                 widthFromStart:self.model.firstDate toEnd:self.model.lastDate],
                                                (self.model.maxVerticalIndex + 1) * EVENT_HEIGHT);
    self.eventHeader.position = 0;
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
                cell = [[vidConferenceEventCell alloc] initWithEvent:event minimumDate:[NSDate dateWithTimeIntervalSince1970:0]];
                [self.eventScrollView addSubview:cell];
            }
            [self.eventCells setValue:cell forKey:event.name];
        }
    }
    self.visibleEvents = newEvents;
}
@end
