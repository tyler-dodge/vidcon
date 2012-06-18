//
//  vidNotification.m
//  vidcon
//
//  Created by Tyler Dodge on 6/13/12.
//
//

#import "vidNotification.h"

@implementation vidNotification
@synthesize details = _details;
@synthesize date = _date;
@synthesize type = _type;
-(vidNotification *)initWithDate:(NSDate *)date withDetails:(NSString *)details withType:(enum vidNotificationType)type
{
    self = [self init];
    if (self) {
        self.date = date;
        self.details = details;
        self.type = type;
    }
    return self;
}
@end
