//
//  vidSelectedSpeakerViewController.m
//  vidcon
//
//  Created by Tyler Dodge on 5/29/12.
//
//

#import "vidSelectedSpeakerViewController.h"
#import "vidSpeakerModel.h"
#import <QuartzCore/QuartzCore.h>
@interface vidSelectedSpeakerViewController ()
@end

@implementation vidSelectedSpeakerViewController
@synthesize speakerName = _speakerName;
@synthesize speakerDescriptionCell = _speakerDescriptionCell;
@synthesize speakerImage = _speakerImage;
@synthesize speakerDescription = _speakerDescription;
@synthesize youtubeName = _youtubeName;
@synthesize facebookName = _facebookName;
@synthesize twitterName = _twitterName;
@synthesize speaker = _speaker;

- (void)viewDidUnload {
    [self setSpeakerName:nil];
    [self setSpeakerDescription:nil];
    [self setYoutubeName:nil];
    [self setFacebookName:nil];
    [self setTwitterName:nil];
    [self setSpeakerName:nil];
    [self setSpeakerImage:nil];
    [self setSpeakerName:nil];
    [self setSpeakerDescriptionCell:nil];
    [super viewDidUnload];
}
-(void)viewDidLoad
{
    [super viewDidLoad];
    self.speakerName.text = self.speaker.name;
    self.speakerDescription.text = self.speaker.longDescription;
    self.speakerImage.image = self.speaker.image;
    self.speakerImage.layer.borderColor = [[UIColor blackColor] CGColor];
    self.speakerImage.layer.borderWidth = 1;
    
}
-(void)setSpeakerDescription:(UITextView *)speakerDescription
{
    _speakerDescription=speakerDescription;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([indexPath indexAtPosition:0] == 0 && [indexPath indexAtPosition:1]==1) {
        return self.speakerDescription.contentSize.height+20;
    } else {
        
        return [super tableView:tableView heightForRowAtIndexPath:indexPath];
    }
}
-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return YES;
}
@end
