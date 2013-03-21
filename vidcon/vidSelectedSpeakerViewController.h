//
//  vidSelectedSpeakerViewController.h
//  vidcon
//
//  Created by Tyler Dodge on 5/29/12.
//
//

#import <UIKit/UIKit.h>
#import "vidSpeakerModel.h"
@class vidSelectedSpeakerViewController;
@protocol vidSelectedSpeakerViewControllerDelegate <NSObject>
@optional
-(void)SelectedSpeakerView:(vidSelectedSpeakerViewController *)selected
      didCancelWithSpeaker:(vidSpeaker *)speaker;
@optional
-(void)SelectedSpeakerView:(vidSelectedSpeakerViewController *)selected
      didAcceptWithSpeaker:(vidSpeaker *)speaker;
@end
@interface vidSelectedSpeakerViewController : UITableViewController
@property (weak, nonatomic) IBOutlet UITextView *speakerDescription;
@property (weak, nonatomic) IBOutlet UILabel *youtubeName;
@property (weak, nonatomic) IBOutlet UILabel *facebookName;
@property (weak, nonatomic) IBOutlet UILabel *twitterName;
@property (weak, nonatomic) IBOutlet UIImageView *speakerImage;
@property (weak, nonatomic) IBOutlet UILabel *speakerName;
@property (weak, nonatomic) IBOutlet UITableViewCell *speakerDescriptionCell;
@property (weak, nonatomic) IBOutlet UILabel *webSiteName;
@property (weak, nonatomic) id<vidSelectedSpeakerViewControllerDelegate> delegate;

@property (strong, nonatomic) vidSpeaker * speaker;
@end
