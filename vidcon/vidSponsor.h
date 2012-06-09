//
//  vidSponsor.h
//  vidcon
//
//  Created by Tyler Dodge on 6/9/12.
//
//

#import <Foundation/Foundation.h>
#define SPONSOR_NAME_KEY @"name"
#define SPONSOR_TYPE_KEY @"speakerType"
#define SPONSOR_TWITTER_KEY @"twitter"
#define SPONSOR_SITE_KEY @"website"
#define SPONSOR_IMAGE_KEY @"image"
#define SPONSOR_IMAGE_DESCRIPTION_KEY @"image-description"
#define SPONSOR_DESCRIPTION_KEY @"description"
enum SpeakerType
{
    MAKER_SECTION = 0,
    YOUTUBE_SECTION = 1,
    PLATINUM_SECTION = 2,
    GOLD_SECTION = 3,
    NORMAL_SECTION = 4
};
@interface vidSponsor : NSObject
@property (strong, nonatomic) NSString * picturePath;
@property (strong, nonatomic) UIImage * picture;
@property (strong, nonatomic) NSString * name;
@property (strong, nonatomic) NSString * descriptionImagePath;
@property (strong, nonatomic) UIImage * descriptionImage;
@property (strong, nonatomic) NSString * descriptionText;
@property (strong, nonatomic) NSString * twitter;
@property (nonatomic) enum SpeakerType  speakerType;
-(vidSponsor *)initWithJsonDictionary:(NSDictionary *)dictionary;
@end
