//
//  vidSelectedSpeakerViewController.h
//  vidcon
//
//  Created by Tyler Dodge on 5/29/12.
//
//

#import <UIKit/UIKit.h>
#import "vidSpeakerModel.h"
@interface vidSelectedSpeakerViewController : UITableViewController
@property (weak, nonatomic) IBOutlet UITextView *speakerDescription;
@property (weak, nonatomic) IBOutlet UILabel *youtubeName;
@property (weak, nonatomic) IBOutlet UILabel *facebookName;
@property (weak, nonatomic) IBOutlet UILabel *twitterName;
@property (weak, nonatomic) IBOutlet UIImageView *speakerImage;
@property (weak, nonatomic) IBOutlet UILabel *speakerName;
@property (weak, nonatomic) IBOutlet UITableViewCell *speakerDescriptionCell;

@property (strong, nonatomic) vidSpeaker * speaker;
@end
