//
//  vidConferenceEventCell.h
//  vidcon
//
//  Created by Tyler Dodge on 4/24/12.
//
//

#import <Foundation/Foundation.h>
#define WIDTH_PER_MINUTE 5
#define SECONDS_IN_MINUTE 60
#define EVENT_HEIGHT 30

@interface vidConferenceEventCell : UILabel

@property (strong, nonatomic) NSDate * start;
@property (strong, nonatomic) NSDate * end;
-(vidConferenceEventCell *)initStartingAt:(NSDate *)start
                                 EndingAt:(NSDate *)end
                              minimumDate:(NSDate *)minimum;
@end
