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
@property (nonatomic) BOOL isTruncated;
@property (nonatomic) BOOL minimumIsDirty;
@property (nonatomic) float defaultWidth;
@property (nonatomic) float defaultLeft;
@property (strong, nonatomic) NSDateFormatter * dateFormat;
-(void)onUpdateStartOrEnd;
-(void)cellTapped:(UIGestureRecognizer *)gesture;
@end
@implementation vidConferenceEventCell
@synthesize event = _event;
@synthesize minimum = _minimum;
@synthesize delegate = _delegate;
@synthesize minimumX = _minimumX;
@synthesize isTruncated = _isTruncated;
@synthesize minimumIsDirty = _minimumIsDirty;
@synthesize dateFormat = _dateFormat;
@synthesize defaultLeft = _defaultLeft;
@synthesize defaultWidth = _defaultWidth;
@synthesize timeRangeLabel = _timeRangeLabel;
@synthesize nameLabel = _nameLabel;
-(void)setEvent:(vidConferenceEvent *)event
{
    _event = event;
    [self onUpdateStartOrEnd];
}

-(void)setMinimumX:(NSInteger)minimumX
{
    _minimumX = minimumX;
    self.minimumIsDirty = YES;
}

-(void)checkMinimum
{
    
    if (self.minimumIsDirty &&  (self.frame.origin.x < self.minimumX || self.isTruncated)) {
        [self updateSize];
    }
}

-(void)onUpdateStartOrEnd
{
    self.defaultLeft = [vidConferenceEventCell widthFromStart:self.minimum toEnd:self.event.start];
    self.defaultWidth = [vidConferenceEventCell widthFromStart:self.event.start toEnd:self.event.end];
    [self updateSize];
    
    self.nameLabel.backgroundColor = [UIColor colorWithRed:94./255 green:142./255 blue:184./255 alpha:1];
    self.nameLabel.text = [@" " stringByAppendingString:self.event.name];
    self.nameLabel.textColor = [UIColor whiteColor];
    if (self.event.start != nil && self.event.end != nil) {
        
        self.timeRangeLabel.text = [NSString stringWithFormat:@" %@ - %@",
                                    [self.dateFormat stringFromDate:self.event.start],
                                    [self.dateFormat stringFromDate:self.event.end]];
    } else {
        NSLog(@"test");
    }
    
}
-(void)updateSize
{
    float newLeft = self.defaultLeft;
    float newWidth = self.defaultWidth;
    self.minimumIsDirty = NO;
    if (newLeft < self.minimumX) {
        newWidth -= (self.minimumX - newLeft);
        newLeft = self.minimumX;
        self.isTruncated = YES;
    } else {
        self.isTruncated = NO;
    }
    self.frame = CGRectMake(newLeft, self.event.verticalIndex * (EVENT_HEIGHT + 10) + 10, newWidth-10, EVENT_HEIGHT);
    self.nameLabel.frame = CGRectMake(0, 20, self.frame.size.width, self.frame.size.height-20);
    self.timeRangeLabel.frame = CGRectMake(0, 0, self.frame.size.width, 20);
}
+(float)widthFromStart:(NSDate *)start toEnd:(NSDate *)end
{
    return (float)[end timeIntervalSinceDate:start] / SECONDS_IN_MINUTE * WIDTH_PER_MINUTE;
}
-(vidConferenceEventCell *)initWithEvent:(vidConferenceEvent *)event minimumDate:(NSDate *)minimum withMinimumX:(NSInteger)minimumX
{
    self = [self init];
    UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cellTapped:)];
    [self addGestureRecognizer:tapGesture];
    self.timeRangeLabel = [[UILabel alloc] init];
    self.timeRangeLabel.textAlignment = UITextAlignmentRight;
    self.timeRangeLabel.font = [UIFont systemFontOfSize:10];
    [self addSubview:self.timeRangeLabel];
    
    self.nameLabel = [[UILabel alloc] init];
    self.nameLabel.lineBreakMode = UILineBreakModeClip;
    [self addSubview:self.nameLabel];
    
    self.backgroundColor = [UIColor grayColor];
    self.minimum = minimum;
    self.minimumX = minimumX;
    self.dateFormat = [[NSDateFormatter alloc] init];
    [self.dateFormat setDateFormat:@"h:mm a"];
    self.dateFormat.timeZone = [NSTimeZone timeZoneWithAbbreviation:@"PDT"];
    self.event = event;
    return self;
}
-(void)cellTapped:(UIGestureRecognizer *)gesture
{
    id delegate = self.delegate;
    [delegate didTapEventCell:self withEvent:self.event];
}
@end
