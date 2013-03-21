//
//  vidConferenceGuideViewController.h
//  vidcon
//
//  Created by Tyler Dodge on 4/24/12.
//
//

#import <UIKit/UIKit.h>
#import "vidEventTimeSlotHeader.h"
#import "vidConferenceGuide.h"
#define VIDCON_START_DATE 1340895600 //June 28, 2012 8:00 AM PDT
@interface vidConferenceGuideViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIScrollView *eventScrollView;
@property (strong, nonatomic) IBOutlet vidEventTimeSlotHeader *eventHeader;
@property (strong, nonatomic) vidConferenceGuide * model;
@property (nonatomic) NSTimeInterval startTimeSinceMinimum;
@end
