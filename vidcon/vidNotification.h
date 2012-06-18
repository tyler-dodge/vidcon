//
//  vidNotification.h
//  vidcon
//
//  Created by Tyler Dodge on 6/13/12.
//
//

#import <Foundation/Foundation.h>
enum vidNotificationType
{
    vidNotificationTypeNotification,
    vidNotificationTypeTwitter
};
@interface vidNotification : NSObject

@property (strong, nonatomic) NSDate * date;
@property (strong, nonatomic) NSString * details;
@property (nonatomic) enum vidNotificationType type;

-(vidNotification *)initWithDate:(NSDate *)date
                     withDetails:(NSString *)detail
                        withType:(enum vidNotificationType)type;

@end
