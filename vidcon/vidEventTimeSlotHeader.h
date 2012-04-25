//
//  vidEventTimeSlotHeader.h
//  vidcon
//
//  Created by Tyler Dodge on 4/24/12.
//
//

#import <UIKit/UIKit.h>
#import "vidConferenceEventCell.h"
@interface vidEventTimeSlotHeader : UIView
-(void)initWithInterval:(NSTimeInterval)timeInterval
                       WithWidthPerInterval:(float)widthPerInterval
                              startInterval:(NSDate *)minimum;
@property (nonatomic) float position;
@end
