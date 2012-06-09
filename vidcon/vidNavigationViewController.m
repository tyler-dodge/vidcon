//
//  vidNavigationViewController.m
//  vidcon
//
//  Created by Tyler Dodge on 6/8/12.
//
//

#import "vidNavigationViewController.h"

@interface vidNavigationViewController ()

@end

@implementation vidNavigationViewController

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
    self.navigationBar.tintColor = [UIColor colorWithRed:111.0 / 255.0
                                                   green:172.0 / 255.0
                                                    blue:211.0 / 255.0
                                                   alpha:1.0];
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}
@end
