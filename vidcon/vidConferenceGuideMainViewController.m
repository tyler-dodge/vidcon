//
//  vidConferenceGuideMainViewController.m
//  vidcon
//
//  Created by Tyler Dodge on 6/8/12.
//
//

#import "vidConferenceGuideMainViewController.h"
#define CONFERENCE_PAGE_SIZE 320
#define PAGE_COUNT 2
@interface vidConferenceGuideMainViewController () <UIScrollViewDelegate>
@end

@implementation vidConferenceGuideMainViewController
@synthesize scrollView = _scrollView;
@synthesize pageControl = _pageControl;
- (IBAction)buttonPressed:(UIButton *)sender {
    sender.alpha += 0.1;
}
- (IBAction)buttonUp:(UIButton *)sender {
    sender.alpha -= 0.1;
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
    self.scrollView.contentSize = CGSizeMake(CONFERENCE_PAGE_SIZE * 2, self.scrollView.contentSize.height);
    self.pageControl.numberOfPages = PAGE_COUNT;
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
    self.pageControl.currentPage = scrollView.contentOffset.x / CONFERENCE_PAGE_SIZE;
}

@end
