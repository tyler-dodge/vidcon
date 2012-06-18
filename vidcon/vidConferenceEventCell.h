//
//  vidConferenceEventCell.h
//  vidcon
//
//  Created by Tyler Dodge on 4/24/12.
//
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>
#import "vidConferenceEvent.h"
#define WIDTH_PER_MINUTE 5
#define SECONDS_IN_MINUTE 60
#define EVENT_HEIGHT 70
@class vidConferenceEventCell;

@protocol vidConferenceEventCellDelegate <NSObject>

-(void)didTapEventCell:(vidConferenceEventCell *)eventCell
             withEvent:(vidConferenceEvent *)event;

@end

@interface vidConferenceEventCell : UIView

@property (strong, nonatomic) vidConferenceEvent * event;
-(vidConferenceEventCell *)initWithEvent:(vidConferenceEvent *)event
                              minimumDate:(NSDate *)minimum
                            withMinimumX:(NSInteger)minimumX;
@property (nonatomic) NSInteger minimumX;

-(void)checkMinimum;

@property (weak, nonatomic) id<vidConferenceEventCellDelegate> delegate;

+(float)widthFromStart:(NSDate *)start
                toEnd:(NSDate *)end;

@end
