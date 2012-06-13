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
-(void)cellTapped:(UIGestureRecognizer *)gesture;
@end
@implementation vidConferenceEventCell
@synthesize event = _event;
@synthesize minimum = _minimum;
@synthesize delegate = _delegate;

-(void)setEvent:(vidConferenceEvent *)event
{
    _event = event;
    [self onUpdateStartOrEnd];
}
-(void)onUpdateStartOrEnd
{
    float newLeft = [vidConferenceEventCell widthFromStart:self.minimum toEnd:self.event.start];
    float newWidth = [vidConferenceEventCell widthFromStart:self.event.start toEnd:self.event.end];
    self.frame = CGRectMake(newLeft, self.event.verticalIndex * (EVENT_HEIGHT + 10) + 10, newWidth-10, EVENT_HEIGHT);
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"h:mm a"];
    self.timeRangeLabel.frame = CGRectMake(0, 0, self.frame.size.width, 20);
    self.nameLabel.frame = CGRectMake(0, 20, self.frame.size.width, self.frame.size.height-20);
    self.nameLabel.backgroundColor = [UIColor colorWithRed:94./255 green:142./255 blue:184./255 alpha:1];
    self.nameLabel.text = [@" " stringByAppendingString:self.event.name];
    self.nameLabel.textColor = [UIColor whiteColor];
    if (self.event.start != nil && self.event.end != nil) {
        
        self.timeRangeLabel.text = [NSString stringWithFormat:@" %@ - %@",
                                    [dateFormat stringFromDate:self.event.start],
                                    [dateFormat stringFromDate:self.event.end]];
    }
    
}
+(float)widthFromStart:(NSDate *)start toEnd:(NSDate *)end
{
    return [end timeIntervalSinceDate:start] / SECONDS_IN_MINUTE * WIDTH_PER_MINUTE;
}
-(vidConferenceEventCell *)initWithEvent:(vidConferenceEvent *)event minimumDate:(NSDate *)minimum
{
    self = [self init];
    UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cellTapped:)];
    [self addGestureRecognizer:tapGesture];
    self.timeRangeLabel = [[UILabel alloc] init];
    self.timeRangeLabel.textAlignment = UITextAlignmentRight;
    self.timeRangeLabel.font = [UIFont systemFontOfSize:10];
    [self addSubview:self.timeRangeLabel];
    
    self.nameLabel = [[UILabel alloc] init];
    [self addSubview:self.nameLabel];
    
    self.backgroundColor = [UIColor grayColor];
    self.minimum = minimum;
    self.event = event;
    return self;
}
-(void)cellTapped:(UIGestureRecognizer *)gesture
{
    [self.delegate didTapEventCell:self withEvent:self.event];
}
@end
