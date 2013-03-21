//
//  vidBumpViewController.h
//  vidcon
//
//  Created by Tyler Dodge on 6/15/12.
//
//

#import <UIKit/UIKit.h>
#import "vidBusinessCard.h"

@interface vidBumpViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (weak, nonatomic) IBOutlet UILabel *connectLabel;
@property (strong, nonatomic) NSMutableArray * savedCards;
@property (strong, nonatomic) vidBusinessCard * businessCard;
@end
