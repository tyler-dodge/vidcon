//
//  vidEventTimeSlotHeader.m
//  vidcon
//
//  Created by Tyler Dodge on 4/24/12.
//
//

#import "vidEventTimeSlotHeader.h"

@interface vidEventTimeSlotHeader ()
@property (strong, nonatomic) NSDate * minimum;
@property (nonatomic) float widthPerInterval;
@property (nonatomic) NSTimeInterval intervalSize;
@property (strong, nonatomic) NSMutableArray * labels;
@end

@implementation vidEventTimeSlotHeader
@synthesize minimum = _minimum;
@synthesize position = _position;
@synthesize labels = _labels;
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
    NSInteger leftIndex = (NSInteger)floorf(intervalIndex);
    float labelPosition = leftIndex * self.widthPerInterval - position;
    for (UILabel * label in self.labels) {
        NSDate * labelDate =[NSDate dateWithTimeInterval:ceilf(intervalIndex +labelPosition / self.widthPerInterval) * self.intervalSize
                                                sinceDate:self.minimum];
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"h:mm a"];
        NSString *dateString = [@" " stringByAppendingString:[dateFormat stringFromDate:labelDate]];
        label.text =  dateString;
        if (labelPosition < 0) {
            label.frame = CGRectMake(0, 0,
                                     self.widthPerInterval + labelPosition,
                                     label.frame.size.height);
        } else {
            label.frame = CGRectMake(labelPosition, 0,
                                     self.widthPerInterval,
                                     label.frame.size.height);
        }
        labelPosition += self.widthPerInterval;
    }
}
-(void)awakeFromNib
{
    [self initWithInterval:30*60 WithWidthPerInterval:WIDTH_PER_MINUTE*30 startInterval:[NSDate date]];
}
-(void)initWithInterval:(NSTimeInterval)timeInterval
WithWidthPerInterval:(float)widthPerInterval
       startInterval:(NSDate *)minimum
{
    self.intervalSize = timeInterval;
    self.widthPerInterval = widthPerInterval;
    self.minimum = minimum;
    for (int i = 0; i < self.frame.size.width / widthPerInterval + 1; i++) {
        UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(0,0,self.widthPerInterval,self.frame.size.height)];
        label.layer.borderColor = [[UIColor blackColor] CGColor];
        label.layer.borderWidth = 1;
        [self.labels addObject:label];
        [self addSubview:label];
    }
    self.position = 0;
}
@end
