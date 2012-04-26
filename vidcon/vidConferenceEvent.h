//
//  vidConferenceEvent.h
//  vidcon
//
//  Created by Tyler Dodge on 4/24/12.
//
//

#import <Foundation/Foundation.h>
#import "vidSpeakerModel.h"

@interface vidConferenceEvent : NSObject
@property (strong, nonatomic) NSDate * start;
@property (strong, nonatomic) NSDate * end;
@property (strong, nonatomic) NSString * name;
@property (strong, nonatomic) vidSpeaker * speaker;
@property (strong, nonatomic) NSString * room;
@property (strong, nonatomic) NSString * description;
@property (nonatomic) int verticalIndex; //index set by conference guide to prevent overlapping
-(BOOL)isInRangeStartingAt:(NSDate *)start
                  EndingAt:(NSDate *)end;
-(vidConferenceEvent *)initWithName:(NSString *)name
                         startingAt:(NSDate *)start
                           endingAt:(NSDate *)end;
@end
