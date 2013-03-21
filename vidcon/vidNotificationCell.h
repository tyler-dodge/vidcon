//
//  vidNotificationCell.h
//  vidcon
//
//  Created by Tyler Dodge on 6/13/12.
//
//

#import <UIKit/UIKit.h>

@interface vidNotificationCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UITextView * detailsView;
@property (weak, nonatomic) IBOutlet UILabel * dateLabel;
@end
