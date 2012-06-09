//
//  vidConferenceGuideMainViewController.m
//  vidcon
//
//  Created by Tyler Dodge on 6/8/12.
//
//

#import "vidConferenceGuideMainViewController.h"
#define PAGE_SIZE 320
@interface vidConferenceGuideMainViewController () <UIScrollViewDelegate>

@end

@implementation vidConferenceGuideMainViewController
@synthesize scrollView = _scrollView;
@synthesize pageControl = _pageControl;

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
    self.scrollView.contentSize = CGSizeMake(PAGE_SIZE * 2, self.scrollView.contentSize.height);
}

- (void)viewDidUnload
{
    [self setScrollView:nil];
    [self setPageControl:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}
-(void)setPageControl:(UIPageControl *)pageControl
{
    _pageControl = pageControl;
}
-(void)setScrollView:(UIScrollView *)scrollView
{
    _scrollView = scrollView;
    _scrollView.delegate = self;
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    self.pageControl.currentPage = scrollView.contentOffset.x / PAGE_SIZE;
}

@end
