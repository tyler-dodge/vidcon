//
//  vidConferenceGuide.h
//  vidcon
//
//  Created by Tyler Dodge on 4/24/12.
//
//

#import <Foundation/Foundation.h>
#import "vidConferenceEvent.h"

@interface vidConferenceGuide : NSObject
@property (readonly, nonatomic) NSDate * lastDate;
@property (readonly, nonatomic) NSDate * firstDate;
@property (readonly, nonatomic) int maxVerticalIndex;
-(NSArray *)eventsInTimeRangeStartingAt:(NSDate *)start
                               EndingAt:(NSDate *)end;
-(void)addEvent:(vidConferenceEvent *)event;
@end
