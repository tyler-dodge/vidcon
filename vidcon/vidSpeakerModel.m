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
@synthesize twitter = _twitter;
@synthesize youtube = _youtube;
@synthesize facebook = _facebook;
-(UIImage *)image
{
    if (!_image && _imageSource) {
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
    self = [self init];
    return self;
}
@end
@interface  vidSpeakerModel ()
@property (strong, nonatomic) NSMutableArray * speakers;
@property (strong, nonatomic) NSMutableArray * speakerIndex;
@property (strong, nonatomic) NSMutableArray * searchStack;
@property (nonatomic) NSInteger lastSearchCount;
@end
@implementation vidSpeakerModel
@synthesize speakerCount = _speakerCount;
@synthesize speakers = _speakers;
@synthesize speakerIndex = _speakerIndex;
@synthesize searchResults = _searchResults;
@synthesize searchStack = _searchStack;
@synthesize lastSearchCount = _lastSearchCount;
-(NSMutableArray *)searchStack
{
    if (!_searchStack) {
        _searchStack = [[NSMutableArray alloc] init];
    }
    return _searchStack;
}
-(NSMutableArray *)speakerIndex
{
    if (!_speakerIndex) {
        _speakerIndex = [[NSMutableArray alloc] init];
    }
    return _speakerIndex;
}
-(NSArray *)speakers
{
    if (!_speakers)
        _speakers = [[NSMutableArray alloc] init];
    return _speakers;
}
-(vidSpeakerModel *)initWithJsonFile:(NSString *)filePath
{
    self = [self init];
    NSError * error;
    NSData * data = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"guests"
                                                                                   ofType:@"json"]];
    NSArray * speakerList = [NSJSONSerialization JSONObjectWithData:data
                                                            options:0
                                                              error:&error];
    int indexCounter = 0;
    [self.speakerIndex addObject:[NSNumber numberWithInt:0]];
    char lastLetter = 'A';
    for (NSDictionary * speakerData in speakerList) {
        vidSpeaker * speaker = [[vidSpeaker alloc] init];
        speaker.name = [speakerData valueForKey:@"name"];
        bool foundLetter = NO;
        int index = 0;
        char checkLetter = 0;
        if ([speaker.name characterAtIndex:0] <= '9' && [speaker.name characterAtIndex:0] >= '0') {
            
        } else {
            
            while (!foundLetter) {
                checkLetter = [speaker.name characterAtIndex:index++];
                if (checkLetter >= 'a' && checkLetter <= 'z') {
                    checkLetter += 'A'-'a';
                }
                if (checkLetter >='A' && checkLetter <= 'Z') {
                    foundLetter = YES;
                }
            }
            if (checkLetter != lastLetter) {
                for (int i = 0;i< checkLetter - lastLetter; i++) {
                    [self.speakerIndex addObject:[NSNumber numberWithInt:indexCounter]];
                }
                lastLetter = checkLetter;
            }
        }      
        speaker.longDescription = [speakerData valueForKey:@"description"];
        NSString * image = [speakerData valueForKey:@"image"];
        if (image) {
            speaker.imageSource = [[NSBundle mainBundle] pathForResource:image ofType:nil];
        }
        [self.speakers addObject:speaker];
        indexCounter++;
    }
    return self;
}
-(vidSpeaker *)speakerAtIndexPath:(NSIndexPath *)path
{
    NSInteger index = [[self.speakerIndex objectAtIndex:[path indexAtPosition:0]] intValue] +
    [path indexAtPosition:1];
    vidSpeaker * speaker = [self.speakers objectAtIndex:index];
    speaker.index = index;
    return speaker;
}
-(NSUInteger)speakerCount
{
    return self.speakers.count;
}
-(NSUInteger)speakersInSection:(NSUInteger)section
{
    if (section == self.speakerIndex.count - 1) {
        return self.speakers.count - [[self.speakerIndex objectAtIndex:section] intValue];
    } else if (section >= self.speakerIndex.count) {
        return 0;
    } else {
        return [[self.speakerIndex objectAtIndex:section+1] intValue] -
        [[self.speakerIndex objectAtIndex:section] intValue];
    }
}
-(NSUInteger)numberOfSections
{
    return [self.speakerIndex count];
}

-(void)startSearch
{
    self.searchResults = [self.speakers copy];
}
-(void)updateSearch:(NSString *)term
{
    NSMutableArray * newSearchResults;
    if (term.length < 20) { //just to prevent memory madness!!!
        if (self.lastSearchCount <= term.length) {
            newSearchResults = [[NSMutableArray alloc] init];
            NSArray * tokens = [term.lowercaseString componentsSeparatedByString:@" "];
            for (vidSpeaker * speaker in self.searchResults) {
                bool keepSpeaker = YES;
                for (NSString * token in tokens) {
                    if (![token isEqualToString:@""]) {
                        bool hasToken = NO;
                        NSArray * nameTokens = [speaker.name.lowercaseString componentsSeparatedByString:@" "];
                        for (NSString * nameToken in nameTokens) {
                            if ([nameToken hasPrefix:token]) {
                                hasToken = YES;
                            }
                        }
                        keepSpeaker = hasToken;
                    }
                }
                if (keepSpeaker) {
                    [newSearchResults addObject:speaker];
                }
            }
            [self.searchStack addObject:self.searchResults];
        } else {
            newSearchResults = self.searchStack.lastObject;
            [self.searchStack removeLastObject];
        }
        self.lastSearchCount = term.length;
        self.searchResults = newSearchResults;
    }
}
-(void)setSearchResults:(NSArray *)searchResults
{
    _searchResults = searchResults;
}
-(void)endSearch
{
    self.searchResults = nil;
}
@end
