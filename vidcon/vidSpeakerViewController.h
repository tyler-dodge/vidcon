//
//  vidSpeakerViewController.h
//  vidcon
//
//  Created by Tyler Dodge on 4/13/12.
//  Copyright (c) 2012 Sting Apps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "vidSpeakerModel.h"
@interface vidSpeakerViewController : UITableViewController
@property (strong, nonatomic) vidSpeakerModel * model;
@property (strong, nonatomic) IBOutlet UISearchDisplayController *speakerSearchController;
@property (nonatomic) bool hasImage;

@end
