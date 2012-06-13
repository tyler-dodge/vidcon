//
//  vidBusinessCard.m
//  vidcon
//
//  Created by Tyler Dodge on 6/13/12.
//
//

#import "vidBusinessCard.h"

@implementation vidBusinessCard
@synthesize twitter = _twitter;
@synthesize youtube = _youtube;
@synthesize facebook = _facebook;
@synthesize name =_name;

-(NSDictionary *)toDictionary
{
    return [[NSDictionary alloc] initWithObjectsAndKeys:
            self.twitter,TWITTER_KEY,
            self.youtube,YOUTUBE_KEY,
            self.facebook,FACEBOOK_KEY,
            self.name, NAME_KEY,
            [NSNumber numberWithBool:self.isFacebookEnabled], FACEBOOK_ENABLED_KEY,
            [NSNumber numberWithBool:self.isTwitterEnabled], TWITTER_ENABLED_KEY,
            [NSNumber numberWithBool:self.isYoutubeEnabled], YOUTUBE_ENABLED_KEY, nil];
}
-(NSDictionary *)toSendableDictionary
{
    NSMutableDictionary * sendable = [[NSMutableDictionary alloc] init];
    if (self.isTwitterEnabled)
        [sendable setObject:self.twitter forKey:TWITTER_KEY];
    if (self.isYoutubeEnabled)
        [sendable setObject:self.youtube forKey:YOUTUBE_KEY];
    if (self.isFacebookEnabled)
        [sendable setObject:self.facebook forKey:FACEBOOK_KEY];
    [sendable setObject:self.name forKey:NAME_KEY];
    return sendable;
}
-(vidBusinessCard *)initWithJsonDictionary:(NSDictionary *)json
{
    self = [self init];
    if (self) {
        self.twitter = [json objectForKey:TWITTER_KEY];
        self.youtube = [json objectForKey:YOUTUBE_KEY];
        self.facebook = [json objectForKey:FACEBOOK_KEY];
        self.name = [json objectForKey:NAME_KEY];
    }
    return self;
}
-(vidSpeaker *)toVidSpeaker
{
    vidSpeaker * speaker = [[vidSpeaker alloc] init];
    speaker.name = self.name;
    speaker.youtube = self.isYoutubeEnabled ? self.youtube : nil;
    speaker.facebook = self.isFacebookEnabled ? self.facebook : nil;
    speaker.twitter = self.isTwitterEnabled ? self.twitter : nil;
    return speaker;
}
@end
