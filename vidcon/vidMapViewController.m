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
@synthesize defaultScale = _defaultScale;
@synthesize mapName = _mapName;
-(float)defaultScale
{
    if (!_defaultScale) {
        _defaultScale = 0.3f;
    }
    return _defaultScale;
}

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
    
    self.mapView.contentMode = UIViewContentModeLeft;
    self.mapView.frame = CGRectMake(self.mapView.frame.origin.x, self.mapView.frame.origin.y, self.mapView.image.size.width, self.mapView.image.size.height);
    self.scrollView.contentSize = self.mapView.image.size;
    self.scrollView.delegate = self;
    self.scrollView.maximumZoomScale = 1.0;
    self.scrollView.minimumZoomScale = self.defaultScale;
    self.scrollView.zoomScale = self.defaultScale;
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
