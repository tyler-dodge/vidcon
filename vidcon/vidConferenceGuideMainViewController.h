//
//  vidConferenceGuideMainViewController.h
//  vidcon
//
//  Created by Tyler Dodge on 6/8/12.
//
//

#import <UIKit/UIKit.h>

@interface vidConferenceGuideMainViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property (weak, nonatomic) IBOutlet UIButton *firstFloorButton;
@property (weak, nonatomic) IBOutlet UIButton *secondFloorButton;
@property (weak, nonatomic) IBOutlet UIButton *parkingGuide;
@property (weak, nonatomic) IBOutlet UIButton *hotels;
@property (weak, nonatomic) IBOutlet UIButton *booths;
@property (weak, nonatomic) IBOutlet UIButton *thirdFloorButton;
@property (weak, nonatomic) IBOutlet UIButton *secondHotelFloor;

@end
