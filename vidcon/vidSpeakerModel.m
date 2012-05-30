//
//  vidSpeakerModel.m
//  vidcon
//
//  Created by Tyler Dodge on 4/13/12.
//  Copyright (c) 2012 Sting Apps. All rights reserved.
//

#import "vidSpeakerModel.h"
@interface vidSpeaker()
@property (strong, nonatomic) NSString * imageSource;
-(id)initWithJson:(NSString *)jsonString;
@end
@implementation vidSpeaker
@synthesize name = _name;
@synthesize longDescription = _longDescription;
@synthesize shortDescription = _shortDescription;
@synthesize image = _image;
@synthesize imageSource = _imageSource;
-(UIImage *)image
{
    if (!_image) {
        _image = [UIImage imageWithContentsOfFile:self.imageSource];
    }
    return _image;
}
-(void)setName:(NSString *)name
{
    _name = name;
}
-(void)setShortDescription:(NSString *)shortDescription
{
    _shortDescription = shortDescription;
}
-(void)setLongDescription:(NSString *)longDescription
{
    _longDescription = longDescription;
}
-(id)initWithJson:(NSString *)jsonString
{
    jsonString = @"{ \"name\": \"Hello!\" }";
    
    self = [self init];
    self.name = @"Person 1";
    self.shortDescription = @"a person.";
    self.longDescription = @"a person with lots and lots and lots and lots and lots and lots and lots of description";
    return self;
}
@end
@interface  vidSpeakerModel ()
@property (strong, nonatomic) NSMutableArray * speakers;
@end
@implementation vidSpeakerModel
@synthesize speakerCount = _speakerCount;
@synthesize speakers = _speakers;
-(NSArray *)speakers
{
    if (!_speakers)
        _speakers = [[NSMutableArray alloc] init];
    return _speakers;
}
-(vidSpeakerModel *)initWithJsonFile:(NSString *)filePath
{
    self = [self init];
    [self.speakers addObject:[[vidSpeaker alloc] initWithJson:@"{ \"name\": \"Jerry\" }"]];
    //[self.speakers addObject:[[vidSpeaker alloc] initWithJson:@""]];
    //[self.speakers addObject:[[vidSpeaker alloc] initWithJson:@""]];
    return self;
}
-(vidSpeaker *)speakerAtIndexPath:(NSIndexPath *)path
{
    return [self.speakers objectAtIndex:[path indexAtPosition:0]];
}
-(NSUInteger)speakerCount
{
    return self.speakers.count;
}
@end
