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
@synthesize scrollView;
@synthesize imageView;
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
	// Do any additional setup after loading the view.
}
- (void)viewDidUnload
{
    [self setImageView:nil];
    [self setScrollView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
