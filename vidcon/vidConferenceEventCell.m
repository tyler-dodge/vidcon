//
//  vidConferenceEventCell.m
//  vidcon
//
//  Created by Tyler Dodge on 4/24/12.
//
//

#import "vidConferenceEventCell.h"
@interface vidConferenceEventCell ()
@property (strong, nonatomic) NSDate * minimum;
-(void)onUpdateStartOrEnd;
@end
@implementation vidConferenceEventCell
@synthesize start = _start;
@synthesize end = _end;
@synthesize minimum = _minimum;
-(void)setStart:(NSDate *)start
{
    _start = start;
    [self onUpdateStartOrEnd];
}
-(void)setEnd:(NSDate *)end
{
    _end = end;
    [self onUpdateStartOrEnd];
}
-(void)onUpdateStartOrEnd
{
    float newLeft = [self.start timeIntervalSinceDate:self.minimum] / SECONDS_IN_MINUTE * WIDTH_PER_MINUTE;
    float newWidth = [self.end timeIntervalSinceDate:self.start] / SECONDS_IN_MINUTE * WIDTH_PER_MINUTE;
    self.frame = CGRectMake(newLeft, 0, newWidth, EVENT_HEIGHT);
    self.text = [self.start description];
    
}
-(vidConferenceEventCell *)initStartingAt:(NSDate *)start EndingAt:(NSDate *)end minimumDate:(NSDate *)minimum
{
    self = [self init];
    self.backgroundColor = [UIColor grayColor];
    self.minimum = minimum;
    self.start = start;
    self.end = end;
    return self;
}
@end
