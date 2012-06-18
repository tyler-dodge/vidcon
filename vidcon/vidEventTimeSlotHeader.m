//
//  vidEventTimeSlotHeader.m
//  vidcon
//
//  Created by Tyler Dodge on 4/24/12.
//
//

#import "vidEventTimeSlotHeader.h"
#define DAY_LABEL_MARGIN 10
@interface vidEventTimeSlotHeader ()
@property (strong, nonatomic) NSDate * minimum;
@property (nonatomic) float widthPerInterval;
@property (nonatomic) NSTimeInterval intervalSize;
@property (strong, nonatomic) NSMutableArray * labels;
@property (strong, nonatomic) UILabel * dateLabel;
@property (strong, nonatomic) UIView * dateContainer;
@end

@implementation vidEventTimeSlotHeader
@synthesize minimum = _minimum;
@synthesize position = _position;
@synthesize labels = _labels;
@synthesize delegate = _delegate;
@synthesize start = _start;
@synthesize end = _end;
@synthesize dateLabel = _dateLabel;
@synthesize dateContainer = _dateContainer;
@synthesize intervalSize = _intervalSize;
@synthesize widthPerInterval = _widthPerInterval;
-(void)setEnd:(NSDate *)end
{
    _end = end;
}
-(void)setStart:(NSDate *)start
{
    _start = start;
}
-(NSMutableArray *)labels
{
    if (!_labels) {
        _labels = [[NSMutableArray alloc] init];
    }
    return _labels;
}
-(void)setPosition:(float)position
{
    _position = position;
    float intervalIndex = self.position / self.widthPerInterval;
    self.start = [self.minimum dateByAddingTimeInterval:intervalIndex * self.intervalSize];
    self.end = [self.start dateByAddingTimeInterval:self.frame.size.width / self.widthPerInterval * self.intervalSize];
    NSInteger leftIndex = (NSInteger)floorf(intervalIndex);
    float labelPosition = leftIndex * self.widthPerInterval - position;
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"MMMM d YYYY, EEEE"];
    dateFormat.timeZone = [NSTimeZone timeZoneWithAbbreviation:@"PDT"];
    self.dateLabel.text = [dateFormat stringFromDate:[self.minimum dateByAddingTimeInterval:intervalIndex*3600]];
    [self.dateLabel sizeToFit];
    [self.dateContainer sizeToFit];
    [self.dateContainer setFrame:CGRectMake(self.dateContainer.frame.origin.x, self.dateContainer.frame.origin.y, self.dateLabel.frame.size.width+DAY_LABEL_MARGIN*2, self.dateLabel.frame.size.height+DAY_LABEL_MARGIN)];
    [dateFormat setDateFormat:@"h:mm a"];
    for (UILabel * label in self.labels) {
        NSDate * labelDate =[self.minimum dateByAddingTimeInterval:ceilf(intervalIndex + labelPosition / self.widthPerInterval) * self.intervalSize];
        label.textAlignment = UITextAlignmentCenter;
        NSString *dateString = [@" " stringByAppendingString:[dateFormat stringFromDate:labelDate]];
        label.text =  dateString;
        label.backgroundColor = [UIColor colorWithWhite:127./255 alpha:1];
        label.textColor = [UIColor whiteColor];
        label.lineBreakMode = UILineBreakModeClip;
        label.textAlignment = UITextAlignmentLeft;
        if (labelPosition < 0) {
            label.frame = CGRectMake(0, self.frame.size.height - 28,
                                     self.widthPerInterval + labelPosition - 10,
                                     28);
        } else {
            label.frame = CGRectMake(labelPosition, self.frame.size.height-28,
                                     self.widthPerInterval - 10,
                                     28);
        }
        labelPosition += self.widthPerInterval;
    }    [self.delegate vidEventTimeSlotHeader:self updatedWithNewStart:self.start withNewEnd:self.end];
}
-(UILabel *)dateLabel
{
    if (!_dateLabel) {
        _dateLabel =  [[UILabel alloc] init];
        _dateLabel.center = CGPointMake(DAY_LABEL_MARGIN, 3);
        _dateLabel.textColor = [UIColor whiteColor];
        _dateLabel.backgroundColor = [UIColor colorWithWhite:0 alpha:0];
        self.dateContainer = [[UIView alloc] init];
        self.dateContainer.backgroundColor = [UIColor colorWithRed:188./255 green:53./255 blue:65./255 alpha:1];

        [self.dateContainer addSubview:_dateLabel];
        [self addSubview:self.dateContainer];
    }
    return _dateLabel;
}
-(void)initWithInterval:(NSTimeInterval)timeInterval
WithWidthPerInterval:(float)widthPerInterval
       startInterval:(NSDate *)minimum
{
    self.intervalSize = timeInterval;
    self.widthPerInterval = widthPerInterval;
    self.minimum = minimum;
    for (int i = 0; i < self.frame.size.width / widthPerInterval + 1; i++) {
        UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(10,0,self.widthPerInterval-20,self.frame.size.height)];
        label.backgroundColor = [UIColor grayColor];
        [self.labels addObject:label];
        [self addSubview:label];
    }
    self.position = 0;
}
-(void)setStartDate:(NSTimeInterval)timeSinceMinimum
{
    self.position = timeSinceMinimum / 60 / DEFAULT_TIME_WIDTH * self.widthPerInterval;
}
@end
