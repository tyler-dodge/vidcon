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
@synthesize description = _description;
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
        
            (selfStartComparedToEnd == NSOrderedDescending && //check if self's end is between start and end
             selfEndComparedToEnd == NSOrderedAscending) ||
        
            (selfStartComparedToStart == NSOrderedDescending && //check if self's start is between start and end
             selfEndComparedToStart == NSOrderedAscending);
}
@end
