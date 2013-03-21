//
//  vidSelectedSponsorViewController.m
//  vidcon
//
//  Created by Tyler Dodge on 6/9/12.
//
//

#import "vidSelectedSponsorViewController.h"

@interface vidSelectedSponsorViewController ()

@end

@implementation vidSelectedSponsorViewController
@synthesize scrollView =_scrollView;
@synthesize imageView = _imageView;
@synthesize websiteButton = _websiteButton;
@synthesize twitterButton = _twitterButton;
@synthesize sponsor = _sponsor;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.scrollView.contentSize = self.sponsor.descriptionImage.size;
    self.imageView.frame = CGRectMake(0, 0, self.scrollView.contentSize.width, self.scrollView.contentSize.height);
    self.imageView.image = self.sponsor.descriptionImage;
    if ([self.sponsor.webSite isEqualToString:@""]) {
        id websiteButton = self.websiteButton;
        [websiteButton removeFromSuperview];
        self.twitterButton.center = CGPointMake(self.twitterButton.superview.frame.size.width / 2, self.twitterButton.center.y);
    }
    if ([self.sponsor.twitter isEqualToString:@""]) {
        id twitterButton = self.twitterButton;
        [twitterButton removeFromSuperview];
        self.websiteButton.center = CGPointMake(self.websiteButton.superview.frame.size.width / 2, self.websiteButton.center.y);
    }
	// Do any additional setup after loading the view.
}
- (void)viewDidUnload
{
    [self setImageView:nil];
    [self setScrollView:nil];
    [self setWebsiteButton:nil];
    [self setTwitterButton:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
- (IBAction)clickedTwitter:(UIButton *)sender {
    NSURL * url = [NSURL URLWithString:[@"http://twitter.com/" stringByAppendingString:self.sponsor.twitter]];
    [[UIApplication sharedApplication] openURL:url];
}
- (IBAction)clickedWebSite:(UIButton *)sender {
    NSURL * url = [NSURL URLWithString:self.sponsor.webSite];
    [[UIApplication sharedApplication] openURL:url];
}

@end
