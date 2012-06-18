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

@property (strong, nonatomic) NSMutableArray * savedCards;
@property (strong, nonatomic) vidBusinessCard * businessCard;
@end
