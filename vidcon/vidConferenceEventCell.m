//
//  vidConferenceEventCell.m
//  vidcon
//
//  Created by Tyler Dodge on 4/24/12.
//
//

#import "vidConferenceEventCell.h"
@interface vidConferenceEventCell ()
@property (strong, nonatomic) UILabel * timeRangeLabel;
@property (strong, nonatomic) UILabel * nameLabel;
@property (strong, nonatomic) NSDate * minimum;
-(void)onUpdateStartOrEnd;
@end
@implementation vidConferenceEventCell
@synthesize event = _event;
@synthesize minimum = _minimum;

-(void)setEvent:(vidConferenceEvent *)event
{
    _event = event;
    [self onUpdateStartOrEnd];
}
-(void)onUpdateStartOrEnd
{
    float newLeft = [self.event.start timeIntervalSinceDate:self.minimum] / SECONDS_IN_MINUTE * WIDTH_PER_MINUTE;
    float newWidth = [self.event.end timeIntervalSinceDate:self.event.start] / SECONDS_IN_MINUTE * WIDTH_PER_MINUTE;
    self.frame = CGRectMake(newLeft, 0, newWidth, EVENT_HEIGHT);
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"h:mm a"];
    self.timeRangeLabel.frame = CGRectMake(0, 0, self.frame.size.width, 20);
    self.timeRangeLabel.layer.borderColor = [[UIColor blackColor] CGColor];
    self.timeRangeLabel.layer.borderWidth = 1;
    self.nameLabel.frame = CGRectMake(0, 20, self.frame.size.width, self.frame.size.height-20);
    self.nameLabel.backgroundColor = [UIColor grayColor];
    self.nameLabel.text = [@" " stringByAppendingString:self.event.name];
    if (self.event.start != nil && self.event.end != nil) {
        
        self.timeRangeLabel.text = [NSString stringWithFormat:@" %@ - %@",
                                    [dateFormat stringFromDate:self.event.start],
                                    [dateFormat stringFromDate:self.event.end]];
    }
    
}
-(vidConferenceEventCell *)initWithEvent:(vidConferenceEvent *)event minimumDate:(NSDate *)minimum
{
    self = [self init];
    self.timeRangeLabel = [[UILabel alloc] init];
    self.timeRangeLabel.textAlignment = UITextAlignmentRight;
    self.timeRangeLabel.font = [UIFont systemFontOfSize:10];
    [self addSubview:self.timeRangeLabel];
    
    self.nameLabel = [[UILabel alloc] init];
    [self addSubview:self.nameLabel];
    
    self.backgroundColor = [UIColor grayColor];
    self.layer.borderColor = [[UIColor blackColor] CGColor];
    self.layer.borderWidth = 1;
    self.minimum = minimum;
    self.event = event;
    return self;
}
@end
