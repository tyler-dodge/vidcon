//
//  vidSpeakerModel.h
//  vidcon
//
//  Created by Tyler Dodge on 4/13/12.
//  Copyright (c) 2012 Sting Apps. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface vidSpeaker : NSObject
@property (strong, readonly) NSString * name;
@property (strong, readonly) UIImage * image;
@property (strong, readonly) NSString * shortDescription;
@property (strong, readonly) NSString * longDescription;
@end
@interface vidSpeakerModel : NSObject

@property (readonly) NSUInteger speakerCount;

-(vidSpeaker *)speakerAtIndexPath:(NSIndexPath *)path;

-(vidSpeakerModel *)initWithJsonFile:(NSString *)filePath;

-(NSUInteger)speakersInSection:(NSUInteger)section;
-(NSUInteger)numberOfSections;

-(void)startSearch;
-(void)updateSearch:(NSString *)term;
@property (strong, readwrite, nonatomic)NSArray * searchResults;
-(void)endSearch;
@end
