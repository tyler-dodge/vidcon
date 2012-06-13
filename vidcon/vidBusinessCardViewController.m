//
//  vidBusinessCardViewController.m
//  vidcon
//
//  Created by Tyler Dodge on 5/30/12.
//
//

#import "vidBusinessCardViewController.h"
#import "vidSelectedSpeakerViewController.h"
@interface vidBusinessCardViewController () <UITextFieldDelegate>

@end

@implementation vidBusinessCardViewController
@synthesize youtubeLabel = _youtubeLabel;
@synthesize youtubeSwitch = _youtubeSwitch;
@synthesize facebookLabel = _facebookLabel;
@synthesize facebookSwitch = _facebookSwitch;
@synthesize twitterLabel = _twitterLabel;
@synthesize twitterSwitch = _twitterSwitch;
@synthesize nameLabel = _nameLabel;


-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return YES;
}

#define SET_EQUAL_IF_STRING_NOT_EMPTY(leftEnd, rightEnd) \
{ \
if (rightEnd != nil && ![rightEnd isEqualToString:@""]) \
    leftEnd = rightEnd; \
}

-(void)viewDidLoad
{
    self.businessCard = [[vidBusinessCard alloc] init];
    SET_EQUAL_IF_STRING_NOT_EMPTY(self.youtubeLabel.text, self.businessCard.youtube);
    self.youtubeSwitch.selected = self.businessCard.isYoutubeEnabled;
    
    SET_EQUAL_IF_STRING_NOT_EMPTY(self.facebookLabel.text, self.businessCard.facebook);
    self.facebookSwitch.selected = self.businessCard.isFacebookEnabled;
    
    SET_EQUAL_IF_STRING_NOT_EMPTY(self.twitterLabel.text, self.businessCard.twitter);
    self.twitterSwitch.selected = self.businessCard.isTwitterEnabled;
    self.nameLabel.delegate = self;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return  NO;
}
- (void)viewDidUnload {
    [self setYoutubeLabel:nil];
    [self setYoutubeSwitch:nil];
    [self setFacebookLabel:nil];
    [self setFacebookSwitch:nil];
    [self setTwitterLabel:nil];
    [self setTwitterSwitch:nil];
    [self setNameLabel:nil];
    [super viewDidUnload];
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    self.businessCard.name = textField.text;
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.destinationViewController isKindOfClass:[vidSelectedSpeakerViewController class]]) {
        vidSelectedSpeakerViewController * controller = (vidSelectedSpeakerViewController *)segue.destinationViewController;
        controller.speaker = [self.businessCard toVidSpeaker];
    }
}
@end
