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
@synthesize isFacebookEnabled = _isFacebookEnabled;
@synthesize isTwitterEnabled = _isTwitterEnabled;
@synthesize isYoutubeEnabled = _isYoutubeEnabled;

-(NSDictionary *)toDictionary
{
    NSMutableDictionary * dict = [[NSMutableDictionary alloc] init];
    [dict setValue:self.twitter forKey:TWITTER_KEY];
    [dict setValue:self.name forKey:NAME_KEY];
    [dict setValue:[NSNumber numberWithBool:self.isTwitterEnabled] forKey:TWITTER_ENABLED_KEY];
    return dict;
}
-(NSDictionary *)toSendableDictionary
{
    NSMutableDictionary * sendable = [[NSMutableDictionary alloc] init];
    if (self.isTwitterEnabled && self.twitter != nil)
        [sendable setObject:self.twitter forKey:TWITTER_KEY];
    if (self.isYoutubeEnabled && self.youtube != nil)
        [sendable setObject:self.youtube forKey:YOUTUBE_KEY];
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
    speaker.twitter = self.twitter;
    return speaker;
}
@end
