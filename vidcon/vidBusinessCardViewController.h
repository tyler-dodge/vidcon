//
//  vidBusinessCardViewController.h
//  vidcon
//
//  Created by Tyler Dodge on 5/30/12.
//
//

#import <UIKit/UIKit.h>
#import "vidBusinessCard.h"
@interface vidBusinessCardViewController : UITableViewController
@property (weak, nonatomic) IBOutlet UILabel *youtubeLabel;
@property (weak, nonatomic) IBOutlet UISwitch *youtubeSwitch;
@property (weak, nonatomic) IBOutlet UILabel *facebookLabel;
@property (weak, nonatomic) IBOutlet UISwitch *facebookSwitch;
@property (weak, nonatomic) IBOutlet UILabel *twitterLabel;
@property (weak, nonatomic) IBOutlet UISwitch *twitterSwitch;
@property (weak, nonatomic) IBOutlet UITextField *nameLabel;
@property (strong, nonatomic) vidBusinessCard *businessCard;
@end
