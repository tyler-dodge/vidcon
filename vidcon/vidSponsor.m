//
//  vidSponsor.m
//  vidcon
//
//  Created by Tyler Dodge on 6/9/12.
//
//

#import "vidSponsor.h"
@implementation vidSponsor
@synthesize descriptionImage = _descriptionImage;
@synthesize descriptionText = _descriptionText;
@synthesize descriptionImagePath = _descriptionImagePath;
@synthesize picture = _picture;
@synthesize picturePath = _picturePath;
@synthesize name = _name;
@synthesize twitter = _twitter;
@synthesize webSite = _webSite;
@synthesize speakerType = _speakerType;

-(vidSponsor *)initWithJsonDictionary:(NSDictionary *)dictionary
{
    self = [self init];
    if (self) {
        self.descriptionText = [dictionary objectForKey:SPONSOR_DESCRIPTION_KEY];
        self.descriptionImagePath = [dictionary objectForKey:SPONSOR_IMAGE_DESCRIPTION_KEY];
        self.picturePath = [dictionary objectForKey:SPONSOR_IMAGE_KEY];
        self.name = [dictionary objectForKey:SPONSOR_NAME_KEY];
        self.twitter = [dictionary objectForKey:SPONSOR_TWITTER_KEY];
        self.speakerType = [[dictionary objectForKey:SPONSOR_TYPE_KEY] intValue];
        self.webSite = [dictionary objectForKey:SPONSOR_SITE_KEY];
    }
    return self;
}

-(UIImage *)picture
{
    if (!_picture && ![self.picturePath isEqualToString:@""]) {
        _picture = [[UIImage alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:self.picturePath ofType:@""]];
    }
    return _picture;
}
-(void)setPicturePath:(NSString *)picturePath
{
    if (_picturePath != picturePath) {
        _picturePath = picturePath;
        if (self.picture) {
            self.picture = nil;
        }
    }
}

-(UIImage *)descriptionImage
{
    if (!_descriptionImage && ![self.descriptionImagePath isEqualToString:@""]) {
        _descriptionImage = [[UIImage alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:self.descriptionImagePath ofType:@""]];
    }
    return _descriptionImage;
}
-(void)setDescriptionImagePath:(NSString *)descriptionImagePath
{
    if (_descriptionImagePath != descriptionImagePath) {
        _descriptionImagePath = descriptionImagePath;
        if (_descriptionImage) {
            self.descriptionImage = nil;
        }
    }
}
-(vidSpeaker *)toSpeaker
{
    vidSpeaker * speaker = [[vidSpeaker alloc] init];
    speaker.name = self.name;
    speaker.longDescription = self.descriptionText;
    speaker.twitter = self.twitter;
    speaker.webSite = self.webSite;
    return speaker;
}
@end
