//
//  vidConferenceEvent.h
//  vidcon
//
//  Created by Tyler Dodge on 4/24/12.
//
//

#import <Foundation/Foundation.h>
#import "vidSpeakerModel.h"
#define EVENT_NAME_KEY @"name"
#define EVENT_START_KEY @"start"
#define EVENT_END_KEY @"end"
#define EVENT_SPEAKER_KEY @"speaker"
#define EVENT_DESCRIPTION_KEY @"details"
#define EVENT_LOCATION_KEY @"location"

@interface vidConferenceEvent : NSObject
@property (strong, nonatomic) NSNumber * uid;
@property (strong, nonatomic) NSDate * start;
@property (strong, nonatomic) NSDate * end;
@property (strong, nonatomic) NSString * name;
@property (strong, nonatomic) vidSpeaker * speaker;
@property (strong, nonatomic) NSString * room;
@property (strong, nonatomic) NSString * details;
@property (nonatomic) int verticalIndex; //index set by conference guide to prevent overlapping
-(BOOL)isInRangeStartingAt:(NSDate *)start
                  EndingAt:(NSDate *)end;
-(vidConferenceEvent *)initWithName:(NSString *)name
                         startingAt:(NSDate *)start
                           endingAt:(NSDate *)end;
-(vidConferenceEvent *)initWithDictionary:(NSDictionary *)dictionary;
@end
