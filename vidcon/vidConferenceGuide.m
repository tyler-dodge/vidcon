//
//  vidConferenceGuide.m
//  vidcon
//
//  Created by Tyler Dodge on 4/24/12.
//
//

#import "vidConferenceGuide.h"
#import "vidConferenceEvent.h"
@interface vidConferenceGuide ()
@property (strong, nonatomic) NSMutableArray * events;
@end

@implementation vidConferenceGuide
@synthesize events = _events;
@synthesize lastDate = _lastDate;
@synthesize firstDate = _firstDate;
@synthesize maxVerticalIndex = _maxVerticalIndex;
-(NSDate *)firstDate
{
    if (!_firstDate) {
        _firstDate = [NSDate dateWithTimeIntervalSince1970:0];
    }
    return _firstDate;
}
-(NSDate *)lastDate
{
    if (!_lastDate) {
        _lastDate = [NSDate dateWithTimeIntervalSince1970:0];
    }
    return _lastDate;
}
-(void)setLastDate:(NSDate *)lastDate
{
    _lastDate = lastDate;
}
-(void)setFirstDate:(NSDate *)firstDate
{
    _firstDate = firstDate;
}
-(void)setMaxVerticalIndex:(int)maxVerticalIndex
{
    _maxVerticalIndex = maxVerticalIndex;
}
-(NSMutableArray *)events
{
    if (!_events) {
        _events = [[NSMutableArray alloc] init];
    }
    return _events;
}
-(NSArray *)eventsInTimeRangeStartingAt:(NSDate *)start
                               EndingAt:(NSDate *)end
{
    NSMutableArray * eventsInRange = [[NSMutableArray alloc] init];
    for (vidConferenceEvent * event in self.events) {
        if ([event isInRangeStartingAt:start EndingAt:end]) {
            [eventsInRange addObject:event];
        }
    }
    return eventsInRange;
}
-(void)addEvent:(vidConferenceEvent *)event
{
    NSArray * collisions = [self eventsInTimeRangeStartingAt:event.start EndingAt:event.end];
    int tryIndex = 0;
    NSMutableOrderedSet * takenVerticalIndices = [[NSMutableOrderedSet alloc] init];
    for (vidConferenceEvent * collision in collisions) {
        [takenVerticalIndices addObject:[NSNumber numberWithInt:collision.verticalIndex]];
    }
    bool hasNotFoundOpenSpot = true;
    while (hasNotFoundOpenSpot) {
        if (![takenVerticalIndices containsObject:[NSNumber numberWithInt:tryIndex]]) {
            hasNotFoundOpenSpot = false;
        } else {
            tryIndex++;
        }
    }
    event.verticalIndex = tryIndex;
    
    [self.events addObject:event];
    if ([event.end compare:self.lastDate] == NSOrderedDescending) {
        self.lastDate = event.end;
    }
    if ([event.start compare:self.firstDate] == NSOrderedAscending) {
        self.firstDate = event.start;
    }
    if (event.verticalIndex > self.maxVerticalIndex) {
        self.maxVerticalIndex = event.verticalIndex;
    }
}
@end
