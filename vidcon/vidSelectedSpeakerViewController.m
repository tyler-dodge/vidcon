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
#define TWITTER_INDEX 1
#define WEBSITE_INDEX 2
@interface vidSelectedSpeakerViewController ()
-(void)clickedDone:(id)button;
-(void)clickedCancel:(id)button;
@end

@implementation vidSelectedSpeakerViewController
@synthesize speakerName = _speakerName;
@synthesize speakerDescriptionCell = _speakerDescriptionCell;
@synthesize webSiteName = _webSiteName;
@synthesize speakerImage = _speakerImage;
@synthesize speakerDescription = _speakerDescription;
@synthesize youtubeName = _youtubeName;
@synthesize facebookName = _facebookName;
@synthesize twitterName = _twitterName;
@synthesize speaker = _speaker;
@synthesize delegate = _delegate;

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
    [self setWebSiteName:nil];
    [super viewDidUnload];
}
-(void)clickedDone:(id)button
{
    id delegate = self.delegate;
    [delegate SelectedSpeakerView:self didAcceptWithSpeaker:self.speaker];
}
-(void)clickedCancel:(id)button
{
    id delegate = self.delegate;
    [delegate SelectedSpeakerView:self didCancelWithSpeaker:self.speaker];
}
-(void)viewDidLoad
{
    [super viewDidLoad];
    self.speakerName.text = self.speaker.name;
    self.speakerDescription.text = self.speaker.longDescription;
    self.twitterName.text = self.speaker.twitter;
    self.youtubeName.text = self.speaker.youtube;
    self.facebookName.text = self.speaker.facebook;
    self.webSiteName.text = self.speaker.webSite;
    if (self.delegate)
    {
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(clickedDone:)];
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(clickedCancel:)];
    }
    if (self.speaker.image != nil && self.speaker.hasImage) {
        self.speakerImage.image = self.speaker.image;
        self.speakerImage.layer.borderColor = [[UIColor blackColor] CGColor];
        self.speakerImage.layer.borderWidth = 1;
    } else {
        id speakerName = self.speakerName;
        [speakerName setFrame:CGRectMake(0, 0, self.speakerName.superview.frame.size.width,
                                             self.speakerName.frame.size.height)];
        self.speakerName.textAlignment = UITextAlignmentCenter;
    }
}
-(void)setSpeakerDescription:(UITextView *)speakerDescription
{
    _speakerDescription=speakerDescription;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == TWITTER_INDEX) {
        return self.speaker.twitter != nil ? 1 : 0;
    }
    if (section == WEBSITE_INDEX) {
        return self.speaker.webSite != nil ? 1 : 0;
    }
    return [super tableView:tableView numberOfRowsInSection:section];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [super tableView:tableView cellForRowAtIndexPath:indexPath];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([indexPath indexAtPosition:0] == 0 && [indexPath indexAtPosition:1]==1) {
        if (self.speakerDescription.contentSize.height == 0) {
            return 0;
        } else {
            return self.speakerDescription.contentSize.height+20;
        }
    }
    return [super tableView:tableView heightForRowAtIndexPath:indexPath];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([indexPath indexAtPosition:0] > 0) {
        NSUInteger index = [indexPath indexAtPosition:0];
        NSURL *url;
        switch (index) {
            case TWITTER_INDEX:
                url = [NSURL URLWithString:[@"http://twitter.com/" stringByAppendingString:self.speaker.twitter]];
                break;
            case WEBSITE_INDEX:
                url = [NSURL URLWithString:self.speaker.webSite];
                break;
        }
        
        [[UIApplication sharedApplication] openURL:url];
    }
}
-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return YES;
}
@end
