//
//  vidEventTimeSlotHeader.h
//  vidcon
//
//  Created by Tyler Dodge on 4/24/12.
//
//

#import <UIKit/UIKit.h>
#import "vidConferenceEventCell.h"
#import <QuartzCore/QuartzCore.h>
#define DEFAULT_TIME_WIDTH 30 //minutes
#define SECONDS_IN_MINUTE 60 //seconds
@class vidEventTimeSlotHeader;
@protocol vidEventTimeSlotHeaderDelegate
-(void)vidEventTimeSlotHeader:(vidEventTimeSlotHeader *)sender
          updatedWithNewStart:(NSDate *)start
                   withNewEnd:(NSDate *)end;
@end
@interface vidEventTimeSlotHeader : UIView
-(void)initWithInterval:(NSTimeInterval)timeInterval
                       WithWidthPerInterval:(float)widthPerInterval
                              startInterval:(NSDate *)minimum;
-(void)setStartDate:(NSTimeInterval)timeSinceMinimum;
@property (nonatomic) float position;
@property (readonly, strong, nonatomic) NSDate * start;
@property (readonly, strong, nonatomic) NSDate * end;
@property (weak, nonatomic) id<vidEventTimeSlotHeaderDelegate> delegate;
@end
