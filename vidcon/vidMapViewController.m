//
//  vidMapViewController.m
//  vidcon
//
//  Created by Tyler Dodge on 6/13/12.
//
//

#import "vidMapViewController.h"

@interface vidMapViewController () <UIScrollViewDelegate>

@end

@implementation vidMapViewController
@synthesize mapView = _mapView;
@synthesize scrollView = _scrollView;
@synthesize image = _image;

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
    self.mapView.image = self.image;
    [self.mapView sizeToFit];
    self.scrollView.contentSize = self.mapView.frame.size;
    self.scrollView.delegate = self;
    self.scrollView.maximumZoomScale = 1.0;
    self.scrollView.minimumZoomScale = 0.3;
    self.scrollView.zoomScale = 0.3;
    self.navigationItem.title = self.mapName;
}
-(void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(float)scale
{
    
}
-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.mapView;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)viewDidUnload {
    [self setMapView:nil];
    [self setScrollView:nil];
    [super viewDidUnload];
}
@end
