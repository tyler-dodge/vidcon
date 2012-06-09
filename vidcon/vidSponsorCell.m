//
//  vidSponsorCell.m
//  vidcon
//
//  Created by Tyler Dodge on 6/8/12.
//
//

#import "vidSponsorCell.h"
#import <QuartzCore/QuartzCore.h>

@implementation vidSponsorCell
@synthesize picture = _picture;
@synthesize name = _name;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setPicture:(UIImageView *)picture
{
    _picture = picture;
}
@end
