//
//  vidConferenceEvent.m
//  vidcon
//
//  Created by Tyler Dodge on 4/24/12.
//
//

#import "vidConferenceEvent.h"

@implementation vidConferenceEvent
@synthesize start = _start;
@synthesize end = _end;
@synthesize name = _name;
@synthesize speaker = _speaker;
@synthesize details = _details;
@synthesize verticalIndex = _verticalIndex;
-(BOOL)isInRangeStartingAt:(NSDate *)start EndingAt:(NSDate *)end
{
    NSComparisonResult selfStartComparedToStart = [self.start compare:start];
    NSComparisonResult selfStartComparedToEnd = [self.start compare:end];
    
    NSComparisonResult selfEndComparedToStart = [self.end compare:start];
    NSComparisonResult selfEndComparedToEnd = [self.end compare:end];
    
    return (selfStartComparedToStart == NSOrderedAscending && //check if start is within self's range
            selfEndComparedToStart == NSOrderedDescending) ||
        
            (selfStartComparedToEnd == NSOrderedAscending && //check if end is within self's range
             selfEndComparedToEnd == NSOrderedDescending) ||
        
            (selfStartComparedToStart == NSOrderedDescending && //check if self's end is between start and end
             selfStartComparedToEnd == NSOrderedAscending) ||
        
            (selfEndComparedToStart == NSOrderedDescending && //check if self's start is between start and end
             selfEndComparedToEnd == NSOrderedAscending) ||
            (selfEndComparedToEnd == NSOrderedSame &&
             selfStartComparedToStart == NSOrderedSame);
}
-(vidConferenceEvent *)initWithName:(NSString *)name startingAt:(NSDate *)start endingAt:(NSDate *)end
{
    self = [self init];
    if (self) {
        self.name = name;
        self.start = start;
        self.end = end;
    }
    return self;
}
-(vidConferenceEvent *)initWithDictionary:(NSDictionary *)dictionary
{
    self = [self init];
    if (self) {
        self.name = [dictionary objectForKey:EVENT_NAME_KEY];
        NSDateFormatter *dateformat = [[NSDateFormatter alloc] init];
        [dateformat setDateFormat:@"MMMM dd yyyy, hh:mm aa zzz"];
        self.start = [dateformat dateFromString:[dictionary objectForKey:EVENT_START_KEY]];
        self.end = [dateformat dateFromString:[dictionary objectForKey:EVENT_END_KEY]];
        self.speaker = [dictionary objectForKey:EVENT_SPEAKER_KEY];
        self.details = [dictionary objectForKey:EVENT_DESCRIPTION_KEY];
    }
    return self;
}
@end
