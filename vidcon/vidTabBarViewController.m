//
//  vidTabBarViewController.m
//  vidcon
//
//  Created by Tyler Dodge on 6/8/12.
//
//

#import "vidTabBarViewController.h"

@interface vidTabBarViewController ()

@end

@implementation vidTabBarViewController

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
    //self.tabBar.tintColor = [UIColor colorWithRed:0.0 / 255.0
    //                                        green:41.0 / 255.0
    //                                         blue:100.0 / 255.0
    //                                        alpha:1.0];
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
