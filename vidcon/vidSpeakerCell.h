//
//  vidSpeakerCell.h
//  vidcon
//
//  Created by Tyler Dodge on 4/13/12.
//  Copyright (c) 2012 Sting Apps. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface vidSpeakerCell : UITableViewCell
@property (weak,nonatomic) IBOutlet UITextView * descriptionLabel;
@property (weak,nonatomic) IBOutlet UILabel * nameLabel;
@property (weak,nonatomic) IBOutlet UIImageView * picture;
@end
