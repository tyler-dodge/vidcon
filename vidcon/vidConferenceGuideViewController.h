//
//  vidConferenceGuideViewController.h
//  vidcon
//
//  Created by Tyler Dodge on 4/24/12.
//
//

#import <UIKit/UIKit.h>
#import "vidEventTimeSlotHeader.h"
@interface vidConferenceGuideViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIScrollView *eventScrollView;
@property (weak, nonatomic) IBOutlet vidEventTimeSlotHeader *eventHeader;

@end
