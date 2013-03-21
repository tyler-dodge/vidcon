//
//  vidConferenceEventViewController.h
//  vidcon
//
//  Created by Tyler Dodge on 6/13/12.
//
//

#import <UIKit/UIKit.h>
#import "vidConferenceEvent.h"
@interface vidConferenceEventViewController : UITableViewController

@property (strong, nonatomic) vidConferenceEvent * event;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIWebView *descriptionView;
@property (weak, nonatomic) IBOutlet UILabel *startTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *endTimeLabel;

@end
