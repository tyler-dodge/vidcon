//
//  vidBusinessCardViewController.m
//  vidcon
//
//  Created by Tyler Dodge on 5/30/12.
//
//

#import "vidBusinessCardViewController.h"
#import "vidSelectedSpeakerViewController.h"
#import "BumpClient.h"
#import "vidSavedCardViewController.h"
#import <Twitter/Twitter.h>
#import <Accounts/Accounts.h>
#import "vidBumpViewController.h"
@interface vidBusinessCardViewController () <UITextFieldDelegate, vidSelectedSpeakerViewControllerDelegate>
@property (atomic) bool isPresenting;
@property (strong, nonatomic) NSLock * presentLock;
@property (strong, nonatomic) NSMutableArray * savedCards;
@end

@implementation vidBusinessCardViewController
@synthesize youtubeLabel = _youtubeLabel;
@synthesize youtubeSwitch = _youtubeSwitch;
@synthesize facebookLabel = _facebookLabel;
@synthesize facebookSwitch = _facebookSwitch;
@synthesize twitterLabel = _twitterLabel;
@synthesize twitterSwitch = _twitterSwitch;
@synthesize nameLabel = _nameLabel;
@synthesize isPresenting = _isPresenting;
@synthesize presentLock = _presentLock;
@synthesize savedCards = _savedCards;
-(NSArray *)savedCards
{
    if (!_savedCards) {
        _savedCards = [[[NSUserDefaults standardUserDefaults] objectForKey:@"savedCards"] mutableCopy];
        if (!_savedCards) {
            _savedCards = [[NSMutableArray alloc] init];
        }
    }
    return _savedCards;
}
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
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary * card = [defaults objectForKey:@"businessCard"];
    self.businessCard = [[vidBusinessCard alloc] initWithJsonDictionary:card];
    SET_EQUAL_IF_STRING_NOT_EMPTY(self.youtubeLabel.text, self.businessCard.youtube);
    self.youtubeSwitch.selected = self.businessCard.isYoutubeEnabled;
    
    SET_EQUAL_IF_STRING_NOT_EMPTY(self.facebookLabel.text, self.businessCard.facebook);
    self.facebookSwitch.selected = self.businessCard.isFacebookEnabled;
    
    SET_EQUAL_IF_STRING_NOT_EMPTY(self.twitterLabel.text, self.businessCard.twitter);
    self.twitterSwitch.selected = self.businessCard.isTwitterEnabled;
    self.nameLabel.delegate = self;
    self.nameLabel.text = self.businessCard.name;
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
- (IBAction)changeTwitter:(UISwitch *)sender {
    if( sender.on) {
        __block ACAccountStore * store = [[ACAccountStore alloc] init];
        ACAccountType *accountTypeTwitter =
        [store
         accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];
        [store requestAccessToAccountsWithType:accountTypeTwitter
                         withCompletionHandler:^(BOOL granted, NSError *error) {
                             if(granted) {
                                 dispatch_sync(dispatch_get_main_queue(), ^{
                                     self.businessCard.twitter = 
                                     self.twitterLabel.text = [[[store
                                                                 accountsWithAccountType:accountTypeTwitter] objectAtIndex:0] accountDescription];
                                 });
                             }
                         }];
    }
    self.businessCard.isTwitterEnabled = sender.on;
    NSUserDefaults * defaults =[NSUserDefaults standardUserDefaults];
    [defaults setObject:[self.businessCard toDictionary] forKey:@"businessCard"];
    [defaults synchronize];
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
    } else if ([segue.destinationViewController isKindOfClass:[vidSavedCardViewController class]]) {
        vidSavedCardViewController * controller = (vidSavedCardViewController *)segue.destinationViewController;
        controller.cards = self.savedCards;
    } else if ([segue.destinationViewController isKindOfClass:[vidBumpViewController class]]) {
        vidBumpViewController * controller = (vidBumpViewController *)segue.destinationViewController;
        controller.savedCards = self.savedCards;
        controller.businessCard = self.businessCard;
    }
}
-(void)dismissModalViewControllerAnimated:(BOOL)animated
{
    [super dismissModalViewControllerAnimated:animated];
    
}
@end
