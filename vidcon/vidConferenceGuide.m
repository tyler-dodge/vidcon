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
@end
