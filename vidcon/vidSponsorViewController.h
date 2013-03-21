//
//  vidSponsorViewController.h
//  vidcon
//
//  Created by Tyler Dodge on 5/30/12.
//
//

#import <UIKit/UIKit.h>
#import "vidSpeakerViewController.h"

@interface vidSponsorViewController : UITableViewController
@property (strong, nonatomic) NSArray * DiamondSponsors;
@property (strong, nonatomic) NSArray * PlatinumSponsors;
@property (strong, nonatomic) NSArray * GoldSponsors;
@property (strong, nonatomic) NSArray * NormalSponsors;
@end
