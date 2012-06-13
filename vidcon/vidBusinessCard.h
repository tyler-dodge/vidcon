//
//  vidBusinessCard.h
//  vidcon
//
//  Created by Tyler Dodge on 6/13/12.
//
//

#import <Foundation/Foundation.h>
#import "vidSpeakerModel.h"
#define TWITTER_KEY @"twitter"
#define YOUTUBE_KEY @"youtube"
#define FACEBOOK_KEY @"facebook"
#define NAME_KEY @"name"
#define TWITTER_ENABLED_KEY @"twitterEnabled"
#define YOUTUBE_ENABLED_KEY @"youtubeEnabled"
#define FACEBOOK_ENABLED_KEY @"facebookEnabled"
@interface vidBusinessCard : NSObject

@property (strong, nonatomic) NSString * twitter;
@property (strong, nonatomic) NSString * youtube;
@property (strong, nonatomic) NSString * facebook;
@property (strong, nonatomic) NSString * name;
@property (nonatomic) BOOL isTwitterEnabled;
@property (nonatomic) BOOL isYoutubeEnabled;
@property (nonatomic) BOOL isFacebookEnabled;
-(NSDictionary *)toDictionary;
-(vidSpeaker *)toVidSpeaker;
-(NSDictionary *)toSendableDictionary;
-(vidBusinessCard *)initWithJsonDictionary:(NSDictionary *)json;
@end
