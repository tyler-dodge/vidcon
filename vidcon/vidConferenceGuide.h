//
//  vidConferenceGuide.h
//  vidcon
//
//  Created by Tyler Dodge on 4/24/12.
//
//

#import <Foundation/Foundation.h>

@interface vidConferenceGuide : NSObject
-(NSArray *)eventsInTimeRangeStartingAt:(NSDate *)start
                               EndingAt:(NSDate *)end;
@end
