//
//  vidSelectedSponsorViewController.h
//  vidcon
//
//  Created by Tyler Dodge on 6/9/12.
//
//

#import <UIKit/UIKit.h>
#import "vidSponsor.h"

@interface vidSelectedSponsorViewController : UIViewController
@property (strong, nonatomic) vidSponsor * sponsor;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIButton *websiteButton;
@property (weak, nonatomic) IBOutlet UIButton *twitterButton;
@end
