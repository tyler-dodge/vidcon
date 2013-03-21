//
//  vidBumpViewController.m
//  vidcon
//
//  Created by Tyler Dodge on 6/15/12.
//
//

#import "vidBumpViewController.h"
#import "vidBusinessCard.h"
#import "vidSelectedSpeakerViewController.h"
#import "BumpClient.h"
#import "Reachability.h"
@interface vidBumpViewController () <vidSelectedSpeakerViewControllerDelegate>
@property (nonatomic) bool isPresenting;
@property (strong, nonatomic) NSLock * presentLock;
@property (atomic) bool bumpConnected;
@property (strong, nonatomic) Reachability * reachability;
@end

@implementation vidBumpViewController
@synthesize activityIndicator = _activityIndicator;
@synthesize connectLabel = _connectLabel;
@synthesize savedCards = _savedCards;
@synthesize isPresenting = _isPresenting;
@synthesize presentLock = _presentLock;
@synthesize businessCard = _businessCard;
@synthesize bumpConnected = _bumpConnected;
@synthesize reachability = _reachability;
-(Reachability *)reachability
{
    if (!_reachability) {
        _reachability = [Reachability reachabilityWithHostname:@"www.google.com"];
    }
    return _reachability;
}
-(NSLock *)presentLock
{
    if (!_presentLock)
        _presentLock = [[NSLock alloc] init];
    return _presentLock;
}
-(void)SelectedSpeakerView:(vidSelectedSpeakerViewController *)selected didAcceptWithSpeaker:(vidSpeaker *)speaker
{
    self.isPresenting = NO;
    vidBusinessCard * card = [[vidBusinessCard alloc] init];
    card.name = speaker.name;
    card.twitter = speaker.twitter;
    [self.savedCards addObject:[card toDictionary]];
    NSUserDefaults * defaults =[NSUserDefaults standardUserDefaults];
    [defaults setObject:self.savedCards forKey:@"savedCards"];
    [defaults synchronize];
    [self dismissModalViewControllerAnimated:YES];
}
-(void)SelectedSpeakerView:(vidSelectedSpeakerViewController *)selected didCancelWithSpeaker:(vidSpeaker *)speaker
{
    self.isPresenting = NO;
    [self dismissModalViewControllerAnimated:YES];
}
- (void) configureBump {
    // userID is a string that you could use as the user's name, or an ID that is semantic within your environment
    [BumpClient configureWithAPIKey:@"" andUserID:[[UIDevice currentDevice] name]];
    
    [[BumpClient sharedClient] setMatchBlock:^(BumpChannelID channel) { 
        NSLog(@"Matched with user: %@", [[BumpClient sharedClient] userIDForChannel:channel]);
        if (self.businessCard.name.length > 0) {
            [[BumpClient sharedClient] confirmMatch:YES onChannel:channel];
        } else {
            [[BumpClient sharedClient] confirmMatch:NO onChannel:channel];
        }
    }];
    
    [[BumpClient sharedClient] setChannelConfirmedBlock:^(BumpChannelID channel) {
        NSLog(@"Channel with %@ confirmed.", [[BumpClient sharedClient] userIDForChannel:channel]);
        [[BumpClient sharedClient] sendData:[NSJSONSerialization dataWithJSONObject:[self.businessCard toSendableDictionary] options:0 error:nil]
                                  toChannel:channel];
    }];
    
    [[BumpClient sharedClient] setDataReceivedBlock:^(BumpChannelID channel, NSData *data) {
        
        [self.presentLock lock];
        bool cannotContinue = self.isPresenting;
        self.isPresenting = YES;
        [self.presentLock unlock];
        NSDictionary * received = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        if (!cannotContinue)
        {
            if ([received objectForKey:@"name"]) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.isPresenting = YES;
                    vidSelectedSpeakerViewController * selected = [self.storyboard  instantiateViewControllerWithIdentifier:@"speakerController"];
                    UINavigationController *navigationController = [[UINavigationController alloc]
                                                                    initWithRootViewController:selected];
                    selected.delegate = self;
                    selected.speaker = [[[vidBusinessCard alloc] initWithJsonDictionary:received] toVidSpeaker];
                    [self.navigationController presentModalViewController:navigationController animated:YES];
                });
            }
        }
    }];
    
    
    // optional callback
    [[BumpClient sharedClient] setConnectionStateChangedBlock:^(BOOL connected) {
        if (connected) {
            NSLog(@"Bump connected...");
            self.bumpConnected = YES;
            self.connectLabel.text = @"Ready for Bump!";
            self.activityIndicator.hidden = YES;
        } else {
            self.bumpConnected = NO;
            self.connectLabel.text = @"Connecting...";
            NSLog(@"Bump disconnected...");
        }
    }];
    
    // optional callback
    [[BumpClient sharedClient] setBumpEventBlock:^(bump_event event) {
        switch(event) {
            case BUMP_EVENT_BUMP:
                NSLog(@"Bump detected.");
                break;
            case BUMP_EVENT_NO_MATCH:
                NSLog(@"No match.");
                break;
        }
    }];
}

-(void)viewDidLoad
{
    [self.activityIndicator startAnimating];
    self.reachability.reachableBlock = ^(Reachability *reachable){
        dispatch_async(dispatch_get_current_queue(), ^{
            if (!self.bumpConnected) {
                self.connectLabel.text = @"Connecting";
                self.activityIndicator.hidden = NO;
            }
        });
    };
    self.reachability.unreachableBlock = ^(Reachability *reachable){
        dispatch_async(dispatch_get_current_queue(), ^{
            self.connectLabel.text = @"Bump requires internet Access";
            self.activityIndicator.hidden = YES;
        });
    };
    [self configureBump];
}

-(void)viewWillAppear:(BOOL)animated
{
    [self.reachability startNotifier];
    [[BumpClient sharedClient] connect];
}
-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    @try {
        [self.reachability stopNotifier];
        if (self.bumpConnected)
            [[BumpClient sharedClient] disconnect];
        NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:[self.businessCard toDictionary] forKey:@"businessCard"];
        [defaults synchronize];
    }
    @catch (NSException *exception) {    }
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)viewDidUnload {
    [self setConnectLabel:nil];
    [self setActivityIndicator:nil];
    [super viewDidUnload];
}
@end
